import XCTest
@testable import SwiftLog

final class SwiftLogTests: XCTestCase {
    func test_logger() {
        SwiftLog.log(message: "Hallo, Info!", location: .custom(path: "/Users/juliangerhards/Desktop"))
        SwiftLog.log(message: "Hallo, Warnung!", location: .custom(path: "/Users/juliangerhards/Desktop"), logType: .warning)
        SwiftLog.log(message: "Hallo, Error!", location: .custom(path: "/Users/juliangerhards/Desktop"), logType: .error)
    }
}
