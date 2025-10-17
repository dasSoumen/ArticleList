import Foundation

public struct ExtractedVitals: Codable, Equatable {
    public var name: String?
    public var age: String?
    public var height: String?
    public var weight: String?
    public var temperature: String?
    public var pulse: String?
    public var blood_pressure: String?
    public var respiration_rate: String?
    public var spo2: String?
    public var dob: String?

    public init(
        name: String? = nil,
        age: String? = nil,
        height: String? = nil,
        weight: String? = nil,
        temperature: String? = nil,
        pulse: String? = nil,
        blood_pressure: String? = nil,
        respiration_rate: String? = nil,
        spo2: String? = nil,
        dob: String? = nil
    ) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.temperature = temperature
        self.pulse = pulse
        self.blood_pressure = blood_pressure
        self.respiration_rate = respiration_rate
        self.spo2 = spo2
        self.dob = dob
    }

    public func toJSON(pretty: Bool = true) -> String {
        let encoder = JSONEncoder()
        if pretty { encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes, .sortedKeys] }
        guard let data = try? encoder.encode(self) else { return "{}" }
        return String(data: data, encoding: .utf8) ?? "{}"
    }
}

public final class VitalsExtractor {
    private let patterns: [String: NSRegularExpression] = {
        func re(_ p: String) -> NSRegularExpression { try! NSRegularExpression(pattern: p) }
        return [
            "blood_pressure": re("(?i)\\b(?:bp|blood\\s*pressure)\\b\\s*[:=]?\\s*(\\d{2,3}\\s*/\\s*\\d{2,3})"),
            "pulse": re("(?i)\\b(?:pulse|hr|heart\\s*rate)\\b\\s*[:=]?\\s*(\\d{2,3})(?:\\s*(?:bpm|/min|per\\s*min))?"),
            "temperature": re("(?i)\\b(?:temp|temperature|t)\\b\\s*[:=]?\\s*([+-]?(?:\\d{2}(?:\\.\\d+)?))\\s*°?\\s*([CF])?"),
            "respiration_rate": re("(?i)\\b(?:rr|resp(?:iratory)?\\s*rate?)\\b\\s*[:=]?\\s*(\\d{1,2})(?:\\s*(?:/min|rpm))?"),
            "spo2": re("(?i)\\b(?:spo2|o2\\s*saturation|sat(?:uration)?)\\b\\s*[:=]?\\s*(\\d{2,3})\\s*%"),
            "height_feet": re("(?i)\\b(?:height|ht)\\b\\s*[:=]?\\s*(\\d)\\s*(?:'|ft|feet)\\s*(\\d{1,2})?\\s*(?:\"|in|inch(?:es)?)?"),
            "height_metric": re("(?i)\\b(?:height|ht)\\b\\s*[:=]?\\s*(\\d{2,3}(?:\\.\\d+)?)\\s*(?:cm|centimeters?|m)\\b"),
            "weight": re("(?i)\\b(?:weight|wt)\\b\\s*[:=]?\\s*(\\d{2,3}(?:\\.\\d+)?)\\s*(?:kg|kilograms?|lb|lbs|pounds?)\\b"),
            "age": re("(?i)\\b(?:age)\\b\\s*[:=]?\\s*(\\d{1,3})\\b"),
            "dob_mdy": re("(?i)\\b(?:dob|date\\s*of\\s*birth)\\b\\s*[:=]?\\s*([0-3]?\\d[/-][0-3]?\\d[/-](?:\\d{2}|\\d{4}))"),
            "dob_text": re("(?i)\\b(?:dob|date\\s*of\\s*birth)\\b\\s*[:=]?\\s*([A-Za-z]{3,9}\\s+\\d{1,2},?\\s+\\d{4})"),
            "name": re("(?i)\\b(?:patient\\s*name|name)\\b\\s*[:=]?\\s*([A-Z][a-z]+(?:\\s+[A-Z][a-z]+)+)")
        ]
    }()

    public init() {}

    public func extract(from text: String) -> ExtractedVitals {
        var result = ExtractedVitals()
        result.blood_pressure = match("blood_pressure", in: text) ?? matchRaw("(?i)\\b(?:bp|blood\\s*pressure)\\b\\s*[:=]?\\s*(\\d{2,3})\\s*(?:over|/)\\s*(\\d{2,3})", in: text) { comps in "\(comps[0])/\(comps[1])" }
        result.pulse = match("pulse", in: text)
        result.temperature = matchTemp(in: text)
        result.respiration_rate = match("respiration_rate", in: text)
        if let s = match("spo2", in: text) { result.spo2 = "\(s)%" }
        result.height = match("height_feet", in: text) ?? match("height_metric", in: text)
        result.weight = match("weight", in: text)
        result.age = match("age", in: text)
        result.dob = match("dob_mdy", in: text) ?? match("dob_text", in: text)
        result.name = match("name", in: text)
        return result
    }

    private func match(_ key: String, in text: String) -> String? {
        guard let re = patterns[key] else { return nil }
        let ns = text as NSString
        let fullRange = NSRange(location: 0, length: ns.length)
        if let m = re.firstMatch(in: text, options: [], range: fullRange) {
            var value = ns.substring(with: m.range(at: 1)).trimmingCharacters(in: .whitespaces)
            if m.numberOfRanges >= 3, key == "height_feet" {
                let hasInches = m.range(at: 2).location != NSNotFound
                let inches = hasInches ? ns.substring(with: m.range(at: 2)) : "0"
                value = "\(value)'\(inches)\""
            }
            return value
        }
        return nil
    }

    private func matchRaw(_ pattern: String, in text: String, combine: ([String]) -> String) -> String? {
        guard let re = try? NSRegularExpression(pattern: pattern) else { return nil }
        let ns = text as NSString
        let fullRange = NSRange(location: 0, length: ns.length)
        if let m = re.firstMatch(in: text, options: [], range: fullRange), m.numberOfRanges >= 3 {
            let a = ns.substring(with: m.range(at: 1))
            let b = ns.substring(with: m.range(at: 2))
            return combine([a, b])
        }
        return nil
    }

    private func matchTemp(in text: String) -> String? {
        guard let re = patterns["temperature"] else { return nil }
        let ns = text as NSString
        let fullRange = NSRange(location: 0, length: ns.length)
        if let m = re.firstMatch(in: text, options: [], range: fullRange) {
            let val = ns.substring(with: m.range(at: 1))
            var unit = "F"
            if m.numberOfRanges >= 3, m.range(at: 2).location != NSNotFound {
                unit = ns.substring(with: m.range(at: 2)).uppercased()
            }
            return "\(val)°\(unit)"
        }
        return nil
    }
}
