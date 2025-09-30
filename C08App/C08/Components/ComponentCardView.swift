//
//  ComponentCardView.swift
//  Challenge8UI
//
//  Created by Larissa Kailane on 29/09/25.
//

import SwiftUI
import Foundation

struct ComponentCardView: View {
    var title: String
    var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(colors: [Color.purple, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.5), radius: 8, x: 0, y: 5)
        .scaleEffect(1.0)
        .onTapGesture {
            withAnimation(.spring()) {
                // efeito de toque
            }
        }
    }
}
#Preview {
    ComponentCardView(title: "Titulo", text: "Texto")
}
