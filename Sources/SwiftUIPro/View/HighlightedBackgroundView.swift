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

struct HighlightedBackgroundView: View {

    @Binding var color: Color

    var body: some View {

        Group {

            HStack {

                VStack(alignment: .leading) {

                    Text("Hello, World!")
                        .bold()
                        .padding(.top, 8)
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five ")
                        .padding(.bottom, 8)
                }

                Spacer()
            }
        }
        .foregroundColor(color)
        .frame(maxWidth: .infinity)
        .modifier(HighlightedViewModifier(color: color))
        .padding()
    }
}

struct HighlightedViewModifier: ViewModifier {

    var showAccent = true
    var radius: CGFloat = 6
    var color: Color

    func body(content: Content) -> some View {

        VStack(alignment: .leading) {

            content
                .padding(.leading, showAccent ? 20 : 8)
                .padding(.trailing, 8)
        }
        .background(background)
    }

    var background: some View {

        HStack(spacing: 6) {

            if showAccent {

                RoundedRectangle(cornerRadius: 1, style: .continuous)
                    .fill(color)
                    .frame(width: 4)
            }

            RoundedRectangle(cornerRadius: radius, style: .continuous)
                .fill(color.opacity(0.1))
                .mask {

                    HStack(spacing: 0) {

                        ForEach(0..<120, id: \.self) { index in

                            Rectangle()
                                .fill(.white)
                                .frame(width: 4)

                            Rectangle()
                                .fill(.clear)
                                .frame(width: 4)
                        }
                    }
                    .transformEffect(CGAffineTransform(a: 1, b: 0, c: -2, d: 3, tx: 0, ty: 0))
                }
                .background(RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(color.opacity(0.06)))
        }
    }
}

struct HighlightBackground_Previews: PreviewProvider {
    static var previews: some View {
        HighlightedBackgroundView(color: .constant(.red))
    }
}
