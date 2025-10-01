//
//  GameOverPopup.swift
//  C08
//
//  Created by Gustavo Souto Pereira on 01/10/25.
//

import SwiftUI

struct GameOverPopup: View {
    var points: Int
    var onRestart: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Game Over")
                .font(.title)
                .bold()
                .foregroundColor(.red)
            
            Text("Pontuação final: \(points)")
                .font(.title3)
                .foregroundColor(.primary)
            
            Button(action: onRestart) {
                Text("Reiniciar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(.black.opacity(0.8))
        .cornerRadius(20)
        .shadow(radius: 15)
        .padding(.horizontal, 40)
    }
}

