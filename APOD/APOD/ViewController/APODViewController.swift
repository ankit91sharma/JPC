//
//  ViewController.swift
//  APOD
//
//  Created by Ankit Sharma on 11/03/22.
//

import UIKit
import Combine
import FSCalendar

class APODViewController: UIViewController, LoadingIndicatorViewController {
    
    @IBOutlet weak var buttonDate: UIButton!
    @IBOutlet weak var tableViewAPOD: UITableView!
    private weak var calendar: FSCalendar!
    
    private let viewModel = APODViewModel()
    private var cancelable = Set<AnyCancellable>()
    private var calendarView: PopOverViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        setData()
    }
    
    private func configureUI() {
        self.tableViewAPOD.delegate = self
        self.tableViewAPOD.dataSource = self
        self.tableViewAPOD.rowHeight = UITableView.automaticDimension
        self.tableViewAPOD.estimatedRowHeight = APODAPIConstants.estimatedHeight
        self.tableViewAPOD.separatorStyle = .none
        self.tableViewAPOD.allowsSelection = false
        self.tableViewAPOD.registerCells()
        setButtontitle()
    }
    
    private func setData() {
        self.showActivityIndicator()
        viewModel.getAPODData()
    }
    
    private func bindViewModel() {
        viewModel.dataRecived
            .receive(on: DispatchQueue.main)
            .sink { _ in
                // MARK: Handel Completion
            } receiveValue: { [weak self]  in
                guard let weakSelf = self else { return }
                weakSelf.loadingIndicator?.stopAnimating()
                weakSelf.tableViewAPOD.reloadData()
                weakSelf.setButtontitle()
            }.store(in: &cancelable)
        
        viewModel.apiFailed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let weakSelf = self else { return }
                UIAlertController.showAlertMessage(vc: weakSelf, message: APODAPIConstants.errorMessage)
            }.store(in: &cancelable)
    }
    
    private func setButtontitle() {
        if (self.traitCollection.horizontalSizeClass == .regular && self.traitCollection.verticalSizeClass == .regular) {
            let attributedText = NSAttributedString(string: viewModel.getDate(), attributes: [NSAttributedString.Key.font: UIFont().scriptFont(size: 32, boldRequired: true)])
            buttonDate.setAttributedTitle(attributedText, for: .normal)
        } else {
            let attributedText = NSAttributedString(string: viewModel.getDate(), attributes: [NSAttributedString.Key.font: UIFont().scriptFont(size: 16, boldRequired: true)])
            buttonDate.setAttributedTitle(attributedText, for: .normal)
        }
    }
    
    @IBAction func actionCalendar(_ sender: Any) {
        loadCalendar(sender: sender)
    }
}

extension APODViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: APODImageTableViewCell.typeName, for: indexPath) as? APODImageTableViewCell else {
            return UITableViewCell() }
        guard let model = viewModel.getRowData(for: indexPath.row)  else { return UITableViewCell() }
        cell.configureCell(model: model)
        return cell
    }
}


extension APODViewController: FSCalendarDataSource, FSCalendarDelegate, UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    private func loadCalendar(sender: Any) {
        if self.calendarView == nil {
            self.calendarView = PopOverViewController()
        }
        guard let vc = self.calendarView else { return }
        vc.preferredContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height / 2)
        vc.modalPresentationStyle = .popover
        if let pres = vc.presentationController {
            pres.delegate = self
        }
        self.present(vc, animated: true)
        if let pop = vc.popoverPresentationController {
            pop.sourceView = (sender as! UIView)
            pop.sourceRect = (sender as! UIView).bounds
        }
        vc.calendar.dataSource = self
        vc.calendar.delegate = self
        vc.calendar.backgroundColor = .white
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.calendarView?.dismiss(animated: false, completion: nil)
        if date.dateToString() != viewModel.getDate() {
            viewModel.setDate(date: date)
            setButtontitle()
            setData()
        }
    }
}
