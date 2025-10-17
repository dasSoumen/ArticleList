import Foundation
#if canImport(NaturalLanguage) && canImport(CoreML)
import NaturalLanguage
import CoreML
#endif

public final class VitalsMLExtractor {
    #if canImport(NaturalLanguage) && canImport(CoreML)
    private var tagger: NLTagger?
    private let scheme = NLTagScheme("Vitals")
    #endif

    public init?(modelBundle: Bundle = .main) {
        #if canImport(NaturalLanguage) && canImport(CoreML)
        guard let url = modelBundle.url(forResource: "VitalsNER", withExtension: "mlmodelc") ??
                modelBundle.url(forResource: "VitalsNER", withExtension: "mlmodel") else { return nil }
        do {
            let compiledURL: URL
            if url.pathExtension == "mlmodel" {
                compiledURL = try MLModel.compileModel(at: url)
            } else {
                compiledURL = url
            }
            let mlModel = try MLModel(contentsOf: compiledURL)
            let nlModel = try NLModel(mlModel: mlModel)
            let tagger = NLTagger(tagSchemes: [scheme])
            tagger.setModels([nlModel], forTagScheme: scheme)
            self.tagger = tagger
        } catch {
            return nil
        }
        #else
        return nil
        #endif
    }

    public func extract(from text: String) -> ExtractedVitals? {
        #if canImport(NaturalLanguage) && canImport(CoreML)
        guard let tagger = tagger else { return nil }
        tagger.string = text
        var chunks: [(label: String, text: String)] = []
        var currentLabel: String?
        var buffer: [String] = []
        let range = text.startIndex..<text.endIndex
        tagger.enumerateTags(in: range, unit: .word, scheme: scheme, options: [.omitWhitespace, .omitPunctuation]) { tag, tokenRange in
            let token = String(text[tokenRange])
            guard let raw = tag?.rawValue else { return true }
            let parts = raw.split(separator: "-", maxSplits: 1).map(String.init)
            let (prefix, label) = parts.count == 2 ? (parts[0], parts[1]) : ("B", parts[0])
            if prefix == "B" || label != currentLabel {
                if let cur = currentLabel, !buffer.isEmpty { chunks.append((cur, buffer.joined(separator: " "))) }
                currentLabel = label
                buffer = [token]
            } else {
                buffer.append(token)
            }
            return true
        }
        if let cur = currentLabel, !buffer.isEmpty { chunks.append((cur, buffer.joined(separator: " "))) }
        var out = ExtractedVitals()
        func set(_ keyPath: WritableKeyPath<ExtractedVitals, String?>, from label: String, transform: (String) -> String = { $0 }) {
            if let v = chunks.first(where: { $0.label == label })?.text { out[keyPath: keyPath] = transform(v) }
        }
        set(\ExtractedVitals.pulse, from: "PULSE")
        set(\ExtractedVitals.temperature, from: "TEMP")
        set(\ExtractedVitals.blood_pressure, from: "BP")
        set(\ExtractedVitals.name, from: "NAME")
        set(\ExtractedVitals.age, from: "AGE")
        set(\ExtractedVitals.dob, from: "DOB")
        set(\ExtractedVitals.height, from: "HEIGHT")
        set(\ExtractedVitals.weight, from: "WEIGHT")
        set(\ExtractedVitals.respiration_rate, from: "RR")
        set(\ExtractedVitals.spo2, from: "SPO2")
        return out
        #else
        return nil
        #endif
    }
}
