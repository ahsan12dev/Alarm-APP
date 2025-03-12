//
//  AlarmView.swift
//  Alarm APP
//
//  Created by Ahsan Aqeel on 11/03/2025.
//

import SwiftUI
import SwiftData
import UserNotifications

struct AlarmListView: View {
    @StateObject private var viewModel = AlarmListViewModel()
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Alarm.time, order: .forward) var alarms: [Alarm]
    
    var body: some View {
        TabView {
            Tab("World Clock", systemImage: "network") {
                Text("World Clock")
            }
            Tab("Alarm", systemImage: "alarm.fill") {
                VStack {
                    headerButtons()
                    topHeading()
                    alarmListView()
                }
            }
            Tab("StopWatch", systemImage: "stopwatch.fill") {
                Text("Stop Watch")
            }
            Tab("Timers", systemImage: "timer") {
                Text("Timers")
            }
        }
        .tabViewStyle(.tabBarOnly)
        .onAppear {
            viewModel.requestNotificationPermission()
            filterAlarm()
        }
    }
    fileprivate func headerButtons() -> some View {
        HStack {
            Button("Edit") {
                print("Edit clicked")
            }
            Spacer()
            Button("Add") {
                viewModel.addAlarmSheet.toggle()
            }
            .sheet(isPresented: $viewModel.addAlarmSheet) {
                AddAlarmView { alarmData in }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
    
    fileprivate func topHeading() -> some View {
        VStack(alignment: .leading) {
            HStack{
                Text("Alarms")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10)
            }
            
            HStack{
                Text("Search").padding(.leading)
                TextField("Search by time", text: $viewModel.searchbyAlarmTime)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading)
                    .onChange(of: viewModel.searchbyAlarmTime, perform: { _ in filterAlarm() })
                Button(action: {
                    filterAlarm()
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 24))
                        .padding()
                }
            }
        }.background(Color.gray.opacity(0.4))
            .foregroundStyle(Color.blue)
    }
    
    fileprivate func alarmListView() -> some View {
        NavigationView {
            List {
                Section(header: Text("Other")) {
                    ForEach(viewModel.filteredAlarms, id: \.self) { alarm in
                        AlarmItemComponentView(alarm: alarm)
                            .background(Color.white)
                            .onTapGesture {
                                viewModel.selectedAlarmObj = alarm
                            }
                            .onAppear {
                                viewModel.checkAndTriggerNotification(for: alarm)
                            }
                    }
                }
                .padding(.vertical, -5)
            }
            .padding(.top, -30)
            .listStyle(PlainListStyle())
            .sheet(item: $viewModel.selectedAlarmObj) { alarmObj in
                EditAlarmView(alarm: alarmObj)
            }
            .refreshable {
                print("Alarms Refresh Successful")
                filterAlarm()
            }.padding(.top)
        }
    }
    
    func filterAlarm(){
        if viewModel.searchbyAlarmTime.isEmpty{
            viewModel.filteredAlarms = alarms
        } else {
            viewModel.filteredAlarms = alarms.filter { Alarm in
                Alarm.time.lowercased().contains(viewModel.searchbyAlarmTime.lowercased())
            }
        }
    }

    }

#Preview {
    AlarmListView()
}
