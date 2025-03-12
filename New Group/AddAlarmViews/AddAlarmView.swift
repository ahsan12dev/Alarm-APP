import SwiftUI
import AVFoundation
import SwiftData

struct AddAlarmView: View {
    @StateObject private var viewModel = AddAlarmViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext

    var alarmData: ((_ alarmData: Alarm) -> Void)
    var body: some View {
        
        NavigationStack {
            VStack {
                topNavbar()
                
                Form {
                    addTime()
                    
                    addRepeatOption()
                    
                    addTextLabel()
                    
                    addSoundOption()
                    
                    addSnoozeToggle()
                }
            }
        }
    }
    
    fileprivate func topNavbar() -> some View {
        return HStack {
            Button("Cancel", action: {
                presentationMode.wrappedValue.dismiss()
            }).padding()
                .foregroundColor(.orange)
            Spacer()
            Text("Add Alarm")
                .font(.title2)
                .bold()
            Spacer()
            Button("Save", action: {
                alarmData(viewModel.collectAlarmData())
                presentationMode.wrappedValue.dismiss()
                modelContext.insert(viewModel.collectAlarmData())
                print("""
                      Alarm added Successfully :
                      \(viewModel.formatTime(viewModel.dateSelected))
                      \(viewModel.RepeatPickerSelected)
                      \(viewModel.noteSelected)
                      \(viewModel.soundDataSelected)
                      \(viewModel.snoozeSelected)
                      
                      """)
            })
            .padding()
            .foregroundColor(.orange)
        }
    }
    
    fileprivate func addTime() -> some View {
        return DatePicker("", selection: $viewModel.dateSelected, displayedComponents: .hourAndMinute)
            .datePickerStyle(WheelDatePickerStyle())
    }
    
    fileprivate func addRepeatOption() -> some View {
        return Picker("Repeat", selection: $viewModel.RepeatPickerSelected) {
            ForEach(viewModel.repeatData, id: \.self) { option in
                Text(option)
            }
        }
        .pickerStyle(.navigationLink)
    }
    
    fileprivate func addSoundOption() -> some View {
        return Picker("Sound", selection: $viewModel.soundDataSelected) {
            ForEach(viewModel.soundName, id: \.self) { option in
                Text(option)
            }
        }
        .pickerStyle(.navigationLink)
    }
    
    fileprivate func addTextLabel() -> some View {
        return HStack {
            Text("Label")
            Spacer()
            TextField("Alarm", text: $viewModel.noteSelected)
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
                .padding(.leading,120)
                .disableAutocorrection(true)
        }
    }
    
    fileprivate func addSnoozeToggle() -> Toggle<Text> {
        return Toggle(isOn: $viewModel.isEnabledToggle) {
            Text("Snooze")
        }
    }
}

#Preview {
    AddAlarmView { alarmData in
        
    }
}
