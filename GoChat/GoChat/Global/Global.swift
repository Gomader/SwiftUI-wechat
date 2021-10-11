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

class FriendList: ObservableObject{
    
    static let sharedInstance = FriendList()
    @Published var list = [:] //字典形式
    
}

class FriendRequestList: ObservableObject{
    
    static let sharedInstance = FriendRequestList()
    //applicant和state字段，state：0未查看，1已查看，2过期
    @Published var list = [Dictionary<String,Any>]() //列表形式（顺序有关
    @Published var unRead = 0
    
}

class MessageList: ObservableObject{
    
    static let sharedInstance = MessageList()
    @Published var list = [] //列表形式（顺序有关）
    
}
