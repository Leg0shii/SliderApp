//
//  AboutView.swift
//  test16
//
//  Created by Benjamin Müller on 09.02.20.
//  Copyright © 2020 Benjamin Müller. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    struct HeadingStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content
          .foregroundColor(Color.black)
          .font(Font.custom("Ariel Rounded MT Bold", size: 30))
            .padding(.top, 20)
            .padding(.bottom, 20)
      }
    }

    struct TextStyle: ViewModifier {
      func body(content: Content) -> some View {
        return content
          .foregroundColor(Color.black)
          .font(Font.custom("Ariel Rounded MT Bold", size: 16))
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
      }
    }
    
    let background = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text("🎯 Bullseye 🎯")
                }
                .modifier(HeadingStyle())
                VStack {
                    Text("This is the Infopage for Bullseye and basically just a small Test")
                    Text("It is filled with things that doesnt matter that much so you dont have to read all of it.")
                    Text("Enjoy")
                }
                .modifier(TextStyle())
            }
        .navigationBarTitle("About Bullseye")
        .background(background)
        }
        .background(Image("269"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(
        .fixed(width: 896, height: 414))
    }
}
