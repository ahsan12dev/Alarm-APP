import Foundation

class EditAlarmViewModel: ObservableObject {
    @Published var dateSelected: Date = Date()
    @Published var noteSelected: String = ""
    @Published var soundSelected: String = ""
    @Published var alarm: Alarm
    init(alarm: Alarm) {
        self.alarm = alarm
    }
    let PickerData = ["Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday", "Every Sunday", "Never"]
    let soundName = ["AudioServicesPlaySystemSound(1003)","AudioServicesPlaySystemSound(1004)","AudioServicesPlaySystemSound(1005)","AudioServicesPlaySystemSound(1006)","AudioServicesPlaySystemSound(1007)","AudioServicesPlaySystemSound(1519)"]
    
    func deleteAlarm(folder: Alarm) {
        if let context = folder.modelContext {
            context.delete(folder)
        }
    }
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    func parseTime(_ time: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.date(from: time) ?? Date()
    }
    func populateAlarmData() {
        dateSelected = parseTime(alarm.time)
    }
}
