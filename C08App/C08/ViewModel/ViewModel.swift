//
//  ViewModel.swift
//  C08
//
//  Created by Daniel Leal PImenta on 30/09/25.
//

import SwiftUI
import Foundation
import AnimalPackage

struct ViewModel {
    
    @State private var animalManager = AnimalPackage()
    private let descriptions: [String] = [
        "Tem quatro patas e é peludo",
        "Tem escamas e vive na água",
        "Tem asas e canta pela manhã"
    ]

    private let descriptionLevel: [(animal: String, level: Int, description: String)] =
    
    [
        ("cachorro", 1, "Gosto de brincar"),
        ("cachorro", 2, "Percebo mudanças em hormonios humanos"),
        ("cachorro", 1, "Posso ser usado em várias funções"),
        ("cachorro", 2, "Sou lembrado como fiel companheiro"),
        ("cachorro", 1, "⁠Não largo do seu pé se eu quiser atenção"),
        ("cachorro", 2, "Identifico emoções humanas pelo cheiro"),
        ("cachorro", 1, "Alguns foram criados para ajudar pessoas em perigo"),
        ("cachorro", 2, "Acompanho missões de resgate"),
        ("cachorro", 1, "Ouço frequências que humanos não percebem"),
        ("cachorro", 2, "Memorizo cheiros por muito tempo"),
        ("cachorro", 1, "Minha temperatura média é de 38,5 °C"),
        ("cachorro", 1, "Tenho glândulas sudoríparas nos membros inferiores"),
        ("cachorro", 2, "Auxilio pessoas com deficiência"),
        ("cachorro", 1, "Algumas raças sentem desastres naturais antes deles acontecerem"),
        ("cachorro", 2, "Sou associado à proteção de lares"),
        ("cachorro", 1, "O desenho do meu nariz é único"),
        ("cachorro", 2, "Sou treinado para encontrar substâncias"),
        ("cachorro", 1, "Sou capaz de sonhar durante o sono REM"),
        ("cachorro", 2, "Participo de terapias para reduzir estresse"),
        ("cachorro", 1, "Alguns percorrem grandes distâncias sem cansar"),
        ("cachorro", 2, "Reajo ao tom de voz do dono"),
        ("cachorro", 1, "Percebo açúcar dissolvido em uma piscina olímpica"),
        ("cachorro", 2, "Reconheço trajetos pelo faro"),
        ("cachorro", 1, "Tenho 42 dentes na fase adulta"),
        ("cachorro", 2, "Alguns foram criados para puxar trenós"),
        
        ("peixe", 1, "Meus olhos estão sempre abertos"),
        ("peixe", 2, "Posso ter muitas cores diferentes"),
        ("peixe", 1, "Não produzo suor nem lágrimas"),
        ("peixe", 2, "Meu corpo é recoberto por estruturas rígidas"),
        ("peixe", 1, "Alguns mudam de cor para se camuflar"),
        ("peixe", 2, "Sou fonte de alimento importante no mundo"),
        ("peixe", 1, "Algumas espécies vivem em ambientes gelados"),
        ("peixe", 2, "Respiro de uma forma diferente dos mamíferos"),
        ("peixe", 1, "Tenho uma linha lateral que percebe vibrações"),
        ("peixe", 2, "Sou comum em rios, lagos e mares"),
        ("peixe", 1, "Algumas espécies mudam de sexo durante a vida"),
        ("peixe", 2, "Sou representado em aquários domésticos"),
        ("peixe", 1, "Meus otólitos registram minha idade"),
        ("peixe", 2, "Muitos vivem reunidos em grandes grupos"),
        ("peixe", 1, "Alguns sobrevivem fora da água por horas"),
        ("peixe", 2, "Alguns sobem cachoeiras para se reproduzir"),
        ("peixe", 1, "Existem espécies que produzem eletricidade"),
        ("peixe", 2, "Sou símbolo de prosperidade em algumas culturas"),
        ("peixe", 1, "Algumas espécies vivem a mais de 8.000 m de profundidade"),
        ("peixe", 2, "Alguns se adaptam à água doce e salgada"),
        ("peixe", 1, "Peixes-boi não são peixes, mas mamíferos"),
        ("peixe", 2, "Estou entre os primeiros vertebrados do planeta"),
        
        ("passaro", 1, "Meus ossos são ocos"),
        ("passaro", 2, "Meu coração pode bater até 1.000 vezes por minuto"),
        ("passaro", 1, "Alguns enxergam luz ultravioleta"),
        ("passaro", 2, "Alguns fazem longas jornadas periódicas"),
        ("passaro", 1, "Tenho uma estrutura específica só para cantar"),
        ("passaro", 2, "Sou lembrado pelo som que produzo ao amanhecer"),
        ("passaro", 1, "Alguns dormem em movimento"),
        ("passaro", 2, "Minhas penas têm várias funções"),
        ("passaro", 1, "Tenho ossos fundidos para suportar esforço"),
        ("passaro", 2, "Faço ninhos para proteger meus filhotes"),
        ("passaro", 1, "Uso a siringe para emitir sons complexos"),
        ("passaro", 2, "Minha linhagem remonta aos dinossauros"),
        ("passaro", 1, "Meu metabolismo é acelerado"),
        ("passaro", 2, "Coloco ovos para me reproduzir"),
        ("passaro", 1, "Alguns percebem o campo magnético da Terra"),
        ("passaro", 2, "Sou visto como símbolo em diferentes culturas"),
        ("passaro", 1, "Algumas espécies imitam vozes humanas"),
        ("passaro", 2, "Muitos de nós vivem em bandos"),
        ("passaro", 1, "Tenho visão lateral quase 360 graus"),
        ("passaro", 2, "Sou associado à ideia de liberdade"),
    ]
    
    func startGame() -> [String] {
        let randomAnimal = self.getRandomAnimal( )
        return [getDescriptionLevels(animal: randomAnimal, level: 1), randomAnimal]
    }
    
    func getRandomAnimal() -> String {
        return animalManager.whatAnimal(descricao: self.descriptions.randomElement() ?? "", nome: "")
    }
    
    func getDescriptionLevels(animal: String, level: Int) -> String {
        
        let descriptions = self.descriptionLevel.filter { $0.animal == animal }
        
        if level == 1 {
            let descriptionsLevel = descriptions.filter { $0.level == 1 }
            
            return descriptionsLevel.randomElement()?.description ?? ""
            
        } else {
            let descriptionsLevel = descriptions.filter { $0.level == 2 }
            
            return descriptionsLevel.randomElement()?.description ?? ""
        }
        
    }
    
    
}
    
