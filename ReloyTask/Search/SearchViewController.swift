//
//  SearchViewController.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import Foundation
import UIKit
import Kingfisher

class SearchViewController : BaseViewController {
    //    MARK: @IBOutlet
    @IBOutlet weak var myCollectionView: UICollectionView!
    let searchViewModel = SearchViewModel()
    let spacing:CGFloat = 5.0

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photos"
        configUI()
    }
    
    //MARK: - Privates
    private func configUI() {
        searchController.searchBar.delegate = self
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.myCollectionView?.collectionViewLayout = layout
    }
    
    private func callService (searchT: String) {
                
        if Reachability.isConnectedToNetwork(){
            startActivityIndicator()
            searchViewModel.fetchPhotos(searchText: searchT) {[weak self] (isSuccess, error) in
                            
                guard let strongSelf = self else { return }
                
                strongSelf.stopActivityIndicator()
                if error != nil {
                    strongSelf.showAlert(title: AlertMessages.error, message: error?.localizedDescription ?? AlertMessages.somethingWentWrong)
                } else{
                    
                    if let result = strongSelf.searchViewModel.searchModel {
                        if result.hits?.count == 0 {
                            strongSelf.showAlert(title: AlertMessages.noDataAvailable, message: "")
                            
                        }else{
                            DispatchQueue.main.async {
                                strongSelf.myCollectionView.reloadData()
                            }
                        }
                    }
                }
            }
        } else {
            print("network not available")
            self.showAlert(title: AlertMessages.networkTitle, message: AlertMessages.networkMessage)
        }
        
    }
    
}
extension SearchViewController:  UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text else {return}
        print(searchText)
        callService(searchT: searchText)
        print("searched clicked")
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchViewModel.searchModel?.reset()
            myCollectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        stopActivityIndicator()
        searchViewModel.searchModel?.reset()
        myCollectionView.reloadData()
        print("search canceked")
    }
    
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCvCell.cellIdentifier, for:indexPath) as? SearchCvCell else {
            return UICollectionViewCell()
        }
        
        cell.hit = searchViewModel.searchModel?.hits?[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchViewModel.updateSelectedPostion(selectedPosition: indexPath.row)
        collectionView.reloadData()

        if let vc = storyboard?.instantiateViewController(withIdentifier: StoryBoardIds.previewVc) as? PreviewViewController {
            vc.hitModel = searchViewModel.searchModel?.hits?[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = spacing
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.myCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
}
