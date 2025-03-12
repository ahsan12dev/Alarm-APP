import Foundation
final class AddAlarmViewModel: ObservableObject {
    @Published  var alarm: Bool = false
    @Published  var labelPickerSelected: String = ""
    @Published  var RepeatPickerSelected: String = ""
    @Published  var timeSelected: String = ""
    @Published  var snoozeSelected: Bool = false
    @Published  var soundDataSelected: String = ""
    @Published  var noteSelected: String = ""
    @Published  var isEnabledToggle: Bool = true
    @Published  var dateSelected: Date = Date()
    @Published var repeatData = ["Every Monday","Every Tuesday","Every Wednesday","Every Thursday","Every Friday","Every Saturday","Every Sunday","Never"]
    @Published var soundName = ["AudioServicesPlaySystemSound(1003)","AudioServicesPlaySystemSound(1004)","AudioServicesPlaySystemSound(1005)","AudioServicesPlaySystemSound(1006)","AudioServicesPlaySystemSound(1007)","AudioServicesPlaySystemSound(1519)"]
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    func collectAlarmData() -> Alarm {
        return Alarm(
            time: formatTime(dateSelected),
            repeatOption: RepeatPickerSelected,
            note: noteSelected,
            sound: soundDataSelected ,
            isEnabled: isEnabledToggle
        )
    }
}
