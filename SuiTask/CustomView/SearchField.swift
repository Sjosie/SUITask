//
//  SearchField.swift
//  SuiTask
//
//  Created by Evgeny Protopopov on 20.03.2022.
//

import SwiftUI

struct SearchField: View {
    
    @Binding var text: String
    @State private var isButtonShown = false
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    TextField("Search...", text: $text, onEditingChanged: { (editingChanged) in
                        isButtonShown = editingChanged
                    })
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                    if !text.isEmpty {
                        Button(action: {text.removeAll()}){
                            Image(systemName: "xmark.circle.fill")
                        }
                        .padding(.trailing, 8)
                        .foregroundColor(.gray)
                    }
                }.background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
                if isButtonShown {
                    Button(action: {buttonClicked()}) {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }.padding(.leading, 8)
                }
            }
        }
        .multilineTextAlignment(.leading)
        .padding()
    }
    
    private func buttonClicked() {
        CommonUtils.hideKeyboard()
        isButtonShown = false
    }
}
