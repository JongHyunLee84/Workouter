//
//  ProgramListTableViewController.swift
//  BYM
//
//  Created by 이종현 on 2023/03/29.
//

import UIKit

final class ProgramListTableViewController: UITableViewController {
    
    let programListVM = ProgramListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Identifier.addProgramViewController {
//            let vc = segue.destination as! AddProgramViewController
//            vc.dataClosure = {
//                self.programListVM.fetchProgramVMList()
//                self.tableView.reloadData()
//            }
//        }
//    }
    
}

// UI
extension ProgramListTableViewController {
    private func setupTableView() {
        tableView.rowHeight = 80
    }
    
    private func setupNavigationBar() {
        self.title = "Programs"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(addButtonDidTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func addButtonDidTapped() {
        let vc = AddProgramViewController()
        vc.dataClosure = {
            self.programListVM.fetchProgramVMList()
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
}

extension ProgramListTableViewController: ProgramListViewDelegate {
    func deleteProgram(_ cell: UITableViewCell?) {
        guard let cell, let index = tableView.indexPath(for: cell)?.row else { return }
        programListVM.deleteProgram(index)
        tableView.reloadData()
    }
    
}
