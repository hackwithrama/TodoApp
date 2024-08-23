//
//  ProgressiveBar.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import SwiftUI

struct ProgressiveBar: View {
    var width: CGFloat = 300
    var height: CGFloat = 30
    var percentage: CGFloat = 69
    
    
    var body: some View {
        let multiplier = width / 100
        VStack(spacing: 2){
            Text("\(Int(percentage))% completed")
                .foregroundStyle(.grayDark)
                .fontWeight(.semibold)
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(width: width, height: height)
                    .foregroundColor(.white.opacity(0.5))
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(width: percentage * multiplier, height: height)
                    .foregroundStyle(LinearGradient(colors: [.grayLight, .grayMedium, .grayDark], startPoint: .leading, endPoint: .trailing))
            }
        }
        .padding()
        .animation(.easeOut(duration: 0.5), value: percentage)
    }
}

#Preview {
    ProgressiveBar()
}
