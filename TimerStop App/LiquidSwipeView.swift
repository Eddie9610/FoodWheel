
//  LiquidSwipeView.swift
//  TimerStop App
//
//  Created by Pokming Sheung on 2020-07-21.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI
var pageIndex = 0
//var page : pages = .homepage
struct LiquidSwipeView: View {
    
    @State var leftData = SliderData(side: .left)
    @State var rightData = SliderData(side: .right)

    @State var topSlider = SliderSide.right
    @State var sliderOffset: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            TimerView()
            slider(data: $leftData)
            slider(data: $rightData)
        }
        .edgesIgnoringSafeArea(.all)
    }

    func slider(data: Binding<SliderData>) -> some View {
        let value = data.wrappedValue
        return ZStack {
            
            wave(data: data)
            button(data: value)
        }
        .zIndex(topSlider == value.side ? 1 : 0)
        .offset(x: value.side == .left ? -sliderOffset : sliderOffset)
    }

//    func content() -> some View {
//        return TimerView()
//
//        //HStack {
//                //Text("Hello, World!")
//            //Rectangle().foregroundColor(Config.colors[pageIndex])
//        //}
//    }

    func button(data: SliderData) -> some View {
        let aw = (data.side == .left ? 1 : -1) * Config.arrowWidth / 2
        let ah = Config.arrowHeight / 2
        return ZStack {
            circle(radius: Config.buttonRadius).stroke().opacity(0.2)
            polyline(-aw, -ah, aw, 0, -aw, ah).stroke(Color.white, lineWidth: 2)
        }
        .offset(data.buttonOffset)
        .opacity(data.buttonOpacity)
    }

    func wave(data: Binding<SliderData>) -> some View {
        let gesture = DragGesture().onChanged {
            self.topSlider = data.wrappedValue.side
            data.wrappedValue = data.wrappedValue.drag(value: $0)
        }
        .onEnded {
            if data.wrappedValue.isCancelled(value: $0) {
                withAnimation(.spring(dampingFraction: 0.5)) {
                    data.wrappedValue = data.wrappedValue.initial()
                }
            } else {
                self.swipe(data: data)
            }
        }
        .simultaneously(with: TapGesture().onEnded {
            self.topSlider = data.wrappedValue.side
            self.swipe(data: data)
        })
        return WaveView(data: data.wrappedValue).gesture(gesture)
            .foregroundColor(Config.colors[index(of: data.wrappedValue)])
    }

    private func swipe(data: Binding<SliderData>) {
        withAnimation() {
            data.wrappedValue = data.wrappedValue.final()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            pageIndex = self.index(of: data.wrappedValue)
            self.leftData = self.leftData.initial()
            self.rightData = self.rightData.initial()

            self.sliderOffset = 100
            withAnimation(.spring(dampingFraction: 0.5)) {
                self.sliderOffset = 0
            }
        }
    }

    private func index(of data: SliderData) -> Int {
        let last = Config.colors.count - 1
        if data.side == .left {
            return pageIndex == 0 ? last : pageIndex - 1
        } else {
            return pageIndex == last ? 0 : pageIndex + 1
        }
    }

    private func circle(radius: Double) -> Path {
        return Path { path in
            path.addEllipse(in: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2))
        }
    }

    private func polyline(_ values: Double...) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: values[0], y: values[1]))
            for i in stride(from: 2, to: values.count, by: 2) {
                path.addLine(to: CGPoint(x: values[i], y: values[i + 1]))
            }
        }
    }

}

struct LiquidSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        LiquidSwipeView()
    }
}

