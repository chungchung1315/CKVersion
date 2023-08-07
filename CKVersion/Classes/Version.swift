//
//  Version.swift
//  CKVersion
//
//  Created by Marcel on 2023/08/08.
//

public struct Version: Equatable, Comparable {
    public let major: UInt
    public let minor: UInt
    public let patch: UInt
    
    private init?(string: String) {
        var numbers = Array(string.split(separator: "."))
        guard !numbers.isEmpty, numbers.count == 3 else { return nil }
        
        if let major = UInt(numbers.removeFirst()),
           let minor = UInt(numbers.removeFirst()),
           let patch = UInt(numbers.removeFirst()) {
            self.major = major
            self.minor = minor
            self.patch = patch
        } else {
            return nil
        }
    }
    
    private init(_ major: UInt, _ minor: UInt, _ patch: UInt) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
    /// Version string example: "1.0.0". It must have three parts.
    public static func from(string: String) -> Version? {
        return Version.init(string: string)
    }
    
    /// Input major, minor, and patch version.
    public static func from(_ major: UInt, _ minor: UInt, _ patch: UInt) -> Version? {
        return Version.init(major, minor, patch)
    }
    
    /// String representation. e.g. "1.0.0"
    var toString: String {
        [major, minor, patch].map { String($0) }.joined(separator: ".")
    }
    
    public static func == (lhs: Version, rhs: Version) -> Bool {
        if lhs.major == rhs.major &&
            lhs.minor == rhs.minor &&
            lhs.patch == rhs.patch {
            return true
        } else {
            return false
        }
    }
    
    public static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major < rhs.major {
            return true
        }
        if lhs.major == rhs.major {
            if lhs.minor < rhs.minor {
                return true
            }
            if lhs.minor == rhs.minor {
                if lhs.patch < rhs.patch {
                    return true
                }
            }
        }
        
        return false
    }
}
