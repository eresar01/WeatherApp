//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import UIKit

class CitiesViewController: UIViewController {
    // MARK: - UI Element
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    lazy var viewModel = { CitiesViewModel() }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupView()
        initViewModel()
    }

    // MARK: Setup collection
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CityCVCell.nib, forCellWithReuseIdentifier: CityCVCell.identifier)
        collectionView.backgroundColor = .clear
    }
    
    func setupView() {
        navigationItem.title = "Weather"
        view.backgroundColor = AppColors.Background.default
    }
    
    func initViewModel() {
        // Get cities data
        viewModel.getCities()
        
        // Reload CollectionView closure
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: Collection View
extension CitiesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cityCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCVCell.identifier, for: indexPath) as? CityCVCell else { fatalError("xib does not exists") }
        let vm = viewModel.getCellViewModel(at: indexPath)
        cell.setupData(vm: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(target: self, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeInItem(viewItem: collectionView)
    }
    
    func sizeInItem(viewItem: UICollectionView) -> CGSize {
        let height = viewItem.layer.bounds.height
        let width = viewItem.layer.bounds.width
        // We take out spacings from the whole height of the collection and we divide the remaining by 7 to decide the item height
        let itemHeight = (height - (Constants.itemConteins * 8)) / 7
        // We take out spacings from the whole width of the collection to decide the item width
        let itemWidht = width - (2 * Constants.itemPadding)
        return CGSize(width: itemWidht, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let constants = Constants.itemConteins
        return UIEdgeInsets(top: constants, left: constants, bottom: constants, right: constants)
    }
    
    // Spacing top or bottom
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.itemConteins
    }
    
    // Spacing right or left
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.itemConteins
    }
}

// MARK: Constants
extension CitiesViewController {
    struct Constants {
        static var itemPadding: CGFloat = 32
        static var itemConteins: CGFloat = 8
    }
}
