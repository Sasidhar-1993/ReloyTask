//
//  SearchViewModel.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import Foundation

typealias responseClosure = (Bool, Error?) -> Void

protocol PhotosDetailService {
    func fetchPhotos(searchText: String, complitionHandler: @escaping responseClosure)
}

class SearchViewModel: PhotosDetailService {
    let photosDetailUrl = "https://pixabay.com/api/?key=27723096-c7018f4a6b827cace9fc6d737&q=%@&image_type=photo&pretty=true"
    var searchModel : SearchModel?
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)

    func fetchPhotos(searchText: String ,complitionHandler: @escaping responseClosure) {
        dataTask?.cancel()

        guard let url = URL(string: String(format: photosDetailUrl, "\(searchText)") ) else {
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        request.httpMethod = "GET"
        
        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            guard error  == nil else {
                complitionHandler(false, error)
                return
            }
            
            guard let result = data else {
                complitionHandler(false, error)
                return
            }
            
            do {
                self?.searchModel = try JSONDecoder().decode(SearchModel.self, from: result)
                complitionHandler(true, nil)
            }catch (let error){
                complitionHandler(false, error)
            }
        }
        dataTask?.resume()
    }
    
    func updateSelectedPostion(selectedPosition: Int) {
        
        searchModel?.hits?.indices.forEach {
            searchModel?.hits?[$0].isSelected = nil
        }

        searchModel?.hits?[selectedPosition].isSelected = true
        
    }
    
    var numberOfItemsInSection : Int {
        return searchModel?.hits?.count ?? 0
    }
    
}

