# JWT

[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)

JWT is a Swift library for JSON Web Tokens!

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate JWT into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "infinitetoken/JWT" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `JWT.framework` into your Xcode project.

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

