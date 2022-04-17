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

import SwiftUI

enum AppPermission: String, CaseIterable {

    case notifications
    case contacts, calendar, reminders, location
    case camera, photos
    case speechRecognition , microphone

    var meta: (image: String, title: String, subtitle: String) {

        switch self {
        case .notifications:
            return ("bell.badge.fill", "The app sends notifications to teammates and receive notifications from anyone.", "Please choose —Allow— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .contacts:
            return ("person.crop.circle.fill", "The app finds existing teammates and invite them to join Nural.", "Please choose —OK— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .calendar:
            return ("calendar", "The app syncs with Calendar in your device to get latest events.", "Please choose —OK— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .reminders:
            return ("checklist", "The app syncs with Reminders in your device to get latest reminders.", "Please choose —OK— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .location:
            return ("location.fill", "The app shares your current location to your teammates when you decide to do so.", "Please choose —Allow While Using App— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .camera:
            return ("camera.fill", "The app captures photos or video from Camera to share them with your teammates.", "Please choose —OK— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .photos:
            return ("photo.on.rectangle.angled", "The app imports photos or video from your Photos to share them with your teammates.", "Please choose —Allow Access to All Photos— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .speechRecognition:
            return ("waveform.and.mic", "The app recognizes spoken words in recorded or live audio to translate audio content into text.", "Please choose —OK— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        case .microphone:
            return ("mic.fill", "The app records your voice to share voice notes with your teammates.", "Please choose —OK— to get the most of Nural! Some features won’t work as expected if you don’t allow.")
        }
    }
}
