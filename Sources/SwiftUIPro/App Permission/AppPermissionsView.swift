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

struct AppPermissionsView: View {

    var appIcon: String?
    @Binding var selectedPermission: AppPermission

    var body: some View {

        VStack {

            HStack {

                Image(systemName: "hand.raised.fill")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .frame(width: 32, height: 32)

                Text("Allow Permission")
                    .bold()
                    .foregroundColor(.accentColor)
            }

            Spacer()

            HStack {

                Group {

                    Group {

                        if let appIcon = appIcon {
                            Image(appIcon)
                                .resizable()
                        } else {
                            Image(systemName: "questionmark.app.dashed")
                                .resizable()
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                    Image(systemName: "chevron.forward")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .frame(width: 64, height: 64)

                    Image(systemName: selectedPermission.meta.image)
                        .font(.system(size: 44))
                        .foregroundColor(.accentColor)
                        .frame(width: 64, height: 64)
                }
            }
            .padding()
            .modifier(HighlightedViewModifier(showAccent: false, radius: 8, color: .gray))
            .padding([.top, .bottom])


            Spacer()

            Group {

                Text(selectedPermission.meta.title)
                    .padding(.bottom)

                Text(selectedPermission.meta.subtitle)
                    .foregroundColor(.secondary)
            }
            .multilineTextAlignment(.center)

            Spacer()
            Spacer()

            Button(action: {

                Task.detached {

                    switch selectedPermission {
                    case .notifications:

                        let result = try? await AppPermissionManager.Notifications().askPermission()
                        print(selectedPermission, result as Any)

                    case .contacts:

                        let result = try? await AppPermissionManager.Contacts().askPermission()
                        print(selectedPermission, result as Any)

                    case .calendar:

                        let result = try? await AppPermissionManager.Calendar().askPermission()
                        print(selectedPermission, result as Any)

                    case .reminders:

                        let result = try? await AppPermissionManager.Reminders().askPermission()
                        print(selectedPermission, result as Any)

                    case .location:

                        AppPermissionManager.Location().askPermission()

                    case .camera:

                        let result = await AppPermissionManager.Camera().askPermission()
                        print(selectedPermission, result as Any)

                    case .photos:

                        let result = await AppPermissionManager.Photos().askPermission()
                        print(selectedPermission, result as Any)

                    case .speechRecognition:

                        await AppPermissionManager.SpeechRecognition().askPermission()

                    case .microphone:

                        await AppPermissionManager.Microphone().askPermission()
                    }
                }
            }) {

                Text("Request Permission")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.accentColor))
            }
        }
        .padding()
    }
}

struct AppPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        AppPermissionsView(selectedPermission: .constant(.microphone))

    }
}
