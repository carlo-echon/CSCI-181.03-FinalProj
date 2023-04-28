//
//  DoubleExtension.swift
//  FinalProj-CSCI-181.03
//
//  Created by Carlo Echon on 4/26/23.
//

import Foundation

extension Double {
    var kelvinToFarenheit: Double {
        return (9.0 / 5) * (self - 273) + 32
    }
}
