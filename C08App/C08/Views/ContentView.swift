
//
//  ContentView.swift
//  C08
//
//  Created by Daniel Leal PImenta on 25/09/25.
//


import SwiftUI
import HumanSpeech

struct ContentView: View {
    
    @State private var points: Int = 0
    @State private var lives: Int = 3
    
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false

    
    var body: some View {
        ZStack {
            // Fundo com gradiente suave + textura leve
            LinearGradient(
                colors: [Color.blue.opacity(0.15), Color.purple.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                // Cabeçalho
                VStack(alignment: .leading, spacing: 10) {
                    Text("O que é, O que é?")
                        .font(.custom("Avenir-Black", size: 34))
                        .foregroundColor(Color.blue)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                    
                    Text("Adivinhe os animais pelas dicas!")
                        .font(.custom("Avenir-Book", size: 18))
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 16) {
                        // Vidas
                        HStack(spacing: 6) {
                            ForEach(0..<lives, id: \.self) { _ in
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.pink)
                                    .shadow(color: .pink.opacity(0.4), radius: 4, x: 0, y: 2)
                            }
                        }
                        
                        Spacer()
                        
                        Text("⭐ \(points)")
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
                
                // Dicas
                VStack(spacing: 16) {
                    Text("Dicas")
                        .font(.custom("Avenir-Heavy", size: 24))
                        .foregroundColor(.blue)
                    
                    ComponentCardView(title: "Dica 1 - 30 pontos", text: "Conteúdo da primeira dica")
                    ComponentCardView(title: "Dica 2 - 20 pontos", text: "Conteúdo da segunda dica")
                    ComponentCardView(title: "Dica 3 - 10 pontos", text: "Conteúdo da terceira dica")
                }
                .padding(.horizontal)
                
                Text(speechRecognizer.transcript)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                
                Spacer()
                
                // Feedback de resposta
                HStack(spacing: 8) {
                    Text("Resposta Incorreta")
                        .font(.custom("Avenir-Heavy", size: 20))
                        .foregroundColor(.red)
                    
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .imageScale(.large)
                }
                .opacity(0.85)
                
                // Botão de gravação estilizado
                Button(action: {
                    toggleRecording()
                    print("Iniciou a gravação")
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(25)
                            .background(
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: isRecording ? [Color.red, Color.red.opacity(0.8)] : [Color.blue.opacity(0.8), Color.blue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                            .foregroundColor(.white)
                            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.4), lineWidth: 3)
                            )
                        
                        Text("Gravar resposta")
                            .font(.custom("Avenir-Medium", size: 16))
                            .foregroundColor(.blue)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 40)
            }
        }.onDisappear {
            // Garante que a transcrição pare se a view desaparecer.
            if isRecording {
                speechRecognizer.stopTranscribing()
                isRecording = false
            }
        }

    }
    
    func checarResposta() {
        // lógica para verificar resposta
    }
    
    private func toggleRecording() {
        isRecording.toggle()
        
        if isRecording {
            speechRecognizer.startTranscribing()
        } else {
            speechRecognizer.stopTranscribing()
        }
    }

}

#Preview {
    ContentView()
}


