import Foundation
import SwiftUI

let HOST:String = "http://127.0.0.1:8090"
let WEBSOCKET_HOST:String = "ws:/127.0.0.1:8090/chat/connect/"

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

var ACCESS_TOKEN:String = ""

var USER_INFO:Dictionary<String, Any> = [:]

class MessageList: ObservableObject{
    
    static let sharedInstance = MessageList()
    @Published var list = [1,2]
    
}
