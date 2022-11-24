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

    private func changeScreenStatus(status: ScreenStates) {
        if self.states != status {
            states = status
            perform(status)
        }
    }

    private func start() {
        changeScreenStatus(status: .active)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { _ in
            changeScreenStatus(status: .timeout)
        }
    }

    private func stop() {
        timer?.invalidate()
    }
}
