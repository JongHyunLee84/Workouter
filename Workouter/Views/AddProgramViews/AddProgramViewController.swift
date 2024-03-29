//
//  AddProgramViewController.swift
//  BYM
//
//  Created by 이종현 on 2023/04/03.
//

import RxCocoa
import RxSwift
import UIKit

final class AddProgramViewController: BaseViewController, KeyboardProtocol, Alertable {
    
    private var viewModel = AddProgramViewModel()
    
    let customView = AddProgramUIView()
    var addProgram: (Program) -> Void = { _ in } // 이전 뷰와 바인딩을 위한 클로저
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupDelegate() {
        let view = customView
        view.tableView.register(AddProgramTableViewCell.self, forCellReuseIdentifier: Identifier.addProgramTableViewCell)
    }
    
    override func setupRxBind() {
        let view = customView
        
        view.addWorkoutButton.rx.tap
            .bind {
                let vc = AddWorkoutViewController(workout: self.viewModel.workoutRelay.value)
                vc.viewDisappear = { [weak self] workout in
                    self?.viewModel.workoutRelay.accept(workout)
                }
                vc.addButtonTapped = { [weak self] workout in
                    self?.viewModel.addWorkout([workout])
                }
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        view.searchWorkoutButton.rx.tap
            .bind {
                let vc = SearchWorkoutViewController()
                vc.passWorkoutList = { [weak self] workoutList in
                        self?.viewModel.addWorkout(workoutList)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        view.programNameTF.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.titleRelay)
            .disposed(by: disposeBag)
        
        view.tableView.rx.itemDeleted
            .bind { indexPath in
                self.viewModel.removeWorkoutAt(indexPath.row)
            }
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .flatMap { [weak self] () -> Observable<(Bool, Program)> in
                guard let self = self else { return Observable.empty() }
                return Observable.combineLatest(self.viewModel.isSavable, self.viewModel.programRelay).take(1)
            }
            .bind { (isTrue, program) in
                if isTrue {
                    let noAction = UIAlertAction(title: "No", style: .cancel)
                    let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { _ in
                        // MARK: - 프로그램 저장 코드 와야함
                        self.addProgram(program) // 이전 뷰와 바인딩하기 위한 클로저
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.showAlert(title: self.viewModel.saveAlert.title, message: self.viewModel.saveAlert.message, actions: [noAction, yesAction])
                }else {
                    self.showAlert(title: self.viewModel.rejectAlert.title, message: self.viewModel.rejectAlert.message, actions: nil)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.workoutListRelay
            .bind(to: view.tableView.rx.items(cellIdentifier: Identifier.addProgramTableViewCell, cellType: AddProgramTableViewCell.self)) {
                row, item, cell in
                cell.passData(item)
            }
            .disposed(by: disposeBag)
        
        viewModel.numberOfWorkouts
            .bind {
                $0.isZero ? self.customView.tableView.setEmptyMessage(self.viewModel.emptyMessage) : self.customView.tableView.restore()
            }
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        setupNavigation()
        setupKeyborad(self.view)
    }
    
}

// MARK: - Navigation Bar

extension AddProgramViewController {
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never // prefersLargeTitle은 딜레이 있어 보임.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: nil)
    }
}
