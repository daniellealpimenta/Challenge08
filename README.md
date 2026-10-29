<div align="center">

# 🐾 ZooWho

**"O que é, o que é?" de animais, respondido em voz alta.**

Jogo para iPhone em que você ouve duas dicas sobre um animal e responde falando no microfone.
A fala é transcrita no aparelho e um modelo de Machine Learning escolhe o animal de cada rodada.

![Swift](https://img.shields.io/badge/Swift-5-F05138?logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0175C2?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18.5+-000000?logo=apple&logoColor=white)
![Speech](https://img.shields.io/badge/Speech-SFSpeechRecognizer-000000?logo=apple&logoColor=white)
![Core ML](https://img.shields.io/badge/Core%20ML-Create%20ML-34AADC?logo=apple&logoColor=white)
![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-F05138?logo=swift&logoColor=white)

</div>

> [!NOTE]
> Projeto em equipe da **Apple Developer Academy | UCB**. O objetivo era praticar dependências
> externas com o Swift Package Manager: cada parte de "inteligência" do app vive num pacote separado.

---

## 🎯 Como se joga

1. O app sorteia um animal (cachorro, peixe ou pássaro) e mostra a **primeira dica**.
2. Você toca em **Gravar resposta** e fala o nome do animal.
3. Acertou de primeira: **+30 pontos**. Errou: aparece uma **segunda dica**, mais fácil.
4. Acertou com a segunda dica: **+20 pontos**. Errou de novo: **fim de jogo**.

São quase 70 dicas em dois níveis de dificuldade, sorteadas a cada rodada.

## 🧩 Dois pacotes, duas responsabilidades

| Pacote | O que faz |
|---|---|
| [**HumanSpeech**](https://github.com/daniellealpimenta/HumanSpeech) | Criado pela equipe. Encapsula `SFSpeechRecognizer` + `AVAudioEngine` num `actor` que publica a transcrição em tempo real (pt-BR) |
| **AnimalPackage** | Classificador de texto treinado no Create ML que associa uma descrição ao animal, usado para sortear o animal da rodada |

```swift
import HumanSpeech

@StateObject private var speechRecognizer = SpeechRecognizer()

speechRecognizer.startTranscribing()
// ...
manager.answer = speechRecognizer.transcript
manager.checkAnswer()   // procura "cachorro", "peixe" ou "passaro" na frase falada
```

A resposta é aceita mesmo dentro de uma frase ("acho que é um peixe"): o view model procura a
palavra do animal na transcrição, em vez de exigir a fala exata.

## 🧱 Estrutura

```
C08App/C08/
├── ViewModel/ViewModel.swift     regras do jogo, dicas, pontuação e vidas
├── Views/
│   ├── ContentView.swift         dicas, gravação e feedback de acerto/erro
│   └── GameOverPopup.swift
└── Components/                   cabeçalho (pontos e vidas) e cards de dica
```

## 🚀 Como rodar

1. Clone o repositório e abra `C08App/C08.xcodeproj` no Xcode 16 ou mais novo.
2. O Xcode baixa os pacotes pelo Swift Package Manager.
3. Rode num iPhone com iOS 18.5+ (o reconhecimento de fala funciona melhor no aparelho do que no simulador).

As chaves `NSSpeechRecognitionUsageDescription` e `NSMicrophoneUsageDescription` já estão nas
configurações do target, mas com o texto vazio: preencha antes de publicar.

> [!WARNING]
> O repositório do **AnimalPackage** (`Rodrooj/Animal-Package`) não está mais público, então
> hoje o projeto não compila sem ele. O pacote **HumanSpeech** continua disponível e pode ser
> usado em outros apps.

## 👥 Equipe

- [Daniel Leal Pimenta](https://github.com/daniellealpimenta): lógica do jogo (view model), integração dos pacotes e o pacote HumanSpeech
- Gustavo Souto
- Larissa Kailane
- Luciana Liebl
- Manoel Pedro
