//
//  BaseViewController.swift
//

import Foundation
import UIKit

open class BaseViewController: UIViewController, ViewControllerDelegate, Observer {
    var initData = [String: Any]()
    var responseData = [String: Any]()
    var delegate: ViewControllerDelegate?
    var viewAppeared = false
    
    var views = [UIView]()
    
    fileprivate var controllers: [BaseController] = []
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !viewAppeared {
            for view in views {
                view.viewWillAppear()
            }
        } else {
            for view in views {
                view.viewWillReappear()
            }
        }
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppear()
    }

    fileprivate func viewDidAppear() {
        Notifier.controllerNoitfier.addObserver(self) // listen for events from controller
        Notifier.viewNotifier.addObserver(self) // listen for events from subviews
        Notifier.globalNotifier.addObserver(self)
        for controller in controllers {
            controller.isPause = false
        }
        if !viewAppeared {
            for view in views {
                view.viewDidAppear()
            }
        } else {
            for view in views {
                view.viewDidReappear()
            }
        }
        viewAppeared = true
    }
    
    override open func viewWillDisappear(_ animated: Bool)  {
        super.viewWillDisappear(animated)
        viewWillDisappear()
    }

    fileprivate func viewWillDisappear() {
        Notifier.controllerNoitfier.removeObserver(self)
        Notifier.viewNotifier.removeObserver(self)
        Notifier.globalNotifier.removeObserver(self)
        for controller in controllers {
            controller.isPause = true
        }
        for view in views {
            view.viewWillDisappear()
        }
    }
    
    open func addView(_ view: UIView) {
        if views.firstIndex(of: view) == nil {
            views.append(view)
        }
    }
    
    open func removeView(_ view: UIView) {
        views.removeObject(view)
    }

    @objc open func onTouch(_ gesture: UIGestureRecognizer) -> Bool {
        return GestureUtil.processGesture(gesture, views: views)
    }

    func showViewController(_ id: String, data: [String: Any] = [String: Any](), delegate: ViewControllerDelegate? = nil, from: UIViewController? = nil) {
        let vc = Util.createViewController(storyboardName: AppConfig.storyboardName, id: id) as! BaseViewController
        vc.initData = data
        vc.delegate = delegate ?? self
        vc.modalPresentationStyle = .fullScreen
        (from ?? self).present(vc, animated: true, completion: nil)
    }
    
    func pushViewController(_ id: String, data: [String: Any] = [String: Any](), delegate: ViewControllerDelegate? = nil) {
        let vc = Util.createViewController(storyboardName: AppConfig.storyboardName, id: id) as! BaseViewController
        vc.initData = data
        vc.delegate = delegate ?? self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDialog(_ id: String, data: [String: Any] = [String: Any](), delegate: ViewControllerDelegate? = nil) {
        let vc = Util.createViewController(storyboardName: AppConfig.storyboardName, id: id) as! BaseViewController
        vc.initData = data
        vc.delegate = DialogDelegate(viewController: self, delegate: delegate ?? self)
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: {
            self.viewWillDisappear(true)
        })
    }
    
    func showViewController(_ viewController: BaseViewController, data: [String: Any] = [String: Any](), delegate: ViewControllerDelegate? = nil, from: UIViewController? = nil) {
        viewController.initData = data
        viewController.delegate = delegate ?? self
        viewController.modalPresentationStyle = .fullScreen
        (from ?? self).present(viewController, animated: true, completion: nil)
    }
    
    func showDialog(_ viewController: BaseViewController, data: [String: Any] = [String: Any](), delegate: ViewControllerDelegate? = nil) {
        viewController.initData = data
        viewController.delegate = DialogDelegate(viewController: self, delegate: delegate ?? self)
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true, completion: {
            self.viewWillDisappear(true)
        })
    }
    
    static func showRootViewController(_ id: String, data: [String: Any] = [String: Any]()) {
        let vc = Util.createViewController(storyboardName: AppConfig.storyboardName, id: id) as! BaseViewController
        vc.initData = data
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            UIApplication.shared.keyWindow?.set(rootViewController: vc)
        }
    }
    
    class DialogDelegate: ViewControllerDelegate {
        private(set) var delegate: ViewControllerDelegate?
        private(set) weak var viewController: BaseViewController?
        
        init(viewController: BaseViewController?, delegate: ViewControllerDelegate?) {
            self.viewController = viewController
            self.delegate = delegate
        }
        
        func viewControllerDidDismiss(sender: UIViewController, data: [String: Any]) {
            if let viewController = self.viewController {
                viewController.setNeedsStatusBarAppearanceUpdate()
                viewController.viewDidAppear(true)
            }
            if let delegate = delegate {
                delegate.viewControllerDidDismiss?(sender: sender, data: data)
            }
        }
    }

    func dismissViewController(animated: Bool = true, data: [String: Any] = [:], completion: (()->Void)? = nil) {
        responseData = data
        // prevent mem leak
        let delegate = self.delegate
        self.delegate = nil
        self.dismiss(animated: animated, completion: {
            delegate?.viewControllerDidDismiss?(sender: self, data: data)
            completion?()
        })
    }
    
    public func update(_ command: Int, data: Any?) {}

    deinit {
        releaseControllers()
    }
}

extension UIViewController {
}

extension BaseViewController: ControllerManager {
    open func addController(_ controller: BaseController) {
        controllers.append(controller)
    }

    open func releaseControllers() {
        for controller in controllers {
            Notifier.serviceNotifier.removeObserver(controller)
        }
    }
}
