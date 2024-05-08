//
//  VerificationViewModel.swift
//  furnitureApp
//
//  Created by MacBookPro on 07.05.2024.
//

import Foundation

final class VerificationViewModel: ObservableObject {
    
    @Published var oneTextField = ""
    @Published var twoTextField = ""
    @Published var threTextField = ""
    @Published var fourTextField = ""
    
    var currentCode: [String] = []
    
    func createCode() {
        let code = String(Int.random(in: 1000...9999))
        var numbers: [String] = []
        code.forEach { numbers.append(String($0)) }
        currentCode = numbers
    }
    
    func updateTexts() {
        oneTextField = currentCode[0]
        twoTextField = currentCode[1]
        threTextField = currentCode[2]
        fourTextField = currentCode[3]
    }
}
