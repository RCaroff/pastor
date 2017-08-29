//
//  ViewController.swift
//  Pastor
//
//  Created by Rémi Caroff on 10/07/2017.
//  Copyright © 2017 Rémi Caroff. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class PassListViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet var myTableView: UITableView!
    var viewModel: PassListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PassListViewModel(with: PassListRepository())
        self.setupTableView()
        self.viewModel.loadData.onNext(true)
        self.setupAddButton()
    }
    
    func setupAddButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        addItem.rx.tap.bind {
            self.performSegue(withIdentifier: "showGen", sender: nil)
        }
        .disposed(by: disposeBag)
        self.navigationItem.setRightBarButton(addItem, animated: true)
    }
    
    func setupTableView() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<PassListSection>()
        dataSource.configureCell = { (ds, tv, ip, item) -> PassListTableViewCell in
            let cell: PassListTableViewCell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip) as! PassListTableViewCell
            let vm = PassVM(with: item)
            cell.setContentWith(pass: vm)
            return cell
        }
        
        self.myTableView.rx.itemSelected
            .subscribe(onNext: { ip in
                self.myTableView.deselectRow(at: ip, animated: true)
            })
        .disposed(by: disposeBag)
        
        
        self.myTableView.rx.modelSelected(Pass.self)
        .subscribe(onNext: { pass in
            self.passSelected(pass: pass)
        })
        .disposed(by: disposeBag)
        
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        self.viewModel.passCollection.asObservable()
            .bind(to: self.myTableView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
    }
    
    func passSelected(pass: Pass) {
        self.showActionSheetForPass(pass: pass)
    }
    
    func showActionSheetForPass(pass: Pass) {
        let actionSheet = UIAlertController(title: pass.serviceName, message: nil, preferredStyle: .actionSheet)
        let copyAction = UIAlertAction(title: "Copy password", style: .default) { action in
            self.viewModel.copyTapped.onNext(pass.servicePassword)
        }
        let regenAction = UIAlertAction(title: "Regenerate", style: .destructive) { action in
            self.viewModel.copyTapped.onNext(pass.servicePassword)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(copyAction)
        actionSheet.addAction(regenAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
}
