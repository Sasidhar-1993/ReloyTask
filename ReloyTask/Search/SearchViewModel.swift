//
//  SearchViewModel.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import Foundation

typealias responseClosure = (Bool, Error?) -> Void

class SearchViewModel {
    
    var searchModel : SearchModel?
    
    func fetchImages(searchText: String ,complitionHandler: @escaping responseClosure) {
        
        let urlString = "https://pixabay.com/api/?key=27723096-c7018f4a6b827cace9fc6d737&q=\(searchText)&image_type=photo&pretty=true"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error  == nil else {
                complitionHandler(false, error)
                return
            }
            
            guard let result = data else {
                complitionHandler(false, error)
                return
            }
            
            do {
                self.searchModel = try JSONDecoder().decode(SearchModel.self, from: result)
                complitionHandler(true, nil)
            }catch (let error){
                complitionHandler(false, error)
            }
        }
        dataTask.resume()
    }
    
    func updateSelectedPostion(selectedPosition: Int) {
        
        searchModel?.hits?.indices.forEach {
            searchModel?.hits?[$0].isSelected = nil
        }

        searchModel?.hits?[selectedPosition].isSelected = true
        
    }
}

