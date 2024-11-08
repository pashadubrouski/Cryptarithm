//
//  CText.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 3.11.24.
//

import SwiftUI

struct CText: View {
    private let text: String
    private let size: CGFloat

    init(text: String,  _ size: CGFloat) {
        self.text = text
        self.size = size
    }

    var body: some View {
        Text(LocalizedStringKey(text))
            .font(.custom("ChalkboardSE-Bold", size: size))            
    }
}

#Preview {
    CText(text: "", 10)
}
