//
//  CityCVCell.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import UIKit

class CityCVCell: UICollectionViewCell {
    // MARK: - Static properties
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    // MARK: - UI Element
    @IBOutlet weak var cityName: UILabel!
    
    // MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
        setupView()
    }

    // MARK: prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        cityName.text = nil
    }
    
    // MARK: initView
    func initView() {
        backgroundColor = AppColors.Background.lightBlue
        layer.cornerRadius = Constants.cornerRadius
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsets.zero
    }
    
    // MARK: setupView
    func setupView() {
        cityName.textColor = AppColors.Text.white
        cityName.font = UIFont.boldSystemFont(ofSize: Constants.nameFontWight)
    }
    
    // MARK: setupData
    func setupData(vm: CityCellViewModel) {
        cityName.text = vm.cityName
    }
    
}
// MARK: setupData
extension CityCVCell {
    struct Constants {
        static var cornerRadius: CGFloat = 16
        static var nameFontWight: CGFloat = 30
    }
}
