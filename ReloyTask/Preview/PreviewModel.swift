//
//  PreviewModel.swift
//  ReloyTask
//
//  Created by Sasidhar Reddy on 14/06/22.
//

import Foundation

enum TypeMode {
    case image, text
}

struct PreviewModel {
    var desc: String?
    var typeMode: TypeMode?
}
