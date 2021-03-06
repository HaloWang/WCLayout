Pod::Spec.new do |s|
  s.name         = "WCLayout"
  s.version      = "0.0.8"
  s.summary      = "WCLayout is a easier way to set UIView layout use frame"
  s.homepage     = "https://github.com/HaloWang/WCLayout"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author		 = { "王策" => "634692517@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/HaloWang/WCLayout.git", :tag => "0.0.8" }
  s.source_files  = "WCLayout/*.{swift}"
  s.frameworks = "UIKit"
  s.requires_arc = true
end
