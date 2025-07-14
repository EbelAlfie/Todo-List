enum Priority: String {
    case High = "High"
    case Medium = "Medium"
    case Low = "Low"
}

extension Priority {
    static func getFromValue(_ value: String?) -> Priority {
        return switch(value) {
        case "Low": Priority.Low
        case "Medium": Priority.Medium
        default: Priority.High
        }
    }
}
