//
//  ViewController.swift
//  CKVersion
//
//  Created by chungchung1315 on 08/08/2023.
//  Copyright (c) 2023 chungchung1315. All rights reserved.
//

import UIKit
import CKVersion

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("localAppVersion: ", try! Version.localAppVersion())
        
        Version.fetchAppStoreVersion(bundleIdentifier: "com.yahoo.frontpage", completion: { version, error in
            
            if let error {
                print(error)
            }
            
            print("fetchAppStoreVersion: ", version ?? "nil")
            print("fetchAppStoreVersion error: ", error ?? "nil")
        })
        
        if #available(iOS 13.0, *) {
            Task {
                let version = try await Version.fetchAppStoreVersion(bundleIdentifier: "com.yahoo.frontpage")
                print("fetchAppStoreVersion async: ", version.toString)
            }
        }
    }
}

