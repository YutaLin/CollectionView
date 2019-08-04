//
//  ViewController.swift
//  CollectionView
//
//  Created by linyuta on 2019/8/4.
//  Copyright © 2019 UTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionViewData = ["1 😀", "2☺️", "3 🙁", "4 😡", "5 😎"]
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var addButton: UIBarButtonItem!
    @IBOutlet private weak var removeButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.width - 20) / 4
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        collectionView.refreshControl = refresh
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
    }
    
    @IBAction func add() {
        collectionView.performBatchUpdates({
            for _ in 0..<8 {
                let text = "\(collectionViewData.count + 1) 🤩"
                collectionViewData.append(text)
                let indexPath = IndexPath(row: collectionViewData.count - 1, section: 0)
                collectionView.insertItems(at: [indexPath])
            }
        }, completion: nil)
    }
    
    @IBAction func deleteSelected() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map{ $0.item }.sorted().reversed()
            for item in items {
                collectionViewData.remove(at: item)
            }
            
            collectionView.deleteItems(at: selected)
            navigationController?.isToolbarHidden = true
        }
    }
    
    @objc func refresh() {
        add()
        collectionView.refreshControl?.endRefreshing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.isEnabled = !editing
        collectionView.allowsMultipleSelection = editing
        
        if !editing {
            collectionView.indexPathsForSelectedItems?.forEach {
                collectionView.deselectItem(at: $0, animated: false)
            }
        }
        
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isEditing = editing
        }

        
        removeButton.isEnabled = editing
        if !editing {
            navigationController?.isToolbarHidden = true
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = collectionViewData[indexPath.row]
        cell.isEditing = isEditing
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            navigationController?.isToolbarHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
            navigationController?.isToolbarHidden = true
        }
    }
}
