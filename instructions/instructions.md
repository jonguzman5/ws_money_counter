**Money Counter App - Core Functionality Implementation Guide**

### 1. Overview
1.1 **Purpose:** Provide an ultra-fast, error-proof way to count cash (bills & coins) by letting users enter denominations and instantly viewing a running total.
1.2 **Scope:** Implements the core counting flow: denomination input, live total calculation, clear, and share.

### 2. File Structure
MoneyCounterApp/
MoneyCounterApp.swift
Assets. cassets
LaunchScreen.storyboard
Models/
_ Denomination.swift
ViewModels/
— CountViewModel. swift
Views/
- MainCountView. swift
QuantityEntryView.swift
ToastView.swift
Services/
- CalculationService.swift
- PersistenceService.swift
- Utilities/
_ HapticsManager.swift
# Xcode project root
# App entry point (SwiftUI App)
# Icons, colors, images
# Optional launch UI
# Denomination model & value mapping
# Business logic & bindings for counting
# Core count screen UI
# Direct-entry modal UI
# Reusable toast for undo/clear feedback
# Total calculation logic
# (Placeholder) optional save/export logic
# Haptic feedback helper

### 3. Core Functionalities & Pages

#### 3.1 Main Count Screen
**Files:** "MainCountView.swift', 'CountViewModel.swift', 'CalculationService.swift*, 'ToastView.swift*

1. **UI Layout**（MainCountView'）
* Header: displays live total ('@ObservedObject viewModel. total') with large font.
* Denomination grid/list: iterates 'viewModel.denominations'.
* Each cell has "-" button, quantity label, "+" button.
* Clear & Share buttons in navigation bar.

2. **ViewModel** ('CountViewModel' )
* Publishes ' [Denomination)',
'total: Decimal', and toast state.
* Handles increment/decrement actions by updating model and recomputing total.

3. **Calculation** ('CalculationService')
* Exposes |
'func computeTotal (from: [Denomination]) → Decimal'.
* Used by ViewModel on every change.

4. **Feedback** (HapticsManager' & 'ToastView*)
* Triggers light haptic on each increment/decrement.
* Shows dismissible toast on 'clearAll() with "Undo" action.
*we 352 Quantity Entry Modal

**Files:** 'QuantityEntryView.swift', 'CountViewModel.swift*

1. **UI Layout** (QuantityEntryView')
* Title showing selected denomination.
* Text field bound to a '@State' count value.
* Numeric keypad (SwiftUl keyboardType: • numberPad* ).
* "Done" & "Cancel" toolbar buttons.

2. **Behavior**
* On "Done": validate count ≥ 0 - call 'viewModel. updateQuantity(at: index, to: newValue) - dismiss.
* On "Cancel": dismiss without changes.