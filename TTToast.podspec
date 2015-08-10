Pod::Spec.new do |s|

  s.name         = "TTToast"
  s.version      = "0.0.1"
  s.summary      = "This is a simple toast library."

  s.homepage     = "https://github.com/tattn/TTToast"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Tatsuya Tanaka" => "tatsuyars@yahoo.co.jp" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/tattn/TTToast.git", :tag => "#{s.version}" }
  s.source_files  = "TTToast/TTToast/*.{swift,h}"
  s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "TTToast/TTToast/TTToast.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  s.frameworks   = 'UIKit', 'Foundation', 'QuartzCore'
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
