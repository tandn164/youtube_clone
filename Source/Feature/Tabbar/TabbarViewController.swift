//TabbarViewController.swift

import UIKit
import SnapKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let globalDataController = ControllerFactory.globalDataController
    let homeController = HomeViewController()
    let trendingController = TrendingViewController()
    let notificationController = NotificationViewController()
    let myAccountController = MyAccountViewController()
    var liveButton : LiveStreamButton!
    
    static var current: TabbarViewController?
    var notiCount: Int = 0 {
        didSet {
            if notiCount == 0 {
                tabBar.removeItemBadge(atIndex: 0)
            } else {
                tabBar.addItemBadge(atIndex: 0, value: notiCount)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TabbarViewController.current = self
        self.delegate = self
        let navHome = UINavigationController(rootViewController: homeController)
        let navTrending = UINavigationController(rootViewController: trendingController)
        let navNotification = UINavigationController(rootViewController: notificationController)
        let navMyAccount = UINavigationController(rootViewController: myAccountController)
        navHome.tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(named: "home_off_icon"),
                                          selectedImage: UIImage(named: "home_on_icon"))
        navTrending.tabBarItem = UITabBarItem(title: "Trending",
                                              image: UIImage(named: "trending_off_icon"),
                                              selectedImage: UIImage(named: "trending_on_icon"))
        navNotification.tabBarItem = UITabBarItem(title: "Notification",
                                                  image: UIImage(named: "notification_off_icon"),
                                                  selectedImage: UIImage(named: "notification_on_icon"))
        navMyAccount.tabBarItem = UITabBarItem(title: "My Account",
                                               image: UIImage(named: "my_account_off_icon"),
                                               selectedImage: UIImage(named: "my_account_on_icon"))
        self.viewControllers = [navHome, navTrending, UINavigationController(), navNotification, navMyAccount]
        self.setupTabbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: Setup Tabbar
    func setupTabbar() {
        self.tabBar.barTintColor = AppResources.Color.tabbar
        self.tabBar.tintColor = AppResources.Color.white
        self.tabBar.isTranslucent = false
        self.tabBar.invalidateIntrinsicContentSize()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppResources.Color.medium_gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppResources.Color.white], for: .selected)
        
        liveButton = LiveStreamButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ))
        tabBar.addSubview(liveButton)
        liveButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(0)
            make.width.equalTo(80)
            if #available(iOS 11.0, *) {
                make.height.equalTo(Device().safeAreaInsets.bottom+tabBar.frame.height+40)
            } else {
                make.height.equalTo(tabBar.frame.height+40)
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.navigateToLive))
        liveButton.isUserInteractionEnabled = true
        liveButton.addGestureRecognizer(tap)
    }
    
    //MARK: Navigate UI
    @objc func navigateToLive(){
        print("Live")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
