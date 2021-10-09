import Foundation
import SwiftUI
import Starscream

let HOST:String = "http://127.0.0.1:8090"
let WEBSOCKET_HOST:String = "ws://127.0.0.1:8090/chat/link/"

var SOCKET:WebSocket? = nil

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

var ACCESS_TOKEN:String = ""

var USER_INFO:Dictionary<String, Any> = [:]

var FRIENDLIST:Dictionary<String, Any> = [:]

class MessageList: ObservableObject{
    
    static let sharedInstance = MessageList()
    @Published var list = []
    
}
