//
//  ContentView.swift
//  RandomSwiftUIImage
//
//  Created by Thor on 04/07/2021.
//

import SwiftUI


class ViewModel: ObservableObject{
    
    @Published var image: Image?
    
    func fetchImage(){
        guard let url = URL(string: "https://random.imagecdn.app/500/500")  else {return}
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {return}
                self.image = Image(uiImage: uiImage)
            }
            
        }
        task.resume()
    }
    
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                
                if let image = viewModel.image{
                    ZStack{
                        image
                            .resizable()
                            .foregroundColor(.purple)
                            .frame(width: 250, height: 250)
                            .cornerRadius(8)
                            .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width/1.2,
                           height: UIScreen.main.bounds.width/1.2)
                    .background(Color.black)
                    .cornerRadius(8.0)
                }else{
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.pink)
                        .frame(width: 200, height: 200)
                        .cornerRadius(8)
                        .padding()
                }
                
                Spacer()
                
                Button(action:{
                    viewModel.fetchImage()
                } ) {
                    Text("Load Random Image")
                        .bold()
                        .frame(width: 250, height: 55)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8.0)
                        .padding()
                }
            }
            
        }.navigationTitle("Random Photo")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
