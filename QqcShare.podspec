Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcShare"
  s.version      = "1.0.18"
  s.summary      = "QqcShare"
  s.homepage     = "https://github.com/xukiki/QqcShare"
  s.source       = { :git => "https://github.com/xukiki/QqcShare.git", :tag => "#{s.version}" }
  
  s.source_files  = ["QqcShare/*.{h,m}"]
  s.resource = 'QqcShare/QqcShare.bundle'

  s.subspec 'AuthLoginProcess' do |sp|
    sp.source_files = 'QqcShare/AuthLoginProcess/QqcAuthLoginProcess.{h,m}'
  end

  s.dependency 'ShareSDK3',:git => ‘https://git.oschina.net/MobClub/ShareSDK-for-iOS.git'
  s.dependency 'MOBFoundation’
  s.dependency "QqcProgressHUD"
  s.dependency "QqcUtilityUI"
  
end
