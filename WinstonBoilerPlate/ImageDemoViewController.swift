//
//  ViewController.swift
//  WinstonBoilerplate
//
//  Created by Winston Du on 7/14/20.
//  Copyright © 2020 Winston. All rights reserved.
//

import UIKit
import TinyConstraints
import Nuke

class ViewController: UIViewController {

    var headerView: UIView!
    var titleLabel: UILabel!
    var numbersCollectionView: UICollectionView!
    
    var imageLoadTasks: Array<ImageTask> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderAndTitleLabel()
    }
    
    func setupHeaderAndTitleLabel() {
        // Initialize views and add them to the ViewController's view
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        self.view.addSubview(headerView)
        
        
        // Set position of views using constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        headerView.top(to: view.safeAreaLayoutGuide)
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        titleLabel = UILabel()
        titleLabel.text = "Winstons photos"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
        
        headerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
        titleLabel.top(to: headerView)
        
        self.buildViews()
        self.view.backgroundColor = .white
    }
    
    func buildViews() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let containerView = UIView()
        scrollView.addSubview(containerView)
        containerView.edgesToSuperview()
        
        var prevItem: UIView?
        allItems.forEach { item in
            let itemView = UIView()
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(itemView)
            
            if let prevItem = prevItem {
                itemView.topToBottom(of: prevItem)
            } else {
                itemView.topToSuperview()
            }
            if item.url == allItems.last?.url {
                itemView.bottomToSuperview()
            }
            prevItem = itemView
            
            

            let textLabel = UILabel()
            itemView.addSubview(textLabel)
            textLabel.horizontalToSuperview()
            textLabel.topToSuperview()
            
            let imageView = UIImageView()
            itemView.addSubview(imageView)
            imageView.horizontalToSuperview()
            imageView.bottomToSuperview()
            imageView.topToBottom(of: textLabel)
            
            textLabel.numberOfLines = 1
            textLabel.text = item.title
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let imageLoadTask = ImagePipeline.shared.loadImage(with: item.url) { result in
                if case .success(let response) = result {
                    imageView.image = response.image
                }
            }
            imageLoadTasks.append(imageLoadTask)
            
            imageView.image = UIImage(systemName: "arrow.clockwise")
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFit
        }
        
        self.view.addSubview(scrollView)
        scrollView.bottomToSuperview()
        scrollView.horizontalToSuperview(insets: .horizontal(20))
        scrollView.topToBottom(of: headerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

private let allItems = [
    Item(title: "Baseline JPEG", url: URL(string: "https://user-images.githubusercontent.com/1567433/120257591-80e2e580-c25e-11eb-8032-54f3a966aedb.jpeg")!),
    Item(title: "Progressive JPEG", url: URL(string: "https://user-images.githubusercontent.com/1567433/120257587-7fb1b880-c25e-11eb-93d1-7e7df2b9f5ca.jpeg")!),
    Item(title: "Animated GIF", url: URL(string: "https://cloud.githubusercontent.com/assets/1567433/6505557/77ff05ac-c2e7-11e4-9a09-ce5b7995cad0.gif")!),
    Item(title: "WebP", url: URL(string: "https://kean.github.io/images/misc/4.webp")!)
]

