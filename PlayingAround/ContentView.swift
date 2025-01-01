//
//  ContentView.swift
//  PlayingAround
//
//  Created by Antony Holshouser on 12/31/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let middleX = UIScreen.main.bounds.size.width/2
    let middleY = UIScreen.main.bounds.size.height/2
    
    @State var spawning = true
    
    @State var state = -1
    
    @State var emojis: [Emoji] = []
    
    @State var spawnpointLocation: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
            
            Circle()
                .frame(width: 0)
            
            ForEach(emojis) { emoji in
                    
                Text(emoji.emoji)
                    .font(Font.system(size: 120))
                    .offset(x: emoji.x, y: emoji.y)
                    
            }
            
            Circle()
                .fill(.black.opacity(0.2))
                .strokeBorder(style: StrokeStyle(lineWidth: 10))
                .opacity(0.5)
                .frame(width: middleX/2)
                .position(spawnpointLocation)
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.spawnpointLocation = $0.location
                        }
                        
                            
                        
                    
                )
            
            
        }
        .onAppear() {
            Task {
                while true {
                        do {
                            try await Task.sleep(for: .milliseconds(100))
                            
                            if spawning {
                                let originXDifference =
                                spawnpointLocation.x-middleX
                                let originYDifference =
                                spawnpointLocation.y-middleY
                                
                                let originXAddition = (originXDifference / middleX) * 8
                                print(originXAddition)
                                
                                let originYAddition = (originYDifference / middleY) * 8
                                print(originYAddition)
                                
                                let tempXVelocity = Double.random(in: -(5.0+originXAddition)...(5.0-originXAddition))*10
                                let tempYVelocity = Double.random(in: -(5.0+originYAddition)...(5.0-originYAddition))*10
                                
                                emojis.append(Emoji(
                                    emoji: getRandomEmoji(),
                                    x: Double(spawnpointLocation.x-middleX),
                                    y: Double(spawnpointLocation.y-middleY+40),
                                    xVelocity: tempXVelocity,
                                    yVelocity: tempYVelocity))
                            }
                                
                            for emoji in emojis {
                                emoji.x = emoji.x
                                emoji.y = emoji.y
                                withAnimation(.linear(duration: 1.0)) {
                                    emoji.x += emoji.xVelocity
                                    emoji.y += emoji.yVelocity
                                }
                            }
                        } catch {
                            print(error)
                        }
                    
                }
            }
        }
        .onTapGesture {
            Task {
                spawning = false
                for emoji in emojis {
                    emoji.xVelocity = 0
                    emoji.yVelocity = 0
                    withAnimation(.easeIn(duration: Double.random(in: 0.2...1.0))) {
                        emoji.x = spawnpointLocation.x-middleX
                        emoji.y = spawnpointLocation.y-middleY+40
                        //print("Hello")
                    }
                }
                do {
                    try await Task.sleep(for: .milliseconds(1000))
                    emojis = []
                    spawning = true
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func getRandomEmoji() -> String {
        var emojiChoice = Int.random(in: 0...2)
        switch emojiChoice {
        case 0:
            return "😂"
        case 1:
            return "😭"
        case 2:
            return "🥳"
        default:
            return "❤️"
        }
    }

}

#Preview {
    ContentView()
}
