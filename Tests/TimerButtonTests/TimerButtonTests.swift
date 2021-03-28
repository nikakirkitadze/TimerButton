import XCTest
@testable import TimerButton

final class TimerButtonTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let timerButton: TimerButton? = TimerButton(frame: .zero)
        
        XCTAssertEqual(timerButton, nil)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
