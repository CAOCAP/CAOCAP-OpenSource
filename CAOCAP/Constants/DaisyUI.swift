//
//  DaisyUI.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 15/08/2024.
//

import Foundation

enum Daisy: String {
    case none
    
    // Colors
    case background = "Background"
    case gradient = "Gradient"
    case textColors = "Text Colors"
    case placeholderColors = "Placeholder Colors"
    case borderColors = "Border Colors"
    case ringColors = "Ring Colors"
    case divideColors = "Divide Colors"
    case outlineColors = "Outline Colors"
    case fillColors = "Fill Colors"
    case caretColors = "Caret Colors"
    case strokeColors = "Stroke Colors"
    case accentColors = "Accent Colors"
    case shadowColors = "Shadow Colors"
    case decorationColors = "Decoration Colors"
    
    // Utility
    // TODO: - I think the list is not complete
    case glass = "Glass"
    
    // Actions
    case button = "Button"
    case dropdown = "Dropdown"
    case modal = "Modal"
    case swap = "Swap"
    case themeController = "Theme Controller"
    
    // Data Display
    case collapse = "Collapse"
    case avatar = "Avatar"
    case badge = "Badge"
    case card = "Card"
    case carousel = "Carousel"
    case chatBubble = "Chat Bubble"
    case countdown = "Countdown"
    case diff = "Diff"
    case kbd = "Kbd"
    case stat = "Stat"
    case table = "Table"
    case timeline = "Timeline"
    
    // Navigation
    case breadcrumbs = "Breadcrumbs"
    case interactionStates = "Interaction States"
    case bottomNavigation = "Bottom Navigation"
    case link = "Link"
    case menu = "Menu"
    case navbar = "Navbar"
    case steps = "Steps"
    case tab = "Tab"
    
    // Feedback
    case alert = "Alert"
    case loading = "Loading"
    case progress = "Progress"
    case radialProgress = "Radial Progress"
    case skeleton = "Skeleton"
    case toast = "Toast"
    case tooltip = "Tooltip"
    
    // Data Input
    case formControl = "Form Control"
    case checkbox = "Checkbox"
    case fileInput = "File Input"
    case radio = "Radio"
    case range = "Range"
    case rating = "Rating"
    case select = "Select"
    case textInput = "Text Input"
    case textarea = "Textarea"
    case toggle = "Toggle"
    
    // Layout
    case artboard = "Artboard"
    case divider = "Divider"
    case drawer = "Drawer"
    case footer = "Footer"
    case hero = "Hero"
    case indicator = "Indicator"
    case join = "Join (group items)"
    case mask = "Mask"
    case stack = "Stack"
    
    // Mockup
    case browser = "Browser"
    case code = "Code"
    case phone = "Phone"
    case window = "Window"
}


struct DaisyUI {
    
    static let all: [ClassNameTuple] = [
        (name: .Daisy(.background), array: background),
        (name: .Daisy(.gradient), array: gradients),
        (name: .Daisy(.textColors), array: textColors),
        (name: .Daisy(.placeholderColors), array: placeholderColors),
        (name: .Daisy(.borderColors), array: borderColors),
        (name: .Daisy(.ringColors), array: ringColors),
        (name: .Daisy(.divideColors), array: divideColors),
        (name: .Daisy(.outlineColors), array: outlineColors),
        (name: .Daisy(.fillColors), array: fillColors),
        (name: .Daisy(.caretColors), array: caretColors),
        (name: .Daisy(.strokeColors), array: strokeColors),
        (name: .Daisy(.accentColors), array: accentColors),
        (name: .Daisy(.shadowColors), array: shadowColors),
        (name: .Daisy(.decorationColors), array: decorationColors),
        (name: .Daisy(.glass), array: glass),
        
        (name: .Daisy(.button), array: button),
        (name: .Daisy(.dropdown), array: dropdown),
        (name: .Daisy(.modal), array: modal),
        (name: .Daisy(.swap), array: swap),
        (name: .Daisy(.themeController), array: themeController),
        (name: .Daisy(.collapse), array: collapse),
        (name: .Daisy(.avatar), array: avatar),
        (name: .Daisy(.badge), array: badge),
        (name: .Daisy(.card), array: card),
        (name: .Daisy(.carousel), array: carousel),
        (name: .Daisy(.chatBubble), array: chatBubble),
        (name: .Daisy(.countdown), array: countdown),
        (name: .Daisy(.diff), array: diff),
        (name: .Daisy(.kbd), array: kbd),
        (name: .Daisy(.stat), array: stat),
        (name: .Daisy(.table), array: table),
        (name: .Daisy(.timeline), array: timeline),
        (name: .Daisy(.breadcrumbs), array: breadcrumbs),
        (name: .Daisy(.interactionStates), array: interactionStates),
        (name: .Daisy(.bottomNavigation), array: bottomNavigation),
        (name: .Daisy(.link), array: link),
        (name: .Daisy(.menu), array: menu),
        (name: .Daisy(.navbar), array: navbar),
        (name: .Daisy(.steps), array: steps),
        (name: .Daisy(.tab), array: tab),
        (name: .Daisy(.alert), array: alert),
        (name: .Daisy(.loading), array: loading),
        (name: .Daisy(.progress), array: progress),
        (name: .Daisy(.radialProgress), array: radialProgress),
        (name: .Daisy(.skeleton), array: skeleton),
        (name: .Daisy(.toast), array: toast),
        (name: .Daisy(.tooltip), array: tooltip),
        (name: .Daisy(.formControl), array: formControl),
        (name: .Daisy(.checkbox), array: checkbox),
        (name: .Daisy(.fileInput), array: fileInput),
        (name: .Daisy(.radio), array: radio),
        (name: .Daisy(.range), array: range),
        (name: .Daisy(.rating), array: rating),
        (name: .Daisy(.select), array: select),
        (name: .Daisy(.textInput), array: textInput),
        (name: .Daisy(.textarea), array: textarea),
        (name: .Daisy(.toggle), array: toggle),
        (name: .Daisy(.artboard), array: artboard),
        (name: .Daisy(.divider), array: divider),
        (name: .Daisy(.drawer), array: drawer),
        (name: .Daisy(.footer), array: footer),
        (name: .Daisy(.hero), array: hero),
        (name: .Daisy(.indicator), array: indicator),
        (name: .Daisy(.join), array: join),
        (name: .Daisy(.mask), array: mask),
        (name: .Daisy(.stack), array: stack),
        (name: .Daisy(.browser), array: browser),
        (name: .Daisy(.code), array: code),
        (name: .Daisy(.phone), array: phone),
        (name: .Daisy(.window), array: window)
    ]
    
    // MARK: Colors
    
    /* background */
    static let background = ["bg-primary","bg-primary-content","bg-secondary","bg-secondary-content","bg-accent","bg-accent-content","bg-neutral","bg-neutral-content","bg-base-100","bg-base-200","bg-base-300","bg-base-content","bg-info","bg-info-content","bg-success","bg-success-content","bg-warning","bg-warning-content","bg-error","bg-error-content"]
    
    /* gradients */
    static let gradients = ["from-primary", "from-secondary", "from-accent", "from-neutral", "from-base-100", "from-base-200", "from-base-300", "from-info", "from-success", "from-warning", "from-error", "via-primary", "via-secondary", "via-accent", "via-neutral", "via-base-100", "via-base-200", "via-base-300", "via-info", "via-success", "via-warning", "via-error", "to-primary", "to-secondary", "to-accent", "to-neutral", "to-base-100", "to-base-200", "to-base-300", "to-info", "to-success", "to-warning", "to-error"]
    
    /* textColors */
    static let textColors = ["text-primary", "text-secondary", "text-accent", "text-neutral", "text-base-100", "text-base-200", "text-base-300", "text-info", "text-success", "text-warning", "text-error"]
    
    /* placeholderColors */
    static let placeholderColors = ["placeholder-primary", "placeholder-secondary", "placeholder-accent", "placeholder-neutral", "placeholder-base-100", "placeholder-base-200", "placeholder-base-300", "placeholder-info", "placeholder-success", "placeholder-warning", "placeholder-error"]
    
    /* borderColors */
    static let borderColors = ["border-primary", "border-secondary", "border-accent", "border-neutral", "border-base-100", "border-base-200", "border-base-300", "border-info", "border-success", "border-warning", "border-error"]
    
    /* ringColors */
    static let ringColors = ["ring-primary", "ring-secondary", "ring-accent", "ring-neutral", "ring-base-100", "ring-base-200", "ring-base-300", "ring-info", "ring-success", "ring-warning", "ring-error"]
    
    /* divideColors */
    static let divideColors = ["divide-primary", "divide-secondary", "divide-accent", "divide-neutral", "divide-base-100", "divide-base-200", "divide-base-300", "divide-info", "divide-success", "divide-warning", "divide-error"]
    
    /* outlineColors */
    static let outlineColors = ["outline-primary", "outline-secondary", "outline-accent", "outline-neutral", "outline-base-100", "outline-base-200", "outline-base-300", "outline-info", "outline-success", "outline-warning", "outline-error"]
    
    /* fillColors */
    static let fillColors = ["fill-primary", "fill-secondary", "fill-accent", "fill-neutral", "fill-base-100", "fill-base-200", "fill-base-300", "fill-info", "fill-success", "fill-warning", "fill-error"]
    
    /* caretColors */
    static let caretColors = ["caret-primary", "caret-secondary", "caret-accent", "caret-neutral", "caret-base-100", "caret-base-200", "caret-base-300", "caret-info", "caret-success", "caret-warning", "caret-error"]
    
    /* strokeColors */
    static let strokeColors = ["stroke-primary", "stroke-secondary", "stroke-accent", "stroke-neutral", "stroke-base-100", "stroke-base-200", "stroke-base-300", "stroke-info", "stroke-success", "stroke-warning", "stroke-error"]
    
    /* accentColors */
    static let accentColors = ["accent-primary", "accent-secondary", "accent-accent", "accent-neutral", "accent-base-100", "accent-base-200", "accent-base-300", "accent-info", "accent-success", "accent-warning", "accent-error"]
    
    /* shadowColors */
    static let shadowColors = ["shadow-primary", "shadow-secondary", "shadow-accent", "shadow-neutral", "shadow-base-100", "shadow-base-200", "shadow-base-300", "shadow-info", "shadow-success", "shadow-warning", "shadow-error"]
    
    /* decorationColors */
    static let decorationColors = ["decoration-primary", "decoration-secondary", "decoration-accent", "decoration-neutral", "decoration-base-100", "decoration-base-200", "decoration-base-300", "decoration-info", "decoration-success", "decoration-warning", "decoration-error"]
    
    
    // MARK: Utility
    
    /* Border Radius */
    static let borderRadius = [
        "rounded-box", "rounded-btn", "rounded-badge",
        "rounded-s-box", "rounded-s-btn", "rounded-s-badge",
        "rounded-e-box", "rounded-e-btn", "rounded-e-badge",
        "rounded-t-box", "rounded-t-btn", "rounded-t-badge",
        "rounded-r-box", "rounded-r-btn", "rounded-r-badge",
        "rounded-b-box", "rounded-b-btn", "rounded-b-badge",
        "rounded-l-box", "rounded-l-btn", "rounded-l-badge",
        "rounded-ss-box", "rounded-ss-btn", "rounded-ss-badge",
        "rounded-se-box", "rounded-se-btn", "rounded-se-badge",
        "rounded-ee-box", "rounded-ee-btn", "rounded-ee-badge",
        "rounded-es-box", "rounded-es-btn", "rounded-es-badge",
        "rounded-tl-box", "rounded-tl-btn", "rounded-tl-badge",
        "rounded-tr-box", "rounded-tr-btn", "rounded-tr-badge",
        "rounded-br-box", "rounded-br-btn", "rounded-br-badge",
        "rounded-bl-box", "rounded-bl-btn", "rounded-bl-badge"
    ]
    
    
    /* glass */
    static let glass = ["glass"]
    
    
    // MARK: Actions
    
    /* button */
    static let button = ["btn", "btn-neutral", "btn-primary", "btn-secondary", "btn-accent", "btn-info", "btn-success", "btn-warning", "btn-error", "btn-ghost", "btn-link", "btn-outline", "btn-active", "btn-disabled", "glass", "no-animation", "btn-lg", "btn-md", "btn-sm", "btn-xs", "btn-wide", "btn-block", "btn-circle", "btn-square"]
    
    /* dropdown */
    static let dropdown = ["dropdown", "dropdown-content", "dropdown-end", "dropdown-top", "dropdown-bottom", "dropdown-left", "dropdown-right", "dropdown-hover", "dropdown-open"]
    
    
    /* modal */
    static let modal = ["modal", "modal-box", "modal-action", "modal-backdrop", "modal-toggle", "modal-open", "modal-top", "modal-bottom", "modal-middle"]
    
    /* swap */
    static let swap = ["swap", "swap-on", "swap-off", "swap-indeterminate", "swap-active", "swap-rotate", "swap-flip"]
    
    /* themeController */
    static let themeController = ["theme-controller"]
    
    // MARK: Data Display
    
    /* collapse/accordion */
    static let collapse = ["collapse", "collapse-title", "collapse-content", "collapse-arrow", "collapse-plus", "collapse-open", "collapse-close"]
    
    /* avatar */
    static let avatar = ["avatar", "avatar-group", "online", "offline", "placeholder"]
    
    /* badge */
    static let badge = ["badge", "badge-neutral", "badge-primary", "badge-secondary", "badge-accent", "badge-ghost", "badge-info", "badge-success", "badge-warning", "badge-error", "badge-outline", "badge-lg", "badge-md", "badge-sm", "badge-xs"]
    
    /* card */
    static let card = ["card", "card-title", "card-body", "card-actions", "card-bordered", "image-full", "card-normal", "card-compact", "card-side"]
    
    /* carousel */
    static let carousel = ["carousel", "carousel-item", "carousel-start", "carousel-center", "carousel-end", "carousel-vertical"]
    
    /* chatBubble */
    static let chatBubble = ["chat", "chat-start", "chat-end", "chat-image", "chat-header", "chat-footer", "chat-bubble", "chat-bubble-primary", "chat-bubble-secondary", "chat-bubble-accent", "chat-bubble-info", "chat-bubble-success", "chat-bubble-warning", "chat-bubble-error"]
    
    /* countdown */
    static let countdown = ["countdown"]
    
    /* diff */
    static let diff = ["diff", "diff-item-1", "diff-item-2", "diff-resizer"]
    
    /* kbd */
    static let kbd = ["kbd", "kbd-lg", "kbd-md", "kbd-sm", "kbd-xs"]
    
    /* stat */
    static let stat = ["stat", "stat-title", "stat-value", "stat-desc", "stat-figure", "stat-actions", "stats-horizontal", "stats-vertical"]
    
    /* table */
    static let table = ["table", "table-zebra", "table-pin-rows", "table-pin-cols", "table-xs", "table-sm", "table-md", "table-lg"]
    
    
    /* timeline */
    static let timeline = ["timeline", "timeline-compact", "timeline-snap-icon", "timeline-vertical", "timeline-horizontal", "timeline-start", "timeline-middle", "timeline-end", "timeline-box"]
    
    // MARK: Navigation
    
    /* breadcrumbs */
    static let breadcrumbs = ["breadcrumbs"]
    
    /* interactionStates */
    static let interactionStates = ["disabled", "active"]
    
    /* bottomNavigation */
    static let bottomNavigation = ["btm-nav", "btm-nav-xs", "btm-nav-sm", "btm-nav-md", "btm-nav-lg"]
    
    /* link */
    static let link = ["link", "link-neutral", "link-primary", "link-secondary", "link-accent", "link-success", "link-info", "link-warning", "link-error", "link-hover"]
    
    /* menu */
    static let menu = ["menu", "menu-title", "focus", "menu-dropdown-toggle", "menu-dropdown", "menu-dropdown-show", "menu-xs", "menu-sm", "menu-md", "menu-lg", "menu-vertical", "menu-horizontal"]
    
    /* navbar */
    static let navbar = ["navbar", "navbar-start", "navbar-center", "navbar-end"]
    
    /* steps */
    static let steps = ["steps", "step", "step-primary", "step-secondary", "step-accent", "step-info", "step-success", "step-warning", "step-error", "steps-vertical", "steps-horizontal"]
    
    /* tab */
    static let tab = ["tabs", "tabs-boxed", "tabs-bordered", "tabs-lifted", "tabs-xs", "tabs-sm", "tabs-md", "tabs-lg", "tab", "tab-active", "tab-disabled", "tab-content"]
    
    // MARK: Feedback
    
    /* alert */
    static let alert = ["alert", "alert-info", "alert-success", "alert-warning", "alert-error"]
    
    /* loading */
    static let loading = ["loading", "loading-spinner", "loading-dots", "loading-ring", "loading-ball", "loading-bars", "loading-infinity"]
    
    /* progress */
    static let progress = ["progress", "progress-primary", "progress-secondary", "progress-accent", "progress-info", "progress-success", "progress-warning", "progress-error"]
    
    /* radialProgress */
    static let radialProgress = ["radial-progress"]
    
    /* skeleton */
    static let skeleton = ["skeleton"]
    
    /* toast */
    static let toast = ["toast", "toast-start", "toast-center", "toast-end", "toast-top", "toast-middle", "toast-bottom"]
    
    /* tooltip */
    static let tooltip = ["tooltip", "tooltip-open", "tooltip-top", "tooltip-bottom", "tooltip-left", "tooltip-right", "tooltip-primary", "tooltip-secondary", "tooltip-accent", "tooltip-info", "tooltip-success", "tooltip-warning", "tooltip-error"]
    
    // MARK: Data Input
    
    /* formControl */
    static let formControl = ["form-control", "label"]
    
    /* checkbox */
    static let checkbox = ["checkbox", "checkbox-primary", "checkbox-secondary", "checkbox-accent", "checkbox-success", "checkbox-warning", "checkbox-info", "checkbox-error", "checkbox-lg", "checkbox-md", "checkbox-sm", "checkbox-xs"]
    
    /* fileInput */
    static let fileInput = ["file-input", "file-input-bordered", "file-input-ghost", "file-input-primary", "file-input-secondary", "file-input-accent", "file-input-info", "file-input-success", "file-input-warning", "file-input-error", "file-input-lg", "file-input-md", "file-input-sm", "file-input-xs"]
    
    /* radio */
    static let radio = ["radio", "radio-primary", "radio-secondary", "radio-accent", "radio-success", "radio-warning", "radio-info", "radio-error", "radio-lg", "radio-md", "radio-sm", "radio-xs"]
    
    /* range */
    static let range = ["range", "range-primary", "range-secondary", "range-accent", "range-success", "range-warning", "range-info", "range-error", "range-lg", "range-md", "range-sm", "range-xs"]
    
    /* rating */
    static let rating = ["rating", "rating-half", "rating-hidden", "rating-lg", "rating-md", "rating-sm", "rating-xs"]
    
    /* select */
    static let select = ["select", "select-bordered", "select-ghost", "select-primary", "select-secondary", "select-accent", "select-info", "select-success", "select-warning", "select-error", "select-lg", "select-md", "select-sm", "select-xs"]
    
    /* textInput */
    static let textInput = ["input", "input-bordered", "input-ghost", "input-primary", "input-secondary", "input-accent", "input-info", "input-success", "input-warning", "input-error", "input-lg", "input-md", "input-sm", "input-xs"]
    
    /* textarea */
    static let textarea = ["textarea", "textarea-bordered", "textarea-ghost", "textarea-primary", "textarea-secondary", "textarea-accent", "textarea-info", "textarea-success", "textarea-warning", "textarea-error", "textarea-lg", "textarea-md", "textarea-sm", "textarea-xs"]
    
    /* toggle */
    static let toggle = ["toggle", "toggle-primary", "toggle-secondary", "toggle-accent", "toggle-success", "toggle-warning", "toggle-info", "toggle-error", "toggle-lg", "toggle-md", "toggle-sm", "toggle-xs"]
    
    // MARK: Layout
    
    /* artboard */
    static let artboard = ["artboard", "artboard-demo", "phone-1", "phone-2", "phone-3", "phone-4", "phone-5", "phone-6", "artboard-horizontal"]
    
    /* divider */
    static let divider = ["divider", "divider-neutral", "divider-primary", "divider-secondary", "divider-accent", "divider-success", "divider-warning", "divider-info", "divider-error", "divider-vertical", "divider-horizontal", "divider-start", "divider-end"]
    
    /* drawer */
    static let drawer = ["drawer", "drawer-toggle", "drawer-content", "drawer-side", "drawer-overlay", "drawer-end", "drawer-open"]
    
    /* footer */
    static let footer = ["footer", "footer-title", "footer-center"]
    
    /* hero */
    static let hero = ["hero", "hero-content", "hero-overlay"]
    
    /* indicator */
    static let indicator = ["indicator", "indicator-item", "indicator-start", "indicator-center", "indicator-end", "indicator-top", "indicator-middle", "indicator-bottom"]
    
    /* join */
    static let join = ["join", "join-item", "join-vertical", "join-horizontal"]
    
    /* mask */
    static let mask = ["mask", "mask-squircle", "mask-heart", "mask-hexagon", "mask-hexagon-2", "mask-decagon", "mask-pentagon", "mask-diamond", "mask-square", "mask-circle", "mask-parallelogram", "mask-parallelogram-2", "mask-parallelogram-3", "mask-parallelogram-4", "mask-star", "mask-star-2", "mask-triangle", "mask-triangle-2", "mask-triangle-3", "mask-triangle-4", "mask-half-1", "mask-half-2"]
    
    /* stack */
    static let stack = ["stack"]
    
    // MARK: Mockup
    
    /* browser */
    static let browser = ["mockup-browser","mockup-browser-toolbar"]
    
    /* code */
    static let code = ["mockup-code"]
    
    /* phone */
    static let phone = ["mockup-phone"]
    
    /* window */
    static let window = ["mockup-window"]
    
    
}
