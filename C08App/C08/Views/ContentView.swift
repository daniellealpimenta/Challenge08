//
//  ContentView.swift
//  C08
//
//  Created by Daniel Leal PImenta on 25/09/25.
//

import HumanSpeech
import SwiftUI

struct ContentView: View {

    @StateObject private var manager = ViewModel()
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @State private var isButtonDisabled = false

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
                HeaderView(manager: manager)

                // Dicas
                dicas

                Text(speechRecognizer.transcript)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Feedback de resposta
                feedbackAnswer

                // Botão de gravação estilizado
                recordButton

            }
        }.onAppear {
            let resposnse = manager.startGame()
            manager.description = resposnse[0]
            manager.animal = resposnse[1]
        }
        .onDisappear {
            if isRecording {
                speechRecognizer.stopTranscribing()
                isRecording = false
            }
        }
        .overlay {
            if manager.showGameOver {
                GameOverPopup(points: manager.points) {
                    manager.restartGame()

                    manager.showGameOver = false
                }

            }
        }

    }
    
    private var dicas: some View {
        VStack(spacing: 16) {

            Text("Dicas")
                .font(.custom("Avenir-Heavy", size: 24))
                .foregroundColor(.blue)

            ComponentCardView(
                title: "Dica 1 - 30 pontos",
                text: manager.description
            )

            if manager.lives == 2 {
                ComponentCardView(
                    title: "Dica 2 - 20 pontos",
                    text: manager.description2
                )
                .blur(radius: 5)
            } else {
                ComponentCardView(
                    title: "Dica 2 - 20 pontos",
                    text: manager.description2
                )
            }

        }
        .padding(.horizontal)
    }

    private var feedbackAnswer: some View {
        HStack(spacing: 8) {
            if let correct = manager.correct {
                Text(
                    correct ? "Resposta Correta" : "Resposta Incorreta"
                )
                .font(.custom("Avenir-Heavy", size: 20))
                .foregroundColor(correct ? .green : .red)

                Image(
                    systemName: correct
                        ? "checkmark.circle.fill" : "x.circle.fill"
                )
                .foregroundColor(correct ? .green : .red)
                .imageScale(.large)

            }
        }
        .opacity(manager.correct == nil ? 0 : 0.85)
        .animation(.easeInOut(duration: 0.5), value: manager.correct)
    }
    
    private var recordButton: some View {
        Button(action: toggleRecording) {
            VStack(spacing: 8) {
                Image(systemName: "mic.fill")
                    .resizable()
                    .frame(width: 30, height: 40)
                    .padding(25)
                    .background(
                        Circle().fill(
                            LinearGradient(
                                colors: isRecording
                                    ? [Color.red, Color.red.opacity(0.8)]
                                    : [Color.blue.opacity(0.8), Color.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    )
                    .foregroundColor(.white)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.4), lineWidth: 3)
                    )
                
                Text("Gravar resposta")
                    .font(.custom("Avenir-Medium", size: 16))
                    .foregroundColor(.blue)
            }
        }
        .disabled(isButtonDisabled)
        .opacity(isButtonDisabled ? 0.6 : 1)
        .buttonStyle(PlainButtonStyle())
        .padding(.bottom, 40)
    }

    private func toggleRecording() {
        guard !isButtonDisabled else { return }

        isRecording.toggle()

        if isRecording {
            speechRecognizer.startTranscribing()
            manager.answer = speechRecognizer.transcript
        } else {
            manager.answer = speechRecognizer.transcript
            manager.answer = manager.answer.removingAccents()
            manager.answer = manager.answer.lowercased()
            speechRecognizer.stopTranscribing()
            manager.checkAnswer()

            isButtonDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isButtonDisabled = false
            }
        }
    }

}

extension String {
    func removingAccents() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}

#Preview {
    ContentView()
}
