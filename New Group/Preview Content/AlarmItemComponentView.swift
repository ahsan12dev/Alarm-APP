//
//  AlarmItemComponentView.swift
//  Alarm APP
//
//  Created by Ahsan Aqeel on 11/03/2025.
//

import SwiftUI
import SwiftData

struct AlarmItemComponentView: View {
    @Bindable var alarm: Alarm
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(alarm.time)
                    .font(.largeTitle)
                    .bold()
                Text(alarm.note + " " + alarm.repeatOption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Toggle("", isOn: $alarm.isEnabled)
                .onChange(of: alarm.isEnabled) { newValue in
                    try? alarm.modelContext?.save()
                }
        }
        .padding(5)
    }
}
#Preview {
    AlarmItemComponentView(alarm: .init(time: "10:00 AM", repeatOption: "Alarm", note: "Wake Up", sound: "Beacon", isEnabled: true))
}
