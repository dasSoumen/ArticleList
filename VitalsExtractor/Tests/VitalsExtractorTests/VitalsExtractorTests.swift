import XCTest
@testable import VitalsExtractor

final class VitalsExtractorTests: XCTestCase {
    func testExtractionSample() throws {
        let text = "Patient Name: John Doe, DOB: 01/02/1980, Age: 45, Height: 5'9\", Weight: 70 kg. BP 120/70, Pulse: 80 bpm, Temp: 98.6 F, RR 16, SpO2 98%."
        let extractor = VitalsExtractor()
        let vitals = extractor.extract(from: text)
        XCTAssertEqual(vitals.name, "John Doe")
        XCTAssertEqual(vitals.dob, "01/02/1980")
        XCTAssertEqual(vitals.age, "45")
        XCTAssertEqual(vitals.height, "5'9\"")
        XCTAssertEqual(vitals.weight, "70 kg")
        XCTAssertEqual(vitals.blood_pressure, "120/70")
        XCTAssertEqual(vitals.pulse, "80")
        XCTAssertEqual(vitals.temperature, "98.6°F")
        XCTAssertEqual(vitals.respiration_rate, "16")
        XCTAssertEqual(vitals.spo2, "98%")
    }
}
