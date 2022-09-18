import Foundation

public class SwiftLog {
    
    
    /// Adds a log to the given ``Location`` and ``LogType``
    /// - Parameters:
    ///   - message: The log message as `String`
    ///   - location: The ``Location`` where the log file should be saved
    ///   - logType: The ``LogType``
    public static func log(message: String, location: Location = .currentDirectory, logType: LogType = .info) {
        do {
            try lineBuilder(message).appendLine(to: location.url(filename: typeFilename(logType: logType)))
        } catch {
            print(error)
        }
    }
    
    public static func typeFilename(logType: LogType) -> String {
        switch logType {
        case .info:
            return "info.log"
        case .error:
            return "error.log"
        case .warning:
            return "warning.log"
        }
    }
    
    public static func lineBuilder(_ message: String) -> String {
        return "\(Date()) \(message)"
    }
}

public extension SwiftLog {
    enum LogType {
        case info, error, warning
    }
    
    enum Location {
        case documentDirectory, currentDirectory
        case custom(path: String)
        
        func url(filename: String) -> URL {
            switch self {
            case .documentDirectory:
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                return documentDirectory.appendingPathComponent(filename)
            case .currentDirectory:
                return URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(filename)
            case .custom(path: let path):
                return URL(fileURLWithPath: path).appendingPathComponent(filename)
            }
        }
    }
}

internal extension String {
    func appendLine(to url: URL) throws {
        try self.appending("\n").append(to: url)
    }
    
    func append(to url: URL) throws {
        let data = self.data(using: String.Encoding.utf8)
        try data?.append(to: url)
    }
}

internal extension Data {
    func append(to url: URL) throws {
        if let fileHandle = try? FileHandle(forWritingTo: url) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: url)
        }
    }
}
