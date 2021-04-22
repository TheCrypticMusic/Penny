//
//  ContentView.swift
//  TestingViews
//
//  Created by Daniel Gibson on 07/04/2021.
//

import SwiftUI




extension Color {
    static let cardBackground = Color("cardBackground")
    
    static let headlineText = Color("Headline")
    
    static let paragraphText = Color("Paragraph")
    
    static let buttonColour = Color("Button")
    
    static let greenIncome = Color("GREEN")
    
    static let cardForeground = Color("cards")
}

// <a href="https://www.freepik.com/vectors/people">People vector created by stories - www.freepik.com</a>
// <a href='https://www.freepik.com/vectors/people'>People vector created by stories - www.freepik.com</a>

struct HomePageView: View {
        
    @State private var isPresented = false
    
    
    var body: some View {

            ZStack {
                Color.cardBackground.ignoresSafeArea()
                VStack {
                    
                    Text("PENNY")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.headlineText)
                        .kerning(5)
                        .padding(.top)
                    Text("Welcome to your personal budget tracker")
                        .padding(.top, 20.5)
                        .foregroundColor(.paragraphText)
                  Spacer()
                    GeometryReader { geo in
                        
                        Image("mainimage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height: geo.size.height)
                      
                    }
                    
                    VStack {

                        Button("Start Your Budget") {
                            isPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        BudgetView()
                    }
                        .frame(width: 350, height: 50, alignment: .center)

                        .background(Color.buttonColour)
                        .foregroundColor(.cardBackground)
                        .cornerRadius(50)
                        .padding(.bottom, 51.0)
                    }
                }
            }
        }
    }

    


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        
        HomePageView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
