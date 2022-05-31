//
//  Queue.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 31/05/2022.
//

import Foundation

struct Queue<T> {
    typealias Element = T
    private var elements: [T] = []
    private let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
    }
    mutating func dequeue() -> Element? {
        isEmpty ? nil : elements.removeFirst()
    }
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var isFull: Bool {
        elements.count == limit
    }
    var peek: Element? {
        elements.first
    }
}
