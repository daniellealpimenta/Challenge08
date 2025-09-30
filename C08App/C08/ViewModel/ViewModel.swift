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
        ("cachorro", 2, "Consigo perceber mudanças em hormonios humanos só de sentir o cheiro"),
        ("cachorro", 1, "Posso ser usado em várias funções"),
        ("cachorro", 2, "Sou conhecido por ser o melhor amigo do homem"),
        ("cachorro", 1, "⁠Não vou largar do seu pé se eu quiser atenção"),
        ("cachorro", 2, "Consigo sentir o cheiro de medo e estresse"),
        ("peixe", 1, "Meus olhos estão sempre abertos"),
        ("peixe", 2, "Posso ser de várias cores"),
        ("peixe", 1, "Vivo em um ambiente sem ar"),
        ("peixe", 2, "Escamas protegem o meu corpo"),
        ("peixe", 1, "Não produzo suor, nem lágrimas"),
        ("peixe", 2, "Consigo detectar vibrações por uma linha lateral no corpo"),
        ("passaro", 1, "⁠Meus ossos são ocos"),
        ("passaro", 2, "Meu coração pode bater até 1.000 vezes por minuto"),
        ("passaro", 1, "Alguns de nós conseguem enxergar luz ultravioleta"),
        ("passaro", 2, "Posso percorrer milhares de quilômetros"),
        ("passaro", 1, "Eu tenho uma estrutura específica só para cantar"),
        ("passaro", 2, "Consigo traçar mapas invisiveis ao vento"),
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
    
