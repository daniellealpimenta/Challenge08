# ZooWho

## ✏️ Descrição do projeto
Este app foi desenvolvido com o objetivo de consolidar o apresendizado sobre dependências externas, framework Speech e machine learning, a partir de tecnologias Apple.

## 🛠️ Tecnologias utilizadas
- Swift Package Manager
- Package: HumanSpeech (SFSpeechRecognizer e AVAudioEngine)
- Package: AnimalPackage (CoreML e CreateML)
- SwiftUI
  
## 🎯 Funcionalidades implementadas
O app funciona como um "O que é, o que é?" para que o usário descubra, a partir de duas dicas, qual é o animal (passáro, cachorro ou peixe) descrito, usando o microfone para transcrever sua resposta. 
A cada rodada o jogador terá 2 vidas, caso acerte o animal com a primeira dica ele ganhará 30 pontos, caso acerte o animal com a segunda dica, ganhará 20 pontos, em ambos os casos, em seguida, aparecerá dicas de um novo animal. Porém, se o jogador perder 2 vidas, o jogo reinicia. 

- AnimalPackge: usado para associar as dicas apresentadas para cada animal com o modelo que identifica animais a partir de suas descrições
- HumanSpeech: captura a fala do usuário e transcreve a resposta
  
## 🚀 Instruções de instalação
1. Clonar o repositório no Xcode
2. O Info.plist deve conter:
  - `NSSpeechRecognitionUsageDescription`
  - `NSMicrophoneUsageDescription`
3. Rodar o app

## 👩‍💻🧑‍💻 Integrantes
- Daniel Leal
- Gustavo Souto
- Larissa Kailane
- Luciana Liebl
- Manoel Pedro
