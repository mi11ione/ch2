import SwiftUI

@available(iOS 26, *)
struct TabHelper: UIViewRepresentable {
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear

        DispatchQueue.main.async {
            guard let compositingGroup = view.superview?.superview else { return }
            guard let swiftUIWrapperUITabView = compositingGroup.subviews.last else { return }

            if let tabBarController = swiftUIWrapperUITabView.subviews.first?.next as? UITabBarController {
                tabBarController.view.backgroundColor = .clear
                tabBarController.viewControllers?.forEach { $0.view.backgroundColor = .clear }
                tabBarController.delegate = context.coordinator
                tabBarController.tabBar.removeFromSuperview()

                tabBarController.customizableViewControllers = []
                tabBarController.moreNavigationController.navigationBar.isHidden = true
            }
        }

        return view
    }

    func updateUIView(_: UIViewType, context _: Context) {}

    class Coordinator: NSObject, UITabBarControllerDelegate, UIViewControllerAnimatedTransitioning {
        func tabBarController(_: UITabBarController, animationControllerForTransitionFrom _: UIViewController, to _: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? { self }

        func transitionDuration(using _: (any UIViewControllerContextTransitioning)?) -> TimeInterval { .zero }

        func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
            guard let destination = transitionContext.view(forKey: .to) else { return }
            transitionContext.containerView.addSubview(destination)
            transitionContext.completeTransition(true)
        }
    }
}

extension View {
    var isiOS26: Bool {
        if #available(iOS 26, *) { true } else { false }
    }
}
