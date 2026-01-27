#!/bin/bash
# verify-docker.sh - Verify Docker containers build and run
# Exit code 1 = issues found, 0 = clean
# Run in CI to catch containers that build but crash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOCKERFILE="${1:-Dockerfile}"
IMAGE_NAME="${2:-ci-test-image}"
CONTAINER_NAME="${3:-ci-test-container}"
WAIT_TIME="${4:-30}"
HEALTH_ENDPOINT="${5:-/health}"
PORT="${6:-3000}"

echo "╔════════════════════════════════════════════╗"
echo "║         DOCKER VERIFICATION                ║"
echo "╚════════════════════════════════════════════╝"
echo ""

cleanup() {
    echo "Cleaning up..."
    docker stop "$CONTAINER_NAME" 2>/dev/null || true
    docker rm "$CONTAINER_NAME" 2>/dev/null || true
    docker rmi "$IMAGE_NAME" 2>/dev/null || true
}

trap cleanup EXIT

# Check Dockerfile exists
if [[ ! -f "$DOCKERFILE" ]]; then
    echo -e "${YELLOW}⚠️  No Dockerfile found, skipping Docker verification${NC}"
    exit 0
fi

# Build image
echo "Building Docker image..."
if ! docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" . ; then
    echo -e "${RED}❌ Docker build failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Image built successfully${NC}"

# Run container
echo "Starting container..."
CONTAINER_ID=$(docker run -d --name "$CONTAINER_NAME" -p "$PORT:$PORT" "$IMAGE_NAME")
echo "Container ID: $CONTAINER_ID"

# Wait for startup
echo "Waiting ${WAIT_TIME}s for container to start..."
sleep "$WAIT_TIME"

# Check if container is still running
if ! docker ps -q -f name="$CONTAINER_NAME" | grep -q .; then
    echo -e "${RED}❌ Container exited unexpectedly${NC}"
    echo ""
    echo "Container logs:"
    docker logs "$CONTAINER_NAME" 2>&1 | tail -50
    exit 1
fi
echo -e "${GREEN}✓ Container running${NC}"

# Check container health
CONTAINER_STATUS=$(docker inspect --format='{{.State.Status}}' "$CONTAINER_NAME")
if [[ "$CONTAINER_STATUS" != "running" ]]; then
    echo -e "${RED}❌ Container status: $CONTAINER_STATUS${NC}"
    exit 1
fi

# Check health endpoint
echo "Checking health endpoint..."
HEALTH_RESPONSE=$(docker exec "$CONTAINER_NAME" curl -sf "http://localhost:$PORT$HEALTH_ENDPOINT" 2>/dev/null || echo "FAILED")

if [[ "$HEALTH_RESPONSE" == "FAILED" ]]; then
    echo -e "${YELLOW}⚠️  Health endpoint not responding (may not be implemented)${NC}"
    # Try alternative health check
    if docker exec "$CONTAINER_NAME" curl -sf "http://localhost:$PORT/" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Root endpoint responding${NC}"
    else
        echo -e "${RED}❌ No endpoints responding${NC}"
        echo ""
        echo "Container logs:"
        docker logs "$CONTAINER_NAME" 2>&1 | tail -30
        exit 1
    fi
else
    echo -e "${GREEN}✓ Health endpoint responding${NC}"
    echo "Response: $HEALTH_RESPONSE"
fi

# Check for error logs
echo "Checking for errors in logs..."
ERROR_COUNT=$(docker logs "$CONTAINER_NAME" 2>&1 | grep -ci "error\|fatal\|exception" || echo "0")
if [[ "$ERROR_COUNT" -gt 5 ]]; then
    echo -e "${YELLOW}⚠️  Found $ERROR_COUNT potential errors in logs${NC}"
    docker logs "$CONTAINER_NAME" 2>&1 | grep -i "error\|fatal\|exception" | tail -10
fi

echo ""
echo "════════════════════════════════════════════"
echo -e "${GREEN}PASSED: Docker verification complete${NC}"
echo ""
echo "Summary:"
echo "  • Image builds: ✓"
echo "  • Container runs: ✓ (${WAIT_TIME}s+)"
echo "  • Health check: ✓"
exit 0
