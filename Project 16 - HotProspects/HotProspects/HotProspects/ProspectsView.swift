//
//  ProspectsView.swift
//  HotProspects
//
//  Created by RAJ RAVAL on 22/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

enum FilterOption {
    case name, mostRecent
}

struct ProspectsView: View {
    
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    @State private var showingFilterSheet = false
    @State private var filterOption: FilterOption = .name
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        let filteredData = filterOption == .name ? prospects.people.sorted { $0.name < $1.name} : prospects.people.sorted { $0.dateAdded > $1.dateAdded }
        
        switch filter {
        case .none:
            return filteredData
        case .contacted:
            return filteredData.filter { $0.isContacted }
        case .uncontacted:
            return filteredData.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        .contextMenu {
                            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                                self.prospects.toggle(prospect)
                            }
                            if !prospect.isContacted {
                                Button("Remind Me") {
                                    self.addNotification(for: prospect)
                                }
                            }
                        }
                        Spacer()
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted ? "phone.down" : "phone.fill")
                                .foregroundColor(prospect.isContacted ? .green : .red)
                            Text(prospect.isContacted ? "Contacted" : "Not Contacted")
                                .foregroundColor(prospect.isContacted ? .green : .red)
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(
                leading: Button(action: {
                    self.showingFilterSheet = true
            }) {
                    Text("Filter")
                },
                trailing: Button(action: {
                    self.isShowingScanner = true
                }){
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
            })
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Filter"), message: Text("Choose an option to filter"), buttons: [
                    .default(Text("Name Alphabetically (A-Z)")) { self.filterOption = .name },
                    .default(Text("Most Recent")) { self.filterOption = .mostRecent },
                    .cancel()
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning Failed")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            // For Testing Purpose
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) {
                    success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Notification Permission Error")
                    }
                }
            }
        }
        
    }
    
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
