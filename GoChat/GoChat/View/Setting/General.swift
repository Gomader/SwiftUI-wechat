//
//  General.swift
//  GoChat
//
//  Created by 宫赫 on 2021/10/1.
//

import SwiftUI

struct General: View {
    var body: some View {
        VStack{
            
            GeneralTopbar()
            
        }.frame(maxHeight: .infinity,alignment: .top)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x000000, darkAlpha: 1)))
            .edgesIgnoringSafeArea(.all)
    }
}

struct General_Previews: PreviewProvider {
    static var previews: some View {
        General()
    }
}

struct GeneralTopbar: View{
    var body: some View{
        ZStack{
            
            Text("通用").font(.system(size: 17)).fontWeight(.semibold)
                .padding()
            
            
        }.frame(width: screen_width)
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)!)
            .background(Color.init(UIColor(normal: 0xededed, normalAlpha: 1, dark: 0x181818, darkAlpha: 1)))
    }
}
