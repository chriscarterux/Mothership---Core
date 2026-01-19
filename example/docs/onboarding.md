# User Onboarding Flow

## Overview

New users need a smooth onboarding experience that introduces them to Camino and helps them choose the right program.

## User Journey

1. **Welcome Screen**
   - Headline: "Begin Your Journey"
   - Brief explanation of Camino's approach
   - CTA: "Get Started"

2. **Program Selection**
   - Show 3 program cards:
     - Discover: $9.95/mo - "Gentle self-awareness"
     - Journey: $39.95/mo - "Deep philosophical inquiry"  
     - The Camino Method: $1,997 - "Complete transformation"
   - Each card shows: price, duration, key benefit
   - User selects one

3. **Initial Assessment**
   - 5 simple questions about current state:
     - "How would you describe your sense of identity right now?"
     - "What's your relationship with uncertainty?"
     - "How connected do you feel to others?"
     - "What brought you to Camino today?"
     - "What's one thing you'd like to understand better about yourself?"
   - Text input for each
   - Responses stored for AI personalization

4. **First Reflection**
   - Based on assessment, generate personalized first prompt
   - Show the reflection interface
   - User completes their first entry
   - Celebration/confirmation screen

## Technical Requirements

- **Routes:**
  - `/onboarding` - Welcome screen
  - `/onboarding/programs` - Program selection
  - `/onboarding/assessment` - Initial questions
  - `/onboarding/first-reflection` - First prompt

- **Components:**
  - `WelcomeHero` - Welcome screen content
  - `ProgramCard` - Individual program display
  - `ProgramSelector` - Grid of program cards
  - `AssessmentForm` - Multi-step question form
  - `ReflectionPrompt` - AI-generated prompt display

- **Data:**
  - Store selected program in user profile
  - Store assessment responses
  - Generate first prompt via AI

## Acceptance Criteria

- [ ] User can navigate through all 4 steps
- [ ] Program selection is saved
- [ ] Assessment responses are stored
- [ ] First reflection prompt is personalized
- [ ] User ends up on main dashboard after completion
- [ ] Progress is saved if user leaves mid-flow
- [ ] Mobile responsive

## Out of Scope

- Payment processing (handled separately)
- Email verification (handled by auth)
- Program content delivery (separate feature)
