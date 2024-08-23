//
//  CustomGroupBox.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 23/08/24.
//

import Foundation
import SwiftUI

struct CustomGroupBoxStyle: GroupBoxStyle{
    func makeBody(configuration: Configuration) -> some View {
        VStack{
            configuration.content
                .padding(10)
        }
        .background(Color.grayLight)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
