//
//  Int.swift
//  Corona
//
//  Created by Sajith Konara on 3/19/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
