//
//  Header.swift
//  C08
//
//  Created by Gustavo Souto Pereira on 01/10/25.
//

import Foundation
import SwiftUI

struct HeaderView: View{
    @ObservedObject var manager: ViewModel
   
    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            Text("O que é, O que é?")
                .font(.custom("Avenir-Black", size: 34))
                .foregroundColor(Color.blue)
                .shadow(
                    color: Color.black.opacity(0.1),
                    radius: 2,
                    x: 0,
                    y: 1
                )
                .padding(.top, 20)

            Text("Adivinhe os animais pelas dicas!")
                .font(.custom("Avenir-Book", size: 18))
                .foregroundColor(.secondary)

            HStack(spacing: 16) {
                // Vidas
                HStack(spacing: 6) {
                    ForEach(0..<max(manager.lives, 0), id: \.self) { _ in
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.pink)
                            .shadow(
                                color: .pink.opacity(0.4),
                                radius: 4,
                                x: 0,
                                y: 2
                            )
                    }
                }

                Spacer()

                Text("⭐ \(manager.points)")
                    .font(.custom("Avenir-Heavy", size: 18))
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.8))
                            .shadow(radius: 2)
                    )
            }
        }
        .padding(.horizontal)
    }
}

