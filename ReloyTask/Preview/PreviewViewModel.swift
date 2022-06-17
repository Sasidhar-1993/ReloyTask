//
//  PreviewViewModel.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import Foundation

class PreviewViewModel {
    
    var imageModelArray = [PreviewModel]()

    func createModelData(hitModel:Hit?){
        
        
        let imageWidth = String(hitModel?.imageWidth ?? 0)
        let imageHeight = String(hitModel?.imageHeight ?? 0)

        imageModelArray.append(PreviewModel(desc: hitModel?.largeImageURL, typeMode: .image))
        imageModelArray.append(PreviewModel(desc: "User Name : " + String(hitModel?.user ?? "") ,typeMode: .text))
        imageModelArray.append(PreviewModel(desc: "Tags : " +  String(hitModel?.tags ?? ""), typeMode: .text))
        imageModelArray.append(PreviewModel(desc: "Resolution : " + imageWidth + " x " + imageHeight ,typeMode: .text))
    }
}
