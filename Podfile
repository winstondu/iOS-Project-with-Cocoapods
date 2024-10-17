platform :ios, '14'

use_frameworks!
use_modular_headers!
inhibit_all_warnings! # Ignore warnings from pods

# Use the new CDN.
# https://blog.cocoapods.org/CocoaPods-1.7.2/
source 'https://cdn.cocoapods.org/'

# Pods
target 'WinstonBoilerPlate' do
  # RxSwift
  pod 'RxSwift', '~> 5.1.1'
  pod 'RxRelay'
  pod 'RxSwiftExt', '~> 5'

  # Image loading/caching
  pod 'Nuke', :git => 'git@github.com:kean/Nuke.git', :tag => '10.11.2'
  pod 'NukeUI', :git => 'git@github.com:kean/NukeUI.git', :tag => '0.8.3'

  # UI
  pod "TinyConstraints"

  #target 'WinstonBoilerPlate' do
    #inherit! :search_paths
    #use_frameworks!
  #end
end
#end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Force deploy targets
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

