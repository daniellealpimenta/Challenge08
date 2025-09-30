//
//  ContentView.swift
//  C08
//
//  Created by Daniel Leal PImenta on 25/09/25.
//

import SwiftUI
import HumanSpeech

struct ContentView: View {
    // Mantém uma instância do seu SpeechRecognizer no estado da view.
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    // Controla se a gravação está ativa ou não.
    @State private var isRecording = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Espaço para exibir o texto transcrito.
                Text("Texto Transcrito:")
                    .font(.headline)
                
                ScrollView {
                    Text(speechRecognizer.transcript)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 300)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray.opacity(0.5), lineWidth: 1)
                )

                // Botão principal que inicia ou para a detecção de voz.
                Button(action: toggleRecording) {
                    Text(isRecording ? "Parar Detecção" : "Iniciar Detecção de Voz")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isRecording ? Color.red : Color.blue)
                        .cornerRadius(16)
                }
                
                // Botão para limpar o texto transcrito.
                Button(action: {
                    speechRecognizer.resetTranscript()
                }) {
                    Text("Limpar Texto")
                }
                .disabled(speechRecognizer.transcript.isEmpty)

                Spacer()
            }
            .padding()
            .navigationTitle("Detecção de Voz")
            .onDisappear {
                // Garante que a transcrição pare se a view desaparecer.
                if isRecording {
                    speechRecognizer.stopTranscribing()
                    isRecording = false
                }
            }
        }
    }
    
    /// Alterna o estado de gravação.
    private func toggleRecording() {
        isRecording.toggle()
        
        if isRecording {
            speechRecognizer.startTranscribing()
        } else {
            speechRecognizer.stopTranscribing()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
