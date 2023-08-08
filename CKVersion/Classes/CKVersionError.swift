//
//  CKVersionError.swift
//  CKVersion
//
//  Created by Marcel on 2023/08/09.
//

import Foundation

public enum CKVersionError: Error {
    case invalidFormat
    case failToFindBundleIdentifier
    case appStoreVersionFetchError(Error?)
}
