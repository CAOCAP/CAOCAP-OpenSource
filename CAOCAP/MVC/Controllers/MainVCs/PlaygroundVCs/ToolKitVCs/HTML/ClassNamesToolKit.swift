//
//  ClassNamesToolKit.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 11/08/2024.
//

import UIKit

class ClassNamesToolKit: ToolKitVC {
    
    /// Array of all available DaisyUI  class names.
    var uiLibraryClassNames = DaisyUI.all + TailwindCSS.all
    
    //MARK: Outlets
    @IBOutlet weak var uiLibraryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func newState(state: ReduxState) {
        super.newState(state: state)
    }
    
    
}



// MARK: - UITextFieldDelegate
extension ClassNamesToolKit: UITextFieldDelegate {
    
    /// Handles the return key press event on the text field.
    ///
    /// - Parameter textField: The text field whose return button was pressed.
    /// - Returns: A boolean value indicating whether the text field should process the return button press.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    /// Handles the event when a HTML element text content editing ends.
    ///
    /// - Parameter sender: The text field that triggered the event.
    @IBAction func didEndEditingClassNameSearch(_ sender: UITextField) {
        guard let project = project, let text = sender.text else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElementText(content: text)
        }))
    }
    
    /// Handles the event when a HTML element source editing ends.
    ///
    /// - Parameter sender: The text field that triggered the event.
    @IBAction func didEndEditingIdSearch(_ sender: UITextField) {
        guard let project = project, let text = sender.text else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElement(source: text)
        }))
    }
    
    /// Filters the Tailwind classes based on the search query.
    ///
    /// - Parameter sender: The text field that triggered the event.
    @IBAction func didEndEditingUILibrarySearch(_ sender: UITextField) {
        guard let searchQuery = sender.text else { return }
        uiLibraryClassNames = DaisyUI.all + TailwindCSS.all
        if !searchQuery.isEmpty {
            var filteredClassNames = [String]()
            uiLibraryClassNames.forEach { classNameSet in
                filteredClassNames += classNameSet.array.filter { $0.contains(searchQuery)}
            }
            
            uiLibraryClassNames = [(name: .both, array: filteredClassNames)]
        }
        
        uiLibraryCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate
extension ClassNamesToolKit: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// Returns the number of sections in the collection view.
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return uiLibraryClassNames.count
    }
    
    /// Returns the number of items in a given section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uiLibraryClassNames[section].array.count
    }
    
    /// Configures and returns the cell for the given index path.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(title: uiLibraryClassNames[indexPath.section].array[indexPath.row])
        return cell
    }
    
    /// Returns the size for the item at the specified index path.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 20, height: 30)
    }
    
    /// Handles the selection of an item in the collection view.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let project = project else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.toggleSelectedElement(className: self.uiLibraryClassNames[indexPath.section].array[indexPath.row])
        }))
    }
    
}

extension ClassNamesToolKit: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Components"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
    
    

