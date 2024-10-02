//
//  ContentView.swift
//  SliderApp
//
//  Created by BM on 04.02.20.
//

import SwiftUI

struct ContentView: View {
    
  @State var alertIsVisible = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 1...100)
  @State var score = 0
  @State var round = 1
  let black = Color(red: 0.0, green: 0.0, blue: 0.0)
  
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .modifier(Shadow())
        .font(Font.custom("Ariel Rounded MT Bold", size: 23))
    }
  }
  
  struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.yellow)
        .modifier(Shadow())
        .font(Font.custom("Ariel Rounded MT Bold", size: 27))
    }
  }
  
  struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Ariel Rounded MT Bold", size: 18))
    }
  }
  
  struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Ariel Rounded MT Bold", size: 23))
    }
  }
  
  struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
  }
    
  var body: some View {
    VStack {
      Spacer()
      
      //Target row
      HStack {
        Text("Put the slider as close as you can to:").modifier(LabelStyle())
        Text("\(target)").modifier(ValueStyle())
      }
      Spacer()
      
      //Slider row
      HStack {
        Text("1").modifier(LabelStyle())
        Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
        Text("100").modifier(LabelStyle())
      }
      Spacer()
      
      //Button row
      HStack {
        Button(action: {
          self.alertIsVisible = true
        }) {
          Text("Hit me").modifier(ButtonLargeTextStyle())
        }
        .alert(isPresented: $alertIsVisible) { () ->
          Alert in
          return Alert(title: Text("\(setTitle())"),
            message: Text(
            "The Slidervalue is \(sliderValueRounded()).\n" +
              "You Scored \(pointsForCurrentRound()) points this round."
            ), dismissButton: .default(Text("Awesome!")) {
              self.score = self.score + self.pointsForCurrentRound()
              self.round = self.round + 1
              self.target = Int.random(in: 1...100)
          })
        }
        .background(Image("button")).modifier(Shadow())
      }
      Spacer()
      
      //Bottom row
      HStack {
        Button(action: {
          self.reset()
        }) {
          HStack {
            Image("restart")
            Text("Reset").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("button")).modifier(Shadow())
        
        Spacer()
        Text("Score: ").modifier(LabelStyle())
        Text("\(score)").modifier(ValueStyle())
        Spacer()
        
        Text("Round: ").modifier(LabelStyle())
        Text("\(round)").modifier(ValueStyle())
        Spacer()
        
        NavigationLink(destination: AboutView()) {
          HStack {
            Image("info")
            Text("Info").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("button")).modifier(Shadow())
  
      }
      .padding(.bottom, 20)
    }
    .background(Image("269"), alignment: .center)
    .accentColor(black)
    .navigationBarTitle("Bullseye")
  }
  
  func sliderValueRounded() -> Int {
    return Int(sliderValue.rounded())
  }
  
  func amountOff() -> Int {
    return abs(sliderValueRounded() - target)
  }
  
  func pointsForCurrentRound() -> Int {
    let maximum = 100
    let difference = amountOff()
    var bonus = 0
    
    if difference == 0 {
      bonus = 100
    } else if difference == 1 {
      bonus = 50
    } else {
      bonus = 0
    }
    return (maximum - amountOff()) + bonus
  }
  
  func reset() {
    score = 0
    round = 1
    sliderValue = 50.0
    target = Int.random(in: 1...100)
  }
  
  func setTitle() -> String {
    var title = ""
    if amountOff() == 0 {
      title = "Perfect!"
    } else if amountOff() < 5 {
      title = "Almost!"
    } else if ((amountOff() < 10) && (amountOff() > 4)) {
      title = "That wasnt too bad!"
    } else {
      title = "Are you even trying?"
    }
    return title
  }
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView().previewLayout(
        .fixed(width: 896, height: 414))
    }
}
