//
//  Extensions.swift
//  Country Quiz
//
//  Created by Thomas Frank on 1/1/26.
//


import SwiftUI
import Combine
import UIKit

// MARK: - UIScreen Extensions
extension UIScreen {
    static var current: UIScreen {
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) {
            return windowScene.screen
        }
        return UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.screen }
            .first ?? UIScreen()
    }
    
    static var currentHeight: CGFloat {
        current.bounds.height
    }
    
    static var currentWidth: CGFloat {
        current.bounds.width
    }
    
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isCompactPad: Bool {
        isPad && min(currentHeight, currentWidth) < 750
    }
    
    static var isSmall: Bool {
        currentHeight < 700
    }
}

// MARK: - Environment Keys
private struct ScreenHeightKey: EnvironmentKey {
    static let defaultValue: CGFloat = UIScreen.currentHeight
}

private struct IsPadKey: EnvironmentKey {
    static let defaultValue: Bool = UIScreen.isPad
}

private struct IsCompactPadKey: EnvironmentKey {
    static let defaultValue: Bool = UIScreen.isCompactPad
}

private struct IsSmallKey: EnvironmentKey {
    static let defaultValue: Bool = UIScreen.isSmall
}

private struct IsLandscapeKey: EnvironmentKey {
    static let defaultValue: Bool = {
        let screen = UIScreen.current
        return screen.bounds.width > screen.bounds.height
    }()
}

// MARK: - Environment Values
extension EnvironmentValues {
    var screenHeight: CGFloat {
        get { self[ScreenHeightKey.self] }
        set { self[ScreenHeightKey.self] = newValue }
    }
    
    var isPad: Bool {
        get { self[IsPadKey.self] }
        set { self[IsPadKey.self] = newValue }
    }
    
    var isCompactPad: Bool {
        get { self[IsCompactPadKey.self] }
        set { self[IsCompactPadKey.self] = newValue }
    }
    
    var isSmall: Bool {
        get { self[IsSmallKey.self] }
        set { self[IsSmallKey.self] = newValue }
    }
    
    var isLandscape: Bool {
        get { self[IsLandscapeKey.self] }
        set { self[IsLandscapeKey.self] = newValue }
    }
}

// MARK: - Orientation Observer
final class OrientationObserver: ObservableObject {
    @Published var isLandscape: Bool = {
        let screen = UIScreen.current
        return screen.bounds.width > screen.bounds.height
    }()
    
    private var cancellable: AnyCancellable?
    
    init() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        cancellable = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { _ in
                let orientation = UIDevice.current.orientation
                return orientation.isValidInterfaceOrientation ? orientation.isLandscape : nil
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isLandscape, on: self)
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        cancellable?.cancel()
    }
}

private extension UIDeviceOrientation {
    var isValidInterfaceOrientation: Bool {
        self == .portrait ||
        self == .portraitUpsideDown ||
        self == .landscapeLeft ||
        self == .landscapeRight
    }
}

// MARK: - Orientation Environment Wrapper
struct OrientationEnvironmentView<Content: View>: View {
    @StateObject private var orientation = OrientationObserver()
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .environment(\.isLandscape, orientation.isLandscape)
    }
}

// MARK: - Example Usage
/*
 @main
 struct TrafikkskiltQuizApp: App {
 var body: some Scene {
 WindowGroup {
 OrientationEnvironmentView {
 ContentView()
 }
 }
 }
 }
 
 struct ContentView: View {
 @Environment(\.isLandscape) private var isLandscape
 @Environment(\.isPad) private var isPad
 
 var body: some View {
 Image("background")
 .resizable()
 .scaledToFill()
 .offset(x: (isPad && !isLandscape) ? -250 : isPad ? 0 : -70)
 .ignoresSafeArea()
 }
 }
 */

struct WrappedTextView: UIViewRepresentable {
    let text: String
    let image: UIImage
    let imageSize: CGSize
    let font: UIFont
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.isUserInteractionEnabled = false
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: .zero, size: imageSize)
        
        let attributedText = NSMutableAttributedString(string: text)
        let path = UIBezierPath(rect: CGRect(x: uiView.bounds.width - imageSize.width - 8,
                                             y: 0,
                                             width: imageSize.width + 8,
                                             height: imageSize.height))
        uiView.textContainer.exclusionPaths = [path]
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 6
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraph
        ]
        
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
        uiView.attributedText = attributedText
    }
}

