//
//  ViewController.swift
//  Running Trade
//
//  Created by Fahri Novaldi on 04/10/22.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var trades: [Trade] = []
    var tradeCellIndex: Int = -1
    
    
    let cellHeight: CGFloat = 30
    var tableHeight: CGFloat = 0
    var cellCounts: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Running Trade"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .red
        calculateCell()
        prepareTableView()
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateTradeActivity), userInfo: nil, repeats: true)
    }
    
    private func calculateCell(){
        tableHeight = UIScreen.main.bounds.height - (navigationController?.navigationBar.bounds.height ?? 0)
        cellCounts = Int(tableHeight/cellHeight) - 3
    }
    
    private func prepareTableView() {
        tableView = UITableView()
        
        tableView.register(TradeTableViewCell.self, forCellReuseIdentifier: TradeTableViewCell.reuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = false
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func updateTradeActivity() {
//        tradeCellIndex = tradeCellIndex == Int.max ? 0 : (tradeCellIndex + 1) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                print(tradeCellIndex)
//            })
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: DispatchWorkItem(block: { [self] in
            
            
            if self.trades.count - 1 < cellCounts {
                self.trades.append(Trade.generateRandom())
            } else {
                self.trades.remove(at: self.tradeCellIndex)
                self.trades.insert(Trade.generateRandom(), at: self.tradeCellIndex)
            }
            
            tradeCellIndex = (tradeCellIndex == cellCounts - 1) ? 0 : (tradeCellIndex + 1)
            let index = IndexPath(row: tradeCellIndex, section: 0)

            self.tableView.reloadRows(at: [index], with: .middle)
        }))
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(cellHeight+2)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TradeTableViewCell.reuseID) as! TradeTableViewCell
        
        cell.prepareCell()
        if !trades.isEmpty {
            DispatchQueue.main.async { [weak self] in
                cell.updateCell(with: (self?.trades[indexPath.row])!)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TradeTableViewCell.returnHeader()
    }
}

