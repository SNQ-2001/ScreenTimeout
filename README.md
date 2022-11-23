# ScreenTimeout
## Installation
ScreenTimeout can be installed with the Swift Package Manager:
```
https://github.com/SNQ-2001/ScreenTimeout
```
You can also clone the repository and build the library locally.

## Demo
.assets/demo.mp4

## Usage
```swift
import SwiftUI
import ScreenTimeout

struct ContentView: View {
    @State var states: ScreenStates = .active
    var body: some View {
        VStack {
            Text(states == .active ? "User is active" : "User is inactive")
        }
        .onTimeout(seconds: 5) { status in
            self.states = status
        }
    }
}
```

## License
ScreenTimeout is available under the MIT license. See the [LICENSE](https://github.com/SNQ-2001/ScreenTimeout/blob/main/LICENSE) file for more info.
