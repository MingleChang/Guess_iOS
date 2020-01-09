//
//  MCMenuController.swift
//  Guess
//
//  Created by MingleChang on 2019/12/31.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit

class MCMenuController: MCViewController {
    private let navigationBar: MCNavigationBar = MCNavigationBar()
    private let tableView: UITableView = UITableView(frame: .zero, style: .plain)
    private let startButton: UIButton = UIButton()
    
    private let categories: [String] = MCManager.share().categories
    
    private let categoryCellId = NSStringFromClass(MCMenuCategoryCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}
// MARK: - Private
extension MCMenuController {
    private func startGame(_ category: String) {
        let lLanguage = MCManager.share().language
        let lViewController = MCGameController()
        lViewController.words = MCDatabase.share().queryWords(category: category, language: lLanguage.rawValue)
        lViewController.timeTotal = 120
        lViewController.modalPresentationStyle = .fullScreen
        MCManager.share().replaceRootController(lViewController)
    }
}
// MARK: - Event Response
extension MCMenuController {
}
// MARK: - Delegate
// MARK: - UITableViewDataSource
extension MCMenuController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lRow = indexPath.row
        let lCategory = categories[lRow]
        let lCell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! MCMenuCategoryCell
        lCell.category = lCategory
        return lCell
    }
    
    
}
// MARK: - UITableViewDelegate
extension MCMenuController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(MCPixelRatio(60))
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let lRow = indexPath.row
        var lCategory = categories[lRow]
        if (lRow == 0) {
            lCategory = ""
        }
        startGame(lCategory)
    }
}
// MARK: - Configure
extension MCMenuController {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
        navigationBar.title = MCLocalized("Menu")
        navigationBar.backButtonCallBack = {[unowned self] ()->(Void) in
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(MCPixelRatio(44))
        }
        
        tableView.backgroundColor = UIColor.clear
        tableView.register(MCMenuCategoryCell.self, forCellReuseIdentifier: categoryCellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    func configureData() {
    }
}
