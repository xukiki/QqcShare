Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcShare"
  s.version      = "1.0.46"
  s.summary      = "QqcShare"
  s.homepage     = "https://github.com/xukiki/QqcShare"
  s.source       = { :git => "https://github.com/xukiki/QqcShare.git", :tag => "#{s.version}" }
  
  s.source_files  = ["QqcShare/*.{h,m}"]
  s.resource = 'QqcShare/QqcShare.bundle'

  s.subspec 'AuthLoginProcess_s' do |sp|
    sp.dependency = 'QqcShare'
    sp.source_files = 'QqcShare/AuthLoginProcess/*.{h,m}'
  end

  s.subspec 'QRCodeGenerator_s' do |sp|
    sp.source_files = 'QqcShare/QRCodeGenerator/*.{h,m,c}'
  end

  s.subspec 'ShareProcess_s' do |sp|
    sp.source_files = 'QqcShare/ShareProcess/*.{h,m}'
  end

  s.subspec 'Views_s' do |sp|
    sp.source_files = 'QqcShare/Views/*.{h,m}'
    sp.subspec 'Panel' do |ssp|
      ssp.source_files = 'QqcShare/Views/Panel/*.{h,m}'
  end

  s.dependency 'QqcShare/Views_s'

  s.dependency 'ShareSDK3'
  s.dependency 'MOBFoundation'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/QQ'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/WeChat'
  s.dependency 'QqcProgressHUD'
  s.dependency 'QqcUtilityUI'
  
end
