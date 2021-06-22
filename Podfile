# Podfile
#source 'https://github.com/CocoaPods/Specs.git'
platform :ios,'10.0'
use_frameworks!

target 'YoutubeClone' do
    # Networking
    pod 'RxSwift',                '~> 5.1.1'
    pod 'RxCocoa',                '~> 5.1.1'
    pod 'SwiftHTTP', '2.1.0'
    pod 'AlamofireObjectMapper'
    pod 'SwiftyJSON'
    
    # Image
    pod 'SDWebImage', '5.6.0'
    pod 'SDWebImageSVGKitPlugin', '1.2.0'
    
    pod 'SQLite.swift', '0.11.5'
    pod 'iCarousel'
    pod 'YUCIHighPassSkinSmoothing'
    pod 'BEMCheckBox'
    pod 'Socket.IO-Client-Swift', '~> 15.1.0'
    
    pod 'OpenSSL-Universal', '~> 1.0'
    pod 'ReachabilitySwift', '4.3.1'
    
    # View
    pod 'PullToRefresher', '~> 3.1'
    pod 'IQKeyboardManagerSwift', '6.5.0'
    pod 'SnapKit', '5.0.0'
    
    #Google
    pod 'GoogleAPIClientForREST/YouTube', '~> 1.2.1'
    pod 'Google/SignIn', '~> 3.0.3'
    pod 'YouTubePlayer-Swift', '~> 1.0'
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
            config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = 'arm64'
        end
    end
end
