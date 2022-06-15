//
//  ChankedArray.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 08/06/2022.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
