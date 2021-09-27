//
//  ChatListNavigationView.swift
//  GoChat
//
//  Created by 宫赫 on 2021/9/27.
//

import SwiftUI

struct ChatListNavigationView : UIViewControllerRepresentable{

    var view : ChatList
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        let childView = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: childView)
        
        controller.navigationBar.topItem?.title = "GoChat"
        controller.navigationBar.prefersLargeTitles = false
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
