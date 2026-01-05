---
description: Verify feature follows Design Philosophy & Psychology Principles
---

# 🎨 Design Compliance Checklist

Before implementing ANY feature, verify it follows README.md Design Philosophy:

---

## ✅ Ergonomic Design Checklist

### 1. Thumb-First Optimization
- [ ] Is the feature optimized for one-handed use?
- [ ] Are primary actions in the "thumb zone" (bottom 1/3 of screen)?
- [ ] Does it respect `HandPreference` setting (left/right)?

### 2. Fitts's Law (Large Targets)
- [ ] Are tap targets at least 48dp (preferably 56dp)?
- [ ] Are frequently-used buttons in easy-reach zones?
- [ ] Is there sufficient spacing between tappable elements?

### 3. Hand Preference
- [ ] Does the UI adapt to left/right hand mode if applicable?
- [ ] Are important buttons accessible from preferred hand side?
- [ ] Can user comfortably reach all interactive elements?

### 4. Haptic Feedback
- [ ] Does the feature provide tactile feedback on key actions?
- [ ] Using `HapticFeedback.lightImpact()` for small actions?
- [ ] Using `HapticFeedback.mediumImpact()` for medium actions?
- [ ] Using `HapticFeedback.heavyImpact()` for major actions (achievements, unlocks)?

---

## ✅ Psychology-Driven Checklist

### 1. Variable Rewards
- [ ] Does the feature include any random/surprise elements?
- [ ] Can users receive unexpected bonuses or rewards?
- [ ] Is there variability in outcomes to create engagement?

**Example:** Random achievement unlock, surprise vote bonus

### 2. Social Proof
- [ ] Does the feature show what others are doing?
- [ ] Are there indicators like "3 friends voted on this"?
- [ ] Can users see popular/trending content?

**Example:** Show friend activity, display vote counts prominently

### 3. FOMO (Fear of Missing Out)
- [ ] Does the feature create urgency?
- [ ] Are there time-limited events or content?
- [ ] Are there trending indicators or countdowns?

**Example:** "Trending now", "Ends in 2 hours", limited-time achievements

### 4. Gamification
- [ ] Does the feature include progress tracking?
- [ ] Are there achievements, levels, or XP?
- [ ] Is there a sense of advancement or mastery?

**Example:** Progress bars, unlock achievements, level up

### 5. Scarcity
- [ ] Does the feature leverage limited availability?
- [ ] Are resources constrained (vote capacity, daily limits)?
- [ ] Does scarcity increase perceived value?

**Example:** Daily vote limits, exclusive content, limited slots

### 6. Reciprocity
- [ ] Does the feature encourage giving to receive?
- [ ] Are there rewards for helping others?
- [ ] Is there a mutual benefit system?

**Example:** Referral rewards, vote trading, friend bonuses

### 7. Network Effect
- [ ] Does the feature become more valuable with more users?
- [ ] Does it encourage inviting friends?
- [ ] Does user growth improve the experience?

**Example:** More friends = better feed, larger voting pool

---

## ✅ Visual Design Checklist

### 1. Material Design 3
- [ ] Does the feature use MD3 components?
- [ ] Is it consistent with the rest of the app?
- [ ] Are colors from the app theme used?

### 2. Color Psychology
- [ ] Are colors used strategically (red for urgent, green for success)?
- [ ] Do gradients enhance the experience (not just decoration)?
- [ ] Does color guide user attention appropriately?

**Example:** Red for vote limits, green for achievements, gradients for premium

### 3. Microinteractions
- [ ] Are there delightful animations on key actions?
- [ ] Do transitions feel smooth and purposeful?
- [ ] Is feedback immediate and satisfying?

**Example:** Button ripple, vote animation, unlock celebration

### 4. Progressive Disclosure
- [ ] Is information revealed when needed (not all at once)?
- [ ] Are advanced features hidden until relevant?
- [ ] Can users expand to see more details?

**Example:** Collapsible sections, "Show more", expandable cards

---

## 🚨 Red Flags (DO NOT IMPLEMENT IF ANY ARE TRUE)

- ❌ Feature requires two hands to use comfortably
- ❌ Tap targets smaller than 48dp
- ❌ No haptic feedback on major actions
- ❌ No psychology principles applied (just functional)
- ❌ Looks inconsistent with existing app design
- ❌ No visual feedback on user actions
- ❌ All information shown at once (overwhelming)

---

## ✅ Good Example: Vote Button

```dart
// ✅ Ergonomics: Large target (56dp), thumb-first
// ✅ Psychology: Variable rewards (random bonus), scarcity (limited votes)
// ✅ Visual: Microinteraction (animation), color psychology (gradient)
// ✅ Haptic: Tactile feedback on tap

GestureDetector(
  onTap: () {
    HapticFeedback.mediumImpact(); // ✅ Ergonomics

    // ✅ Psychology: Variable Rewards (30% chance)
    if (Random().nextDouble() < 0.3) {
      showBonus('Double Vote Power!'); // ✅ FOMO
    }

    voteOnPost(); // Core functionality
  },
  child: Container(
    width: 56, height: 56, // ✅ Ergonomics: Fitts's Law
    decoration: BoxDecoration(
      gradient: voteGradient, // ✅ Visual: Color psychology
    ),
    child: AnimatedIcon(...), // ✅ Visual: Microinteraction
  ),
)
```

---

## ❌ Bad Example: Settings Toggle

```dart
// ❌ No haptic feedback
// ❌ No psychology principles
// ❌ Generic design, no color strategy
// ❌ Tap target too small (40dp)

Switch(
  value: enabled,
  onChanged: (val) => setState(() => enabled = val),
)
```

**How to fix:**
- Add `HapticFeedback.lightImpact()` on toggle
- Use color psychology (green = on, grey = off)
- Increase tap target size
- Show immediate visual feedback

---

## 📋 Before Implementation

**Ask yourself:**
1. Which ergonomic principles does this feature follow?
2. Which psychology principles can I apply?
3. Does the visual design enhance the experience?
4. Will users find this delightful, not just functional?

**If you can't answer these questions positively, revisit the design!**

---

## 📊 Quick Reference: Psychology Principles

| Principle | Example Implementation |
|-----------|------------------------|
| **Variable Rewards** | Random achievement unlock, surprise bonus votes |
| **Social Proof** | "3 friends voted", "Trending with 1.2k votes" |
| **FOMO** | "Ends in 2 hours", "Only 5 spots left" |
| **Gamification** | XP progress bar, unlock levels, achievements |
| **Scarcity** | Daily vote limits, exclusive content |
| **Reciprocity** | Referral rewards, vote trading |
| **Network Effect** | More friends = better feed, larger voting pool |

---

**Remember:** Every feature should feel **ergonomic, psychological, and delightful!**

If it's just functional without these principles, it doesn't belong in Votzy. 🎨
