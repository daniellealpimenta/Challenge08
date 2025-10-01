//
//  ContentView.swift
//  C08
//
//  Created by Daniel Leal PImenta on 25/09/25.
//

import HumanSpeech
import SwiftUI

struct ContentView: View {

    @State private var points: Int = 0
    @State private var lives: Int = 2
    @State private var showGameOver = false
    @State public var answer: String = ""
        .lowercased()
    @State private var isButtonDisabled = false
    @State public var animal: String = ""

    @State public var correct: Bool?

    private var words: [String] = ["cachorro", "peixe", "passaro"]

    @StateObject private var speechRecognizer = SpeechRecognizer()

    @State private var isRecording = false
    @State private var manager = ViewModel()

    @State private var description: String = " "
    @State private var description2: String = " "

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
                            ForEach(0..<max(lives, 0), id: \.self) { _ in
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

                    ComponentCardView(
                        title: "Dica 1 - 30 pontos",
                        text: description
                    )

                    if lives == 2 {
                        ComponentCardView(
                            title: "Dica 2 - 20 pontos",
                            text: description2
                        )
                        .blur(radius: 5)
                    } else {
                        ComponentCardView(
                            title: "Dica 2 - 20 pontos",
                            text: description2
                        )
                    }

                }
                .padding(.horizontal)

                Text(speechRecognizer.transcript)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Feedback de resposta
                HStack(spacing: 8) {
                    if let correct = correct {
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
                .opacity(correct == nil ? 0 : 0.85)
                .animation(.easeInOut(duration: 0.5), value: correct)

                // Botão de gravação estilizado
                Button(action: {
                    toggleRecording()
                }) {
                    VStack(spacing: 8) {
                        VStack {

                            Image(systemName: "mic.fill")
                                .resizable()
                                .frame(width: 30, height: 40)
                        }

                        .padding(25)
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: isRecording
                                            ? [
                                                Color.red,
                                                Color.red.opacity(0.8),
                                            ]
                                            : [
                                                Color.blue.opacity(0.8),
                                                Color.blue,
                                            ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                        .foregroundColor(.white)
                        .shadow(
                            color: Color.blue.opacity(0.3),
                            radius: 10,
                            x: 0,
                            y: 5
                        )
                        .overlay(
                            Circle()
                                .stroke(
                                    Color.white.opacity(0.4),
                                    lineWidth: 3
                                )
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
        }.onAppear {
            let resposnse = manager.startGame()
            description = resposnse[0]
            animal = resposnse[1]
        }
        .onDisappear {
            // Garante que a transcrição pare se a view desaparecer.
            if isRecording {
                speechRecognizer.stopTranscribing()
                isRecording = false
            }
        }
        .overlay {
            if showGameOver {
                GameOverPopup(points: points) {
                    restartGame()

                    showGameOver = false
                }

            }
        }

    }

    private func checkAnswer() {

        if let foundWord = words.first(where: { word in answer.contains(word) })
        {

            if foundWord == animal {
                correct = true
                if lives == 2 {
                    points += 30
                    let response = manager.startGame()
                    description = response[0]
                    animal = response[1]
                    lives = 2
                } else {
                    points += 20
                    let response = manager.startGame()
                    description = response[0]
                    animal = response[1]
                    lives = 2
                }

            } else {
                lives -= 1
                correct = false
                description2 = manager.getDescriptionLevels(
                    animal: animal,
                    level: 2
                )
            }
        } else {
            lives -= 1
            correct = false
            description2 = manager.getDescriptionLevels(
                animal: animal,
                level: 2
            )
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                correct = nil
            }
        }

        if lives <= 0 {
            showGameOver = true

        }
    }
    private func toggleRecording() {
        guard !isButtonDisabled else { return }

        isRecording.toggle()

        if isRecording {
            speechRecognizer.startTranscribing()
            answer = speechRecognizer.transcript
        } else {
            answer = speechRecognizer.transcript
            answer = answer.removingAccents()
            answer = answer.lowercased()
            speechRecognizer.stopTranscribing()
            checkAnswer()

            isButtonDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                isButtonDisabled = false
            }
        }
    }

    private func restartGame() {
        lives = 2
        points = 0
        correct = nil
        let response = manager.startGame()
        description = response[0]
        animal = response[1]
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
