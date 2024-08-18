//
//  PlaygroundVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 03/06/2023.
//

import UIKit
import WebKit
import ReSwift
import SnapKit
import SwiftSoup

class PlaygroundVC: UIViewController, Storyboarded {
    
    
    /// The current project being edited in the playground.
    var project: Project?
    
    /// List of completed challenges for the project.
    var completeChallenges: [String]?
    
    /// Boolean flag to determine if the ViewFinder is currently on.
    var viewFinderIsOn = false
    @IBOutlet var viewFinderViews: [UIView]!
    
    /// The web view used to preview the project's HTML content.
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var resizeIcon: UIImageView!
    @IBOutlet weak var webViewWidthConstraint: NSLayoutConstraint!
    
    /// Undo/Redo button outlets.
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    
    @IBOutlet weak var canvasSegmentedControl: UISegmentedControl!
    
    /// Tools view that contains the keyboard and other tools.
    @IBOutlet weak var toolsView: UIView!
    @IBOutlet weak var toolsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var toolsPageControl: UIPageControl!
    
    /// Array to hold the Canvas for HTML, CSS, and JS.
    var canvases = [UICanvas]()
    var mindMap: UIMindMap! // HTML
    var styleSheet: UIStyleSheet! // CSS
    var flowChart: UIFlowChart! // JS
    
    /// Arrays to hold the ToolKit VCs for HTML, CSS, and JS.
    
    var htmlToolKitCollection: ToolKitCollection!
    let classNamesToolKit = ClassNamesToolKit.instantiate()
    let structureToolKit = StructureToolKit.instantiate()
    let attributesToolKit = AttributesToolKit.instantiate()
    
    
    var cssToolKitCollection: ToolKitCollection!
    let selectorsToolKit = SelectorsToolKit.instantiate()
    let propertiesToolKit = PropertiesToolKit.instantiate()
    let styleToolKit = StyleToolKit.instantiate()
    
    
    var jsToolKitCollection: ToolKitCollection!
    let eventsToolKit = EventsToolKit.instantiate()
    let conActToolKit = ConActToolKit.instantiate()
    let valueToolKit = ValueToolKit.instantiate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up gesture recognizer for resizing the web view
        let resizeGR = UIPanGestureRecognizer(target: self, action: #selector(handleResizingWebView(sender:)))
        resizeIcon.addGestureRecognizer(resizeGR)
        
        setupCanvasesLayout()
        setupToolsViewLayout()
    }
    
    // MARK: - WebView
    /// Load the project's web content into the web view
    func loadWebView() {
        guard let document = project?.document else { return }
        do {
            let htmlCode = try document.outerHtml()
            print("loadWebView:", htmlCode)
            webView.loadHTMLString( htmlCode, baseURL: nil)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    
    // MARK: - Canvases Setup
    /// Set up the layout and configuration of the Canvases
    func setupCanvasesLayout() {
        mindMap = UIMindMap(frame: view.frame, color: .systemBlue)
        styleSheet = UIStyleSheet(frame: view.frame, color: .systemPurple)
        flowChart = UIFlowChart(frame: view.frame, color: .systemGreen)
        canvases = [flowChart, mindMap, styleSheet]
        mindMap.mindMapDelegate = self
        styleSheet.styleSheetDelegate = self
        flowChart.flowChartDelegate = self
        canvases.forEach { canvas in
            view.insertSubview(canvas, at: 0)
            canvas.isHidden = true
            canvas.alpha = 0
            canvas.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        mindMap.alpha = 1
        mindMap.isHidden = false
        
    }
    
    
    // MARK: - Tools View Setup
    /// Set up the layout and swipe gestures for the tools view
    func setupToolsViewLayout() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        upSwipe.direction = .up
        downSwipe.direction = .down
        toolsView.addGestureRecognizer(rightSwipe)
        toolsView.addGestureRecognizer(leftSwipe)
        toolsView.addGestureRecognizer(upSwipe)
        toolsView.addGestureRecognizer(downSwipe)
        
        structureToolKit.mindMap = mindMap
        htmlToolKitCollection = ToolKitCollection(viewControllers:  [classNamesToolKit, structureToolKit, attributesToolKit])
        cssToolKitCollection = ToolKitCollection(viewControllers: [selectorsToolKit, propertiesToolKit, styleToolKit])
        jsToolKitCollection = ToolKitCollection(viewControllers: [eventsToolKit, conActToolKit, valueToolKit])

        [htmlToolKitCollection,cssToolKitCollection,jsToolKitCollection].forEach { toolKitCollection in
            toolKitCollection?.viewControllers.forEach { toolKitVC in
                addChild(toolKitVC)
                toolKitVC.didMove(toParent: self)
                toolsView.addSubview(toolKitVC.view)
                toolKitVC.view.snp.makeConstraints { make in
                    make.width.height.equalToSuperview()
                }
            }
        }
    }
    
    
    
    // MARK: - WebView Gesture Handling
    
    /// Handle the resizing of the web view when a pan gesture is detected.
    ///
    /// This function adjusts the width of the web view based on the user's touch location.
    /// It ensures the web view width stays within a specified range.
    ///
    /// - Parameter sender: The pan gesture recognizer that triggers this function.
    @objc func handleResizingWebView(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            let touchPoint = sender.location(in: view).x - 20
            if touchPoint > 60 && touchPoint < 240 {
                webViewWidthConstraint.constant = touchPoint
            }
        default:
            if webViewWidthConstraint.constant < 90 {
                webViewWidthConstraint.constant = 80
            } else if webViewWidthConstraint.constant >= 90 && webViewWidthConstraint.constant < 130 {
                webViewWidthConstraint.constant = 120
            } else if webViewWidthConstraint.constant >= 130 && webViewWidthConstraint.constant < 170 {
                webViewWidthConstraint.constant = 160
            } else {
                webViewWidthConstraint.constant = 200
            }
        }
    }
    
    // MARK: - Animate Canvas & toolkitCollection Transition
    
    
    /// Handle changes in the Canvas segmented control.
    ///
    /// This function animates the transition between different canvases when the segmented control is changed.
    ///
    /// - Parameter sender: The segmented control that triggers this function.
    var previousCanvasIndex = 1
    @IBAction func didChangeCanvasSegmentedControl(_ sender: UISegmentedControl) {
        let toolkitCollections = [jsToolKitCollection,htmlToolKitCollection,cssToolKitCollection]
        guard let currentToolKitCollection = toolkitCollections[sender.selectedSegmentIndex],
              let previousToolKitCollection = toolkitCollections[previousCanvasIndex] else { return }
        let currentCanvas = canvases[sender.selectedSegmentIndex], previousCanvas = canvases[previousCanvasIndex]
        previousCanvasIndex = sender.selectedSegmentIndex
        toolsPageControl.currentPage = currentToolKitCollection.currentIndex
        guard let currentToolKitView = currentToolKitCollection.viewControllers[currentToolKitCollection.currentIndex].view,
              let previousToolKitView = previousToolKitCollection.viewControllers[previousToolKitCollection.currentIndex].view else { return }
        currentToolKitView.isHidden =  false
        currentToolKitView.frame.origin.y = self.view.frame.height
        currentCanvas.isHidden = false
        
        UIView.animate(withDuration: 0.2) {
            currentToolKitView.frame.origin.y = previousToolKitView.frame.origin.y
        }
        
        UIView.animate(withDuration: 0.4) {
            previousToolKitView.frame.origin.y = self.view.frame.height
            currentCanvas.alpha = 1; previousCanvas.alpha = 0
        } completion: { _ in
            previousToolKitView.isHidden = true
            previousCanvas.isHidden = true
        }
        
    }
    
    
    // MARK: - Animate ToolKit Transition
    /// Animate the transition between different ToolKits.
    ///
    /// This function handles the sliding animation between different ToolKit, depending on the selected index.
    ///
    /// - Parameter index: The index of the ToolKit to transition to.
    func animateToToolKit(at index: Int) {
        guard let currentToolKitCollection = [jsToolKitCollection,htmlToolKitCollection,cssToolKitCollection][canvasSegmentedControl.selectedSegmentIndex] else { return }
        currentToolKitCollection.previousIndex = currentToolKitCollection.currentIndex
        currentToolKitCollection.currentIndex = index
        var animationDirection = currentToolKitCollection.currentIndex > currentToolKitCollection.previousIndex
        if currentToolKitCollection.currentIndex < 0 {
            currentToolKitCollection.currentIndex = currentToolKitCollection.viewControllers.count - 1
        } else if currentToolKitCollection.currentIndex > currentToolKitCollection.viewControllers.count - 1 {
            currentToolKitCollection.currentIndex = 0
        }
        toolsPageControl.currentPage = currentToolKitCollection.currentIndex
        let currentToolKitVC = currentToolKitCollection.viewControllers[currentToolKitCollection.currentIndex], previousToolKitVC = currentToolKitCollection.viewControllers[currentToolKitCollection.previousIndex]
        currentToolKitVC.view.isHidden = false
        currentToolKitVC.view.frame.origin.x = animationDirection ? self.view.frame.width : -self.view.frame.width
        UIView.animate(withDuration: 0.3) {
            currentToolKitVC.view.center.x = previousToolKitVC.view.center.x
            previousToolKitVC.view.frame.origin.x = animationDirection ? -self.view.frame.width : self.view.frame.width
        } completion: { _ in
            previousToolKitVC.view.isHidden = true
        }
    }
    
    // MARK: - Keyboard Swipe Handling
    
    /// Handle page control changes for the custom keyboard views.
    ///
    /// This function animates the transition to the selected page in the page control.
    ///
    /// - Parameter sender: The page control that triggers this function.
    @IBAction func didPressToolsPageControl(_ sender: UIPageControl) {
        guard let currentToolKitCollection = [jsToolKitCollection,htmlToolKitCollection,cssToolKitCollection][canvasSegmentedControl.selectedSegmentIndex] else { return }
        if sender.currentPage != currentToolKitCollection.currentIndex {
            animateToToolKit(at: sender.currentPage)
        }
    }
    
    /// Handle swipe gestures for navigating between custom keyboard views.
    ///
    /// This function allows the user to swipe left, right, up, or down to change the keyboard view or adjust the tools view height.
    ///
    /// - Parameter sender: The swipe gesture recognizer that triggers this function.
    @objc func handleKeyboardSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right, .left:
                guard let currentIndex = [jsToolKitCollection,htmlToolKitCollection,cssToolKitCollection][canvasSegmentedControl.selectedSegmentIndex]?.currentIndex else { return }
                animateToToolKit(at: sender.direction == .right ? currentIndex - 1 : currentIndex + 1)
            case .up:
                if toolsViewHeightConstraint.constant == 40 {
                    toolsViewHeightConstraint.constant = 107
                } else if toolsViewHeightConstraint.constant == 107 {
                    toolsViewHeightConstraint.constant = 255
                } else if toolsViewHeightConstraint.constant == 255 {
                    webViewWidthConstraint.constant = 120
                    toolsViewHeightConstraint.constant = 329
                }
            case .down:
                if toolsViewHeightConstraint.constant == 107 {
                    toolsViewHeightConstraint.constant = 40
                } else if toolsViewHeightConstraint.constant == 255 {
                    toolsViewHeightConstraint.constant = 107
                } else if toolsViewHeightConstraint.constant == 329 {
                    webViewWidthConstraint.constant = 160
                    toolsViewHeightConstraint.constant = 255
                }
            default:
                break
            }
            UIView.animate(withDuration: 0.15) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Close Button
    /// Dismisses the current view controller.
    @IBAction func didPressCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    // MARK: - ViewFinder
    /// Toggles the ViewFinder feature on or off.
    @IBAction func didPressViewfinderButton(_ sender: UIButton) {
        if viewFinderIsOn {
            sender.setImage(UIImage(systemName: "viewfinder.circle.fill"), for: .normal)
            self.viewFinderViews.forEach { $0.isHidden = false }
            UIView.animate(withDuration: 1) {
                self.viewFinderViews.forEach { $0.alpha = 1 }
            }
        } else {
            sender.setImage(UIImage(systemName: "viewfinder.circle"), for: .normal)
            UIView.animate(withDuration: 1) {
                self.viewFinderViews.forEach { $0.alpha = 0 }
            } completion: { _ in
                self.viewFinderViews.forEach { $0.isHidden = true }
            }
        }
        viewFinderIsOn.toggle()
    }
    
    @IBAction func didPressCoCaptain(_ sender: UIButton) {
        let vc = CoCaptainVC.instantiate()
        self.present(vc, animated: true)
    }
    
    @IBAction func didPressStore(_ sender: UIButton) {
        let vc = StoreVC.instantiate()
        self.present(vc, animated: true)
    }
    
    // MARK: - Undo/Redo Button Actions
    /// Dispatches an undo action to the Redux store.
    @IBAction func didPressUndo(_ sender: UIButton) {
        print("\(#function)ing...")
        ReduxStore.dispatch(UndoAction())
    }
    
    /// Dispatches a redo action to the Redux store.
    @IBAction func didPressRedo(_ sender: UIButton) {
        print("\(#function)ing...")
        ReduxStore.dispatch(RedoAction())
    }
    
    // MARK: - Arrow Button Actions
    /// Handles arrow button presses to update the selected node in the appropriate MindMap.
    ///
    /// - Parameter sender: The button that triggered this action. The button's tag determines the direction.
    @IBAction func didPressArrow(_ sender: UIButton) {
        if !mindMap.isHidden {
            mindMap.updateSelectedNode(Direction(rawValue: sender.tag))
        } else if !styleSheet.isHidden {
            styleSheet.updateSelectedNode(Direction(rawValue: sender.tag))
        } else {
            flowChart.updateSelectedNode(Direction(rawValue: sender.tag))
        }
    }
    
    
}




// MARK: - UIMindMapDelegate
extension PlaygroundVC: UIMindMapDelegate {
    
    /// Handles the removal of a node in the MindMap.
    func didRemoveMindMapNode() {
        loadWebView()
    }
}

// MARK: - UIFlowChartDelegate
extension PlaygroundVC: UIFlowChartDelegate {
    
    /// Handles the removal of a node in the FlowChart.
    func didRemoveFlowChartNode() {
        loadWebView()
    }
}

// MARK: - UIStyleSheetDelegate
extension PlaygroundVC: UIStyleSheetDelegate {
    
    /// Handles the removal of a node in the StyleSheet.
    func didRemoveStyleSheetNode() {
        loadWebView()
    }
}



extension PlaygroundVC: StoreSubscriber {
    
    /// Subscribes to the Redux store when the view appears.
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    /// Unsubscribes from the Redux store when the view disappears.
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    /// Updates the UI based on the new state from the Redux store.
    ///
    /// - Parameter state: The new state from the Redux store.
    func newState(state: ReduxState) {
        
        updateProjectIfNeeded(from: state)
        handleDailyChallenges(with: state)
        
        loadWebView()/*🤔*/
        mindMap.loadBody()
        styleSheet.loadSelector()
        flowChart.loadEvent()
        
        
        projectTitle.text = project?.getDocumentTitle()
    }
    
    // MARK: - Helper Functions
    
    /// Updates the project reference if it is not already set.
    ///
    /// - Parameter state: The new state from the Redux store.
    private func updateProjectIfNeeded(from state: ReduxState) {
        if project == nil {
            project = state.openedProject
            mindMap.project = project
            styleSheet.project = project
            flowChart.project = project
        }
    }
    
    
    // MARK: - Daily Challenge Completion Handling
    /// Handles daily challenges completion and triggers animations if necessary.
    private func handleDailyChallenges(with state: ReduxState) {
        guard let openedProject = state.openedProject else { return }

        for challenge in state.dailyChallenges {
            if challenge.isComplete { continue }
            
            if let docString = openedProject.getOuterHtml(), docString.contains(challenge.regex) {
                view.presentConfettiAnimation()
                challenge.isComplete = true
            }
        }
    }
}
