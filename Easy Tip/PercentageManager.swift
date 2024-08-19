//
//  PercentageManager.swift
//  Easy Tip
//
//  Created by Hannah Jacob on 6/20/24.
//

import Foundation

extension FileManager {
    func readTipPercentages() -> [Int] {
        let fileURL = getDocumentDirectory().appendingPathComponent("tipPercentages.txt")
        guard let data = try? Data(contentsOf: fileURL),
              let content = String(data: data, encoding: .utf8) else {
            return [5, 10, 15, 18, 20, 22, 25] // Default percentages
        }
        return content.split(separator: "\n").compactMap { Int($0) }
    }
    
    func saveTipPercentages(_ percentages: [Int]) {
        let fileURL = getDocumentDirectory().appendingPathComponent("tipPercentages.txt")
        let content = percentages.map { String($0) }.joined(separator: "\n")
        try? content.write(to: fileURL, atomically: true, encoding: .utf8)
    }
    
    private func getDocumentDirectory() -> URL {
        return urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

