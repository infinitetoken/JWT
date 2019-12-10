# JWT

JWT is a Swift library for decoding JSON Web Tokens

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Installation

JWT can be installed using the Swift Package Manager. Add the following to your `Package.swift` file:

```swift

dependencies: [
    .Package(url: "https://github.com/infinitetoken/JWT.git", from: "2.0.0")
]

```

## Usage

```swift
let tokenString = """
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJpc3MiOiJFeGFtcGxlIiwic3ViIjoiMTIzNDU2Nzg5MCIsImF1ZCI6IkV4YW1wbGUiLCJuYW1lIjoiSm9obiBEb2UiLCJleHAiOjE1MTYyMzkwMjIsImlhdCI6MTUxNjIzOTAyMiwibmJmIjoxNTE2MjM5MDIyLCJqdGkiOiIxIn0.qg7XpG3ir8PdFbY0MKBBIyYBV6sKiQolMJjJyU2PMjQ
"""

do {
    let token = try JWT.decode(token: tokenString)

    print(token.payload.iss) // "Example"
    print(token.payload.sub) // "1234567890"
    print(token.payload.claims["name"] as? String) // "John Doe"
} catch {
    print(error.localizedDescription)
}
```

## License

JWT is released under the MIT license. [See LICENSE](https://github.com/infinitetoken/JWT/blob/master/LICENSE) for details.

