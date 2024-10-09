//
//  MenuViewController.swift
//  WinstonBoilerPlate
//
//  Created by Winston Du on 10/8/24.
//  Copyright © 2024 Dougly. All rights reserved.
//


import UIKit
import Nuke
import SwiftUI

final class MenuViewController: UITableViewController {
    private var sections = [MenuSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell");

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Network Logs", style: .plain, target: self, action: #selector(showAlert))

        sections = [firstSection, secondSection]
    }

    private var firstSection: MenuSection {
        var items = [
            MenuItem(
                title: "SwiftUI Example",
                subtitle: "To go into SwiftUI Land",
                action: { [weak self] in self?.push(UIHostingController(rootView: ImageDemoView()), $0) }
            )
        ]
        return MenuSection(title: "General", items: items)
    }


    private var secondSection: MenuSection {
        var items = [
            MenuItem(
                title: " (UIKit)",
                subtitle: "UICollectionView Prefetching",
                action: { [weak self] in self?.push(ViewController(), $0) }
            )
        ]

        return MenuSection(title: "Advanced", items: items)
    }

    private func push(_ controller: UIViewController, _ item: MenuItem) {
        controller.title = item.title
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func showAlert() {
        let alert = UIAlertController(
            title: "Test",
            message: "This is an Alert",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        let item = sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        item.action?(item)
    }
}

// MARK - MenuItem

private struct MenuItem {
    typealias Action = ((MenuItem) -> Void)

    var title: String?
    var subtitle: String?
    var action: Action?

    init(title: String?, subtitle: String? = nil, action: Action?) {
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
}

private struct MenuSection {
    var title: String
    var items: [MenuItem]

    init(title: String, items: [MenuItem]) {
        self.title = title
        self.items = items
    }
}
