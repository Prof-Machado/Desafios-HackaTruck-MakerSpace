import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack(spacing: 12)
        {
            
            Image(("download_IMG_desafio02")) // nome da imagem
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle()) // imagem arredondada
         //txt01
            Text("UFPA")
                .font(.title)
                .fontWeight(.bold)
            
            //txt02
            Text("Universidade Federal do Pará")
                .font(.headline)
            
            //txt03
            Text("Belém/PA")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        
        //posicionamento do leyout
        .frame(maxWidth: .infinity, maxHeight: .infinity) // ocupa toda a tela
        .multilineTextAlignment(.center) // centraliza os textos
    }
}

#Preview {
    ContentView()
}
