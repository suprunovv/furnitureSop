//
//  LoginViewModel.swift
//  furnitureApp
//
//  Created by MacBookPro on 06.05.2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var numberText = ""
    @Published var passwordText = ""
    @Published var isSecurePassword = true 
    
    
    func format(mask: String, phone: String) -> String {
        let number = phone.replacingOccurrences(of: "[^0-9]",
                                                with: "",
                                                options: .regularExpression)
        var result = ""
        var index = number.startIndex
        for char in mask where index < number.endIndex {
            if char == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
