//
//  ViewController.swift
//  elinexet ios test
//
//  Created by Tai Nguyen on 28/9/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var images: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        reloadAllImages()
    }
    
    // MARK: - Setup Methods
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let height = (collectionView.frame.height - 50) / 7
        layout.itemSize = CGSize(width: height, height: height)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
        let reloadButton = UIBarButtonItem(title: "Reload All", style: .plain, target: self, action: #selector(reloadAllImages))
        navigationItem.rightBarButtonItems = [reloadButton, addButton]
    }
    
    // MARK: - Actions
    @objc private func addNewImage() {
        let newImageURL = "http://loremflickr.com/200/200/?random=\(UUID().uuidString)"
        images.append(newImageURL)
        collectionView.reloadData()
    }
    
    @objc private func reloadAllImages() {
        images.removeAll()
        for _ in 0..<140 {
            let newImageURL = "http://loremflickr.com/200/200/?random=\(UUID().uuidString)"
            images.append(newImageURL)
        }
        collectionView.reloadData()
        let firstItemIndex = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: firstItemIndex, at: .left, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let imageUrl = images[indexPath.row]
        cell.configure(with: imageUrl)
        return cell
    }
}

