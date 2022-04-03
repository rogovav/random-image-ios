//
//  MainVC.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

final class MainVC: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let barButtonItemSize: CGSize = CGSize(width: 24, height: 24)
    }

    // MARK: - Properties

//    private var viewModel: ProductViewModel

    // MARK: - Components

//    private lazy var navPadView = UIView().configureWithAutoLayout {
//        $0.backgroundColor = Asset.white.color
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect).prepareForAutoLayout()
//        $0.addSubview(blurEffectView)
//        blurEffectView.pinToSuperview()
//    }
//
//    @objc private var cartItem: CartNavigationItem = CartNavigationItem.shared

    // MARK: - Appearance

//    override var navAppearanceStyle: NavigationAppearanceStyle {
//        if #available(iOS 13.0, *) {
//            return .compactTransparent(statusBarStyle: .default, isTranslucent: false)
//        } else {
//            return .compactTransparent(statusBarStyle: .default, isTranslucent: true)
//        }
//    }

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
//        view.addSubview(productDetailView)
//        productDetailView.safeArea { $0.top() }.left().right()
//
//        view.addSubview(navPadView)
//        navPadView.pin(excluding: .bottom).height(CommonConstants.statusBarHeight + CommonConstants.compactNavigationHeight)
//
//        bottomConstraint = productDetailView.bottomAnchor ~ view.bottomAnchor
//        productDetailView.setup()
//        viewModel.viewDidLoad?()
//        navigationItem.rightBarButtonItems = [
//            cartItem.instance,
//        ]
//        if case .deepLink = viewModel.sourceType {
//            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton().configureWithAutoLayout {
//                $0.width(Constants.barButtonItemSize.width).height(Constants.barButtonItemSize.height)
//                $0.setImage(Asset.navClose.image.withRenderingMode(.alwaysTemplate), for: .normal)
//                $0.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
//                $0.contentHorizontalAlignment = .fill
//            })
//        }
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        edgesForExtendedLayout = [UIRectEdge.top, UIRectEdge.bottom]
//        extendedLayoutIncludesOpaqueBars = true
//        changeTabBar(hidden: true, forced: true)
//        NotificationCenter.default.addObserver(
//                self,
//                selector: #selector(anotherVCWillAppear(_:)),
//                name: .parentVCWillAppear,
//                object: nil
//        )
//    }

//    override func viewWillDisappear(_ animated: Bool) {
//        navigationDidAppear(appear: false)
//        super.viewWillDisappear(animated)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        NotificationCenter.default.removeObserver(self) // swiftlint:disable:this notification_center_detachment
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        navigationDidAppear(appear: true)
//    }
//
//    override func propsDidChange(_ props: ProductProps, changes: [DiffFieldsKeys]) {
//        super.propsDidChange(props, changes: changes)
//        let changes = changes.compactMap { $0 as? ProductProps.FieldsKeys }
//        productDetailView.apply(props: props, changes: changes)
//    }
//
//    @objc
//    private func anotherVCWillAppear(_ notification: Notification) {
//        guard let vc = notification.object as? ParentViewControllerProtocol, vc != self else {
//            return
//        }
//        changeTabBar(hidden: !vc.navAppearanceStyle.showTabBar, animated: true, forced: true)
//    }
//
//    @objc
//    private func closeAction() {
//        Dispatcher.main.call(RouterActions.dismiss)
//    }
//
//    private func navigationDidAppear(appear: Bool) {
//        UIView.animate(withDuration: CommonConstants.animationDuration) { () -> Void in
//            self.navPadView.backgroundColor = appear ? .clear : Asset.white.color
//            self.navPadView.alpha = appear ? 0.95 : 1
//        }
//    }
//
//    private func changeTabBar(hidden: Bool, animated: Bool = true, forced: Bool = false) {
//        guard let tabBar = tabBarController?.tabBar else {
//            return
//        }
//        if (hidden != tabBarHidden && !isTabBarAnimating) || forced {
//            _changeTabBar(tabBar, hidden: hidden, animated: animated)
//        }
//    }
//
//    private func _changeTabBar(_ tabBar: UITabBar, hidden: Bool, animated: Bool = true) {
//        guard (hidden && !tabBar.isHidden) || (!hidden && tabBar.isHidden) else {
//            return
//        }
//        isTabBarAnimating = true
//        let transform = {
//            tabBar.isUserInteractionEnabled = !hidden
//            let keyWindow = UIApplication.shared.keyWindow!.frame // swiftlint:disable:this force_unwrapping
//            let applicationBottomBound = keyWindow.minY + keyWindow.height
//            let tabY = hidden ? applicationBottomBound : applicationBottomBound - tabBar.bounds.size.height
//            let frame = CGRect(
//                    origin: CGPoint(x: 0, y: tabY),
//                    size: tabBar.bounds.size
//            )
//            tabBar.frame = frame
//        }
//        let updateBottomConstraints = { [weak self] in
//            guard let self = self else {
//                return
//            }
//            self.bottomConstraint.constant = hidden ?
//                    (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0) :
//                    -tabBar.bounds.height
//        }
//        let updateHiddenState = { (condition: Bool, state: Bool) in
//            if condition {
//                updateBottomConstraints()
//            } else {
//                tabBar.isHidden = state
//            }
//        }
//        updateHiddenState(hidden, false)
//        if animated {
//            UIView.animate(
//                    withDuration: CommonConstants.animationDuration,
//                    delay: 0.0,
//                    animations: { transform() },
//                    completion: { [weak wSelf = self] _ in
//                        guard let self = wSelf else {
//                            return
//                        }
//                        updateHiddenState(!hidden, true)
//                        self.isTabBarAnimating = false
//                        self.tabBarHidden = hidden
//                    }
//            )
//        } else {
//            transform()
//            updateHiddenState(!hidden, true)
//            isTabBarAnimating = false
//            tabBarHidden = hidden
//        }
//    }
}
