import Foundation

class TimeCalculator {
    func timeLeft(from date: Date) -> String {
        let currentTime = Date()
        let timeLeft = date.timeIntervalSince(currentTime)

        if timeLeft < 0 {
            return NSLocalizedString("EventStarted", comment: "Event has started")
        } else {
            let components = Calendar.current.dateComponents([.day, .hour, .minute], from: currentTime, to: date)
            let days = components.day ?? 0
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0

            if days > 0 {
                let daysString = String.localizedStringWithFormat(NSLocalizedString("DaysLeft", comment: "%d day%@ left"), days, days == 1 ? "" : NSLocalizedString("plural", comment: "s"))
                return daysString
            } else {
                if hours > 0 {
                    let hoursMinutesString = String.localizedStringWithFormat(NSLocalizedString("HoursMinutesLeft", comment: "%d hr %d min left"), hours, minutes)
                    return hoursMinutesString
                } else {
                    let minutesString = String.localizedStringWithFormat(NSLocalizedString("MinutesLeft", comment: "%d min left"), minutes)
                    return minutesString
                }
            }
        }
    }
}
