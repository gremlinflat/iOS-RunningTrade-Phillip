//
//  TradeTableViewCell.swift
//  Running Trade
//
//  Created by Fahri Novaldi on 04/10/22.
//

import UIKit

class TradeTableViewCell: UITableViewCell {
    static let reuseID: String = "tradecell"
    
    let stockLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    let chgLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    let volLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    let actLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        prepareCell()
    }
    
    func prepareCell(){
        let stack: UIStackView = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        contentView.addSubview(stack)
        
        stack.addArrangedSubview(stockLabel)
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(chgLabel)
        stack.addArrangedSubview(volLabel)
        stack.addArrangedSubview(actLabel)
        stack.addArrangedSubview(timeLabel)
        
        stockLabel.text = "--"
        priceLabel.text = "--"
        chgLabel.text = "--"
        volLabel.text = "--"
        actLabel.text = "--"
        timeLabel.text = "--"
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2)
        ])
    }
    static func returnHeader() -> UIView {
        let header = TradeTableViewCell()
        header.prepareCell()
        
        header.stockLabel.text = "STOCK"
        header.priceLabel.text = "PRICE"
        header.chgLabel.text = "CHG"
        header.volLabel.text = "VOL"
        header.actLabel.text = "ACT"
        header.timeLabel.text = "TIME"
        
        header.contentView.backgroundColor = .systemBlue
        
        return header.contentView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func updateCell(with trade: Trade) {
        
        stockLabel.text = trade.stockID
        priceLabel.text = String(format: "%.2f", trade.price)
        chgLabel.text = String(format: "%.2f", trade.chg) + " %"
        volLabel.text = String(format: "%.2f", trade.volume)
        actLabel.text = trade.act.rawValue
        timeLabel.text = trade.time
        
        if trade.chg < 0 {
            colorizeCell(with: .negative)
        } else if trade.chg > 0{
            colorizeCell(with: .positive)
        }
        
        switch trade.act {
        case .BU:
            actLabel.textColor = .systemGreen
        case .SD:
            actLabel.textColor = .systemRed
        }
        
    }
    
    enum tradeChanges {
        case positive
        case negative
    }
    
    private func colorizeCell(with status: tradeChanges) {
        switch status {
        case .positive:
            stockLabel.textColor = .systemGreen
            priceLabel.textColor = .systemGreen
            chgLabel.textColor = .systemGreen
        case .negative:
            stockLabel.textColor = .systemRed
            priceLabel.textColor = .systemRed
            chgLabel.textColor = .systemRed
        }
    }
}
