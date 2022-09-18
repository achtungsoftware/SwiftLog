import XCTest
@testable import SwiftLog

final class SwiftLogTests: XCTestCase {
    
    let path = "/Users/juliangerhards/Desktop/"
    
    func test_logger() throws {
        try test_log(type: .info)
        try test_log(type: .error)
        try test_log(type: .warning)
    }
    
    func test_log(type: SwiftLog.LogType) throws {
        let log_contents = "Hallo, Logger!"
        SwiftLog.log(message: log_contents, location: .custom(path: path), logType: type)
        let file_contents = try String(contentsOfFile: "\(path)\(SwiftLog.typeFilename(logType: type))")
        XCTAssertEqual(SwiftLog.lineBuilder(log_contents) + "\n", file_contents)
    }
}
