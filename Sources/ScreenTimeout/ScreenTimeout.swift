import SwiftUI

public extension View {
    func onTimeout(seconds: TimeInterval = 30, perform: ((ScreenStates) -> Void)?) -> some View {
        Timeout(content: self, seconds: seconds) { status in
            if let perform {
                perform(status)
            }
        }
    }
}

public enum ScreenStates {
    case active
    case timeout
}

fileprivate struct Timeout<T: View>: View {
    var content: T
    var seconds: TimeInterval
    var perform: ((ScreenStates) -> Void)

    @State var timer: Timer? = nil
    @State var states: ScreenStates = .timeout

    var body: some View {
        content
            .onTapGesture {
                start()
            }
            .onAppear {
                start()
            }
            .onDisappear {
                stop()
            }
    }

    private func start() {
        if states == .timeout {
            states = .active
            perform(.active)
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { _ in
            states = .timeout
            perform(.timeout)
        }
    }

    private func stop() {
        timer?.invalidate()
    }
}
