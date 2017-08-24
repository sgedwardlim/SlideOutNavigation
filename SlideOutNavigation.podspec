#
#  Be sure to run `pod spec lint SlideOutNavigation.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SlideOutNavigation"
  s.version      = "0.0.1"
  s.summary      = "SlideOutNavigation provides a new way of navigating around the iOS platforms."
  s.description  = "SlideOutNavigation is a customizable framework that allows users to 
                    easily add menu items and customize the look and feel of their navigation bar, 
                    with sleek and stylish interfaces that allow for easy customization."

  s.homepage     = "https://github.com/sgedwardlim/SlideOutNavigation"

  s.license      = "MIT"

  s.author       = "Edward Lim"

  s.platform     = :ios, "10.0"
  s.source       = { :path => '.' }

  s.source_files  = "SlideOutNavigation", "SlideOutNavigation/**/*.{h,m,swift}"
  s.exclude_files = "SlideOutNavigation/Exclude"

  s.resources = "menu.png"
  s.resources = "SlideOutNavigation/Supporting Files/Media.xcassets"
  # s.resources = "SlideOutNavigation/Supporting Files/Assets"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
