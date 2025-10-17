import SwiftUI
import VitalsExtractor

struct ContentView: View {
    @State private var input: String = ""
    @State private var output: String = "{}"
    private let extractor = VitalsExtractor()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextEditor(text: $input)
                    .font(.system(.body, design: .monospaced))
                    .frame(minHeight: 200)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    .padding(.horizontal)

                HStack(spacing: 12) {
                    Button("Extract") {
                        let vitals = extractor.extract(from: input)
                        output = vitals.toJSON()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Sample") {
                        input = "Patient Name: John Doe, DOB: 01/02/1980, Age: 45, Height: 5'9\", Weight: 70 kg. BP 120/70, Pulse: 80 bpm, Temp: 98.6 F, RR 16, SpO2 98%."
                    }
                    .buttonStyle(.bordered)

                    Button("Clear") {
                        input = ""
                        output = "{}"
                    }
                    .buttonStyle(.bordered)
                }

                ScrollView {
                    Text(output)
                        .font(.system(.body, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Vitals Extractor")
        }
    }
}
