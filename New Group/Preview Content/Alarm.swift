import Foundation
import SwiftData

@Model
class Alarm : Identifiable{
    let id = UUID()
    var time: String
    var repeatOption: String
    var note: String
    var sound: String
    var isEnabled: Bool
    
    init(time: String, repeatOption: String, note: String, sound: String, isEnabled: Bool) {
        self.time = time
        self.repeatOption = repeatOption
        self.note = note
        self.sound = sound
        self.isEnabled = isEnabled
    }
}
