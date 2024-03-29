//
//  SearchWorkoutTableViewCell.swift
//  Workouter
//
//  Created by 이종현 on 2023/04/12.
//

import SnapKit
import UIKit

final class SearchWorkoutTableViewCell: BaseTableViewCell, PassingDataProtocol {
    
    typealias T = Workout
    
    let workoutImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UIFactory.uiLabelWillReturned(title: "name", size: 17)
    let targetLabel: UILabel = UIFactory.uiLabelWillReturned(title: "target", size: 14)
    let equipmentLabel: UILabel = UIFactory.uiLabelWillReturned(title: "equipment", size: 14)
    let plusButton: UIButton = UIFactory.uiImageButtonWillReturned("plus")
    lazy var labelsSTV: UIStackView = UIFactory.uiStackViewWillReturned(views: [nameLabel, targetLabel, equipmentLabel], axis: .vertical, spacing: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setupHierarchy() {
        [workoutImageView, labelsSTV, plusButton].forEach { contentView.addSubview($0) }
    }
    
    override func setupConstraints() {
        [workoutImageView, labelsSTV].forEach { view in
            view.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(10)
                make.width.equalToSuperview().multipliedBy(0.4)
            }
        }
        workoutImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(labelsSTV.snp.leading).inset(10)
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    override func setupUI() {
        nameLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
    }
    
    func passData(_ data: Workout) {
        nameLabel.text = data.name
        targetLabel.text = data.target.rawValue.capitalized
        equipmentLabel.text = data.equipment
        workoutImageView.image = data.gif
    }
    
}

import SwiftUI

#if canImport(SwiftUI) && DEBUG

struct SearchCellPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: UIViewRepresentable
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
struct SearchCellPreviews_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            // Return whatever controller you want to preview
            let vc = SearchWorkoutTableViewCell()
            return vc
        }
    }
}
