//
//  CommonUtils.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 20.03.2022.
//

import SwiftUI

struct CommonUtils {
    
    public static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
