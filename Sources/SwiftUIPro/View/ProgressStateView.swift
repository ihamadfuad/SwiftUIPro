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

public enum ProgressState {

    case loading
    case success
    case failure
    case finished
}

public extension View {

    func progressBlurView(state progressState: Binding<ProgressState>) -> some View {

        modifier(ProgressBlurView(progressState: progressState))
    }
}

public struct ProgressBlurView: ViewModifier {

    @Binding var progressState: ProgressState

    public func body(content: Content) -> some View {

        content
            .blur(radius: progressState == .loading ? 15.0 : 0.0)
            .animation(.easeInOut, value: progressState == .loading ? 15.0 : 0.0)
    }
}

public struct ProgressStateView: View {

    @Binding var progressState: ProgressState

    public var body: some View {

        Group {

            if progressState != .finished {

                VStack {

                    Spacer()

                    Group {

                        switch progressState {

                        case .loading:
                            ProgressView("Please wait...")
                        case .success:
                            ProgressView("Success")
                        case .failure:
                            ProgressView("Failure, please try again later.")
                        case .finished:
                            ProgressView("Done")
                        }
                    }
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.primary)

                    Spacer()
                }
            }
        }
    }
}
