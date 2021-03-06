Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcShare"
  s.version      = "1.0.90"
  s.summary      = "QqcShare"
  s.homepage     = "https://github.com/xukiki/QqcShare"
  s.source       = { :git => "https://github.com/xukiki/QqcShare.git", :tag => "#{s.version}" }
  
  s.resource = 'QqcShare/QqcShare.bundle'

  s.subspec 'Share' do |sp|
    sp.dependency 'QqcShare/QRCodeGenerator'
    sp.source_files = 'QqcShare/Share/*.{h,m}'
  end

  s.subspec 'QRCodeGenerator' do |sp|
    sp.source_files = 'QqcShare/QRCodeGenerator/*.{h,m,c}'
  end

  s.dependency 'ShareSDK3'
  s.dependency 'MOBFoundation'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/QQ'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/WeChat'
  s.dependency 'QqcProgressHUD'
  s.dependency 'QqcUtilityUI'
  
end
