//
//  BackgroundMod.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 23/08/24.
//

import Foundation
import SwiftUI


struct ListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .shadow(color: .black.opacity(0.3), radius: 10)
            .padding(.vertical, 0)
            .frame(maxWidth: 640)
    }
}

#Preview {
    Text("Hello, world!")
        .modifier(ListBackgroundModifier())
}
