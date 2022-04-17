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
import KeychainAccess

@propertyWrapper
struct KeychainStorage<T: Codable>: DynamicProperty {

    typealias Value = T

    let key: String

    @State private var value: Value?

    init(wrappedValue: Value? = nil, _ key: String) {

        self.key = key

        var initialValue = wrappedValue

        do {

            try Keychain().get(key) { attributes in

                if let attributes = attributes, let data = attributes.data {

                    do {

                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(.IsoDateFormatter)

                        let decoded = try decoder.decode(Value.self, from: data)

                        initialValue = decoded

                    } catch let error {

                        print("\(error)")
                    }
                }
            }
        } catch let error {
            fatalError("\(error)")
        }

        self._value = State<Value?>(initialValue: initialValue)
    }

    var wrappedValue: Value? {

        get  {
            value
        }

        nonmutating set {

            value = newValue

            do {

                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .formatted(.IsoDateFormatter)

                let encoded = try encoder.encode(value)

                try Keychain().set(encoded, key: key)

            } catch let error {

                fatalError("\(error)")
            }
        }
    }

    var projectedValue: Binding<Value?> {

        Binding {
            wrappedValue
        } set: {
            wrappedValue = $0
        }
    }
}
