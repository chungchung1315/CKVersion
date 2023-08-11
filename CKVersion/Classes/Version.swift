//
//  Version.swift
//  CKVersion
//
//  Created by Marcel on 2023/08/08.
//

import Foundation

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
    
    /// Get current app local version. nil if the version doesn't follow the format, "1.0.0".
    public static func localAppVersion() -> Version? {
        guard let info = Bundle.main.infoDictionary,
              let version = info["CFBundleShortVersionString"] as? String else {
            return nil
        }
        return Version.init(string: version)
    }
    
    /// String representation. e.g. "1.0.0"
    public var toString: String {
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

public extension Version {
    
    /// Fetch App Store version of this app or an app of the specified bundleIdentifier.
    static func fetchAppStoreVersion(bundleIdentifier: String? = Bundle.main.bundleIdentifier, completion: @escaping (_ version: Version?, _ error: Error?) -> Void) {
        
        guard let identifier = bundleIdentifier,
              let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            completion(nil, CKVersionError.appStoreVersionFetchError(nil))
            return
        }
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                completion(nil, CKVersionError.appStoreVersionFetchError(error))
                return
            }
            
            guard let data else {
                completion(nil, CKVersionError.appStoreVersionFetchError(nil))
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any],
                  let result = (json["results"] as? [Any])?.first as? [String: Any],
                  let version = result["version"] as? String else {
                completion(nil, CKVersionError.appStoreVersionFetchError(nil))
                return
            }
            
            guard let appStoreVersion = Version.from(string: version) else {
                completion(nil, CKVersionError.invalidFormat)
                return
            }
            completion(appStoreVersion, nil)
        }
        
        task.resume()
    }
    
    @available(iOS 13.0, *)
    static func fetchAppStoreVersion(bundleIdentifier: String? = Bundle.main.bundleIdentifier) async throws -> Version {
        guard let bundleIdentifier else {
            throw CKVersionError.failToFindBundleIdentifier
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            fetchAppStoreVersion(bundleIdentifier: bundleIdentifier, completion: { version, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    if let version {
                        continuation.resume(returning: version)
                    } else {
                        continuation.resume(throwing: CKVersionError.appStoreVersionFetchError(nil))
                    }
                }
            })
        }
    }
}
