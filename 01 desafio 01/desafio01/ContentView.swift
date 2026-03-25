//
//  ContentView.swift
//  desafio01
//
//  Created by Turma02-10 on 11/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
 
        //1. add -> comandos de formas geometricas
        
        ZStack{
            VStack{
                
                //positionpart01 (encaixe de positon)
                HStack{
                   
                    //2. formageometrica 01 (vermelha,superior,esquerda)
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                    
                    
                    //3. formageometrica 02 (azul,superior,direita)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                }
                
                Spacer()
                
                
                //positionpart02 (encaixe de positon)
                HStack {
                    
                    //4. formageometrica 03 (verde,inferior,esquerda)
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                    
                    
                    //5. formageometrica 04 (amarela,inferior,direita)
                    
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(width: 100, height: 100)
                    
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
