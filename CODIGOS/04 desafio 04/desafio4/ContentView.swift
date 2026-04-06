import SwiftUI

struct ContentView: View {
    
    //VALORES INICIAIS
    @State private var distance: String = ""
    @State private var time: String = ""
    @State private var speed: Double = 0.0
    @State private var backgroundColor: Color = .gray
    @State private var iconImage: String? = nil
    
    // Países de origem dos animais
    let animalOrigin: [String: String] = [
        "TARTARUGA": "MUNDO TODO",
        "elefante": "ÁFRICA/ÁSIA",
        "avestruz": "ÁFRICA",
        "leao": "ÁFRICA/ÍNDIA",
        "guepardo": "ÁFRICA"
    ]
    
    var body: some View {
        ZStack {
            
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                
// FUNDO PRINCIPAL


                //TEXTO DE KM
                Text("Digite a distância (km)")
                    .font(.headline)
                
                //ENTRADA DE KM
                TextField("0", text: $distance)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
                
                //TEXTO DE HORA
                Text("Digite o tempo (h)")
                    .font(.headline)
                
                //ENTRADA DE HORA
                TextField("0", text: $time)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .frame(width: 200)
                
                //BOTÃO
                Button("Calcular") {
                    calculateSpeed()
                }
                .padding()
                .background(.black)
                .foregroundColor(.orange)
                .cornerRadius(8)
                
                //CONTADOR DE VELOCIDADE
                Text("\(speed, specifier: "%.2f") km/h")
                    .font(.system(size: 40, weight: .bold))
                
                // Imagem dos animais
                if let imageName = iconImage {
                    VStack(spacing: 5) {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white, lineWidth: 3))
                            .shadow(radius: 5)
                        
                        // Nome do animal
                        Text(imageName.uppercased())
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        // País do animal
                        if let origin = animalOrigin[imageName] {
                            Text(origin)
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }
                } else {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.orange)
                        .shadow(radius: 5)
                }
                
                Spacer()
                
                
                //legenda
                VStack(alignment: .leading, spacing: 5) {
                    LegendItem(animal: "TARTARUGA", range: "(0 - 9.9 km/h)", color: Color("VERDE01"))
                    LegendItem(animal: "ELEFANTE", range: "(10 - 29.9 km/h)", color: Color("AZUL01"))
                    LegendItem(animal: "AVESTRUZ", range: "(30 - 69.9 km/h)", color: Color("LARANJA01"))
                    LegendItem(animal: "LEÃO", range: "(70 - 89.9 km/h)", color: Color("AMARELO01"))
                    LegendItem(animal: "GUEPARDO", range: "(90 - 130 km/h)", color: Color("VERMELHO01"))
                }
                .padding()
                .background(.black)
                .cornerRadius(10)
                .foregroundColor(.white)
            }
            .padding()
        }
    }
    
//calculo de velocidade
    func calculateSpeed() {
        guard let dist = Double(distance.replacingOccurrences(of: ",", with: ".")),
              let t = Double(time.replacingOccurrences(of: ",", with: ".")),
              t > 0 else {
            speed = 0
            iconImage = nil
            backgroundColor = .gray
            return
        }
        
        // velocidade media
        speed = dist / t
        
        switch speed {
        case 0..<10:
            iconImage = "TARTARUGA"
            backgroundColor = Color("VERDE01")
        case 10..<30:
            iconImage = "elefante"
            backgroundColor = Color("AZUL01")
        case 30..<70:
            iconImage = "avestruz"
            backgroundColor = Color("LARANJA01")
        case 70..<90:
            iconImage = "leao"
            backgroundColor = Color("AMARELO01")
        case 90...130:
            iconImage = "guepardo"
            backgroundColor = Color("VERMELHO01")
        default:
            iconImage = nil
            backgroundColor = .gray
        }
    }
}

struct LegendItem: View {
    
    let animal: String
    let range: String
    let color: Color
    
    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            
            Text(animal)
            Text(range)
        }
        .font(.subheadline)
    }
}

#Preview {
    ContentView()
}
