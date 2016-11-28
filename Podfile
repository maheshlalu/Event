# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'FitSport' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FitSport
pod 'MagicalRecord/Shorthand'
pod 'Google/SignIn'
pod 'SDWebImage', '~> 3.8'
pod 'AFNetworking', '~> 3.1'
pod 'FSCalendar'
pod 'Alamofire', '~> 4.0'
pod "KRProgressHUD"
pod 'ActionSheetPicker-3.0'
pod 'SKPhotoBrowser', :git => 'https://github.com/suzuki-0000/SKPhotoBrowser.git', :branch => 'swift3'
pod 'SCLAlertView'
pod 'Firebase/Core'
pod 'Firebase/Crash'
  target 'FitSportTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FitSportUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end

end
