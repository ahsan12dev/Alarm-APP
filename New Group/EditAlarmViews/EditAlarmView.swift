import SwiftUI
import SwiftData

struct EditAlarmView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel = EditAlarmViewModel(alarm: Alarm(time: "",repeatOption: "",note: "",sound: "" ,isEnabled: true))
    init(alarm: Alarm) {
        _viewModel = StateObject(wrappedValue: EditAlarmViewModel(alarm: alarm))
    }
    var body: some View {
        NavigationStack {
            topNavbar()
            
            Form {
                editTime()
                
                editRepeatOption()
                
                editTextLabel()
                
                editSoundOption()
                
                editSnoozeToggle()
                
                Button("Delete", action: {
                    viewModel.deleteAlarm(folder: viewModel.alarm)
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
        .onAppear {
            viewModel.populateAlarmData()
        }
    }
    
    fileprivate func topNavbar() -> some View {
        return HStack {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.orange)
            Spacer()
            Text("Edit Alarm")
                .font(.title2)
                .bold()
            Spacer()
            Button("Save") {
                viewModel.alarm.time = viewModel.formatTime(viewModel.dateSelected)
                try? modelContext.save()
                presentationMode.wrappedValue.dismiss()
                print("""
                        Alarm After Update: 
                        \(viewModel.alarm.time) 
                        \(viewModel.alarm.repeatOption) 
                        \(viewModel.alarm.note) 
                        \(viewModel.alarm.sound) 
                        \(viewModel.alarm.isEnabled)
                        """)
            }
            .foregroundColor(.orange)
        }
        .padding()
    }
    
    fileprivate func editTime() -> some View {
        return DatePicker("", selection: $viewModel.dateSelected, displayedComponents: .hourAndMinute)
            .datePickerStyle(WheelDatePickerStyle())
    }
    
    fileprivate func editRepeatOption() -> some View {
        return Picker("Repeat", selection: $viewModel.alarm.repeatOption) {
            ForEach(viewModel.PickerData, id: \.self) { option in
                Text(option).tag(option)
            }
        }
        .pickerStyle(.navigationLink)
    }
    
    fileprivate func editTextLabel() -> some View {
        return HStack {
            Text("Label")
            Spacer()
            TextField("Alarm", text: $viewModel.alarm.note)
                .textFieldStyle(.plain)
                .disableAutocorrection(true)
                .padding(.leading,120)
        }
    }
    
    fileprivate func editSoundOption() -> some View {
        return Picker("Sound", selection: $viewModel.alarm.sound) {
            ForEach(viewModel.soundName, id: \.self) { option in
                Text(option).tag(option)
            }
        }
        .pickerStyle(.navigationLink)
    }
    
    fileprivate func editSnoozeToggle() -> Toggle<Text> {
        return Toggle(isOn: $viewModel.alarm.isEnabled) {
            Text("Snooze")
        }
    }
}
#Preview {
    EditAlarmView(alarm: Alarm(time: "", repeatOption: "", note: "", sound: "", isEnabled: true))
}
