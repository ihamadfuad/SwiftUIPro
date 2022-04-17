//
//  AppPermissionManager.swift
//  
//
//  Created by Hamad Ali on 17/04/2022.
//

import SwiftUI
import Contacts
import AddressBook
import EventKit
// ºººº----------------------------------------------------------------------ºººº \\
//
// Copyright (c) 2022 Hamad Fuad.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// Author: Hamad Fuad
// Email: ihamadfouad@icloud.com
//
// Created At: 17/04/2022
// Last modified: 17/04/2022
//
// ºººº----------------------------------------------------------------------ºººº \\

import AVFoundation
import Photos
import Speech

final class AppPermissionManager {

    actor Notifications {

        var authorizationStatus: UNAuthorizationStatus {

            var notificationSettings: UNNotificationSettings?
            let semaphore = DispatchSemaphore(value: 0)

            DispatchQueue.global().async {
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    //notificationSettings = settings
                    semaphore.setValue(settings, forKey: "UNNotificationSettings")
                    semaphore.signal()
                }
            }

            semaphore.wait()

            notificationSettings = semaphore.value(forKey: "UNNotificationSettings") as? UNNotificationSettings

            guard let settings = notificationSettings else{
#if DEBUG
                print("Notification settings is nil while getting authorization status")
#endif
                return .notDetermined
            }

            return settings.authorizationStatus
        }

        func askPermission() async throws -> Bool {

            return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        }
    }

    actor Contacts {

        var authorizationStatus: CNAuthorizationStatus {

            return CNContactStore.authorizationStatus(for: .contacts)
        }

        func askPermission() async throws -> Bool {

            let store = CNContactStore()
            return try await store.requestAccess(for: .contacts)
        }
    }

    actor Calendar {

        var authorizationStatus: EKAuthorizationStatus {

            return EKEventStore.authorizationStatus(for: .event)
        }

        func askPermission() async throws -> Bool {

            let store = EKEventStore()
            return try await store.requestAccess(to: .event)
        }
    }

    actor Reminders {

        var authorizationStatus: EKAuthorizationStatus {

            return EKEventStore.authorizationStatus(for: .reminder)
        }

        func askPermission() async throws -> Bool {

            let store = EKEventStore()
            return try await store.requestAccess(to: .reminder)
        }
    }

    class Location: NSObject, CLLocationManagerDelegate {

        var completionBlock: ((Bool, Error?) -> Void)?
        var locationManager = CLLocationManager()

        deinit {
            locationManager.delegate = nil
        }

        var authorizationStatus: CLAuthorizationStatus {

            return locationManager.authorizationStatus
        }

        func askPermission() {

            locationManager.requestWhenInUseAuthorization()
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

            if status == .notDetermined {
                return
            }

            if let completionBlock = completionBlock {

                let status = locationManager.authorizationStatus

                //Completion handler called from this delegate function
                //Both authorizedAlways and authorizedWhenInUse will be acceptable
                completionBlock(status == .authorizedAlways || status == .authorizedWhenInUse ? true : false, nil)

            }
        }
    }

    actor Camera {

        var authorizationStatus: AVAuthorizationStatus {

            return AVCaptureDevice.authorizationStatus(for: .video)
        }

        func askPermission() async -> Bool {

            return await AVCaptureDevice.requestAccess(for: .video)
        }
    }

    actor Photos {

        var photoLibrary: PHPhotoLibrary.Type = PHPhotoLibrary.self

        var authorizationStatus: PHAuthorizationStatus {

            return PHPhotoLibrary.authorizationStatus()
        }

        func askPermission() async -> PHAuthorizationStatus {

            return await photoLibrary.requestAuthorization(for: .readWrite)
        }
    }

    actor SpeechRecognition {

        var authorizationStatus: SFSpeechRecognizerAuthorizationStatus {

            return SFSpeechRecognizer.authorizationStatus()
        }

        func askPermission() {

            SFSpeechRecognizer.requestAuthorization({ status in

                switch status {
                case .notDetermined:
                    break
                case .denied:
                    break
                case .restricted:
                    break
                case .authorized:
                    break
                @unknown default:
                    fatalError()
                }
            })
        }
    }

    actor Microphone {

        var authorizationStatus: AVAuthorizationStatus {

            return AVCaptureDevice.authorizationStatus(for: .audio)
        }

        func askPermission() {

            AVAudioSession.sharedInstance().requestRecordPermission({ granted in

            })
        }
    }
}
