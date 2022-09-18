# SwiftLog
 
SwiftLog is a very simple file logger made specifically for server usage.

# Example
Just call the static ``SwiftLog.log`` method and provide the necessary information.
```swift
SwiftLog.log(message: String, location: Location = .currentDirectory, logType: LogType = .info)
```