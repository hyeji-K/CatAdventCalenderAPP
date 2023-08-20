//
//  LocalNotification.swift
//  CatAdventCalender
//
//  Created by heyji on 2022/11/27.
//

import UIKit
import UserNotifications

class LocalNotification {
    static let shared = LocalNotification()
    
    func sendNotification() {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "Advent Calender 2022"
        notiContent.body = "오늘의 선물을 열어보러 오세요!"
        notiContent.sound = UNNotificationSound.defaultCritical
        notiContent.badge = 1
        
        // 오후 12시 25분에 매일 반복 알림
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 12
        dateComponents.minute = 25
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "TodayGift", content: notiContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotification() {
        let date = Date().formatted(.dateTime.year().month(.defaultDigits).day())
        let dateArray = date.components(separatedBy: "/")
        // 날짜가 2022년 12월 25일 이후면 알림 삭제
        if dateArray[2] == "2022" && dateArray[1] == "25" {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TodayGift"])
        }
    }
}
