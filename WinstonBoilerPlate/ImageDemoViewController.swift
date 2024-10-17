//
//  ViewController.swift
//  WinstonBoilerplate
//
//  Created by Winston Du on 7/14/20.
//  Copyright © 2020 Winston. All rights reserved.
//

import Alamofire
import Nuke
import RxCocoa
import RxSwift
import TinyConstraints
import UIKit

class ImageDemoViewController: UIViewController {
    var headerView: UIView!
    var titleLabel: UILabel!
    var numbersCollectionView: UICollectionView!
    var imageList: ImageList = ImageList()

    var disposeBag: DisposeBag = DisposeBag()

    var imageLoadTasks: [ImageTask] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderAndTitleLabel()
    }

    func setupHeaderAndTitleLabel() {
        // Initialize views and add them to the ViewController's view
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white
        view.addSubview(headerView)

        // Set position of views using constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        headerView.top(to: view.safeAreaLayoutGuide)
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true

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

        buildViews()
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: pingGoogle).disposed(by: disposeBag)
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
        imageList.images.forEach { item in
            let itemView = UIView()
            itemView.translatesAutoresizingMaskIntoConstraints = false

            containerView.addSubview(itemView)

            if let prevItem = prevItem {
                itemView.topToBottom(of: prevItem)
            } else {
                itemView.topToSuperview()
            }
            if item.url == imageList.images.last?.url {
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
                if case let .success(response) = result {
                    imageView.image = response.image
                }
            }
            imageLoadTasks.append(imageLoadTask)

            imageView.image = UIImage(systemName: "arrow.clockwise")
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFit
        }

        view.addSubview(scrollView)
        scrollView.bottomToSuperview()
        scrollView.horizontalToSuperview(insets: .horizontal(20))
        scrollView.topToBottom(of: headerView)
    }

    func pingGoogle() {
        AF.request("https://www.google.com", method: .get, headers: [])
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(json):
                    NSLog("\(json)")
                    guard let dict = json as? NSDictionary else { return }
                    NSLog("\(dict)")
                case let .failure(responseError):
                    if let statusCode = response.response?.statusCode {
                        NSLog("\(statusCode)")
                    }

                    if case let AFError.sessionTaskFailed(urlError) = responseError,
                        let urlErrorCasted = urlError as? URLError {
                        NSLog("\(urlErrorCasted.code)")
                    }
                }
                // Construct a post request encoding some info about the response
            }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
