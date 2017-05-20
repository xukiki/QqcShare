Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcShare"
  s.version      = "1.0.61"
  s.summary      = "QqcShare"
  s.homepage     = "https://github.com/xukiki/QqcShare"
  s.source       = { :git => "https://github.com/xukiki/QqcShare.git", :tag => "#{s.version}" }
  
  s.source_files  = ["QqcShare/*.{h,m}"]
  s.resource = 'QqcShare/QqcShare.bundle'

  s.subspec 'AuthLoginProcess' do |sp|
    sp.dependency '1.0.61/QqcShare'
    sp.source_files = 'QqcShare/AuthLoginProcess/*.{h,m}'
  end

  s.subspec 'QRCodeGenerator' do |sp|
    sp.source_files = 'QqcShare/QRCodeGenerator/*.{h,m,c}'
  end

  s.subspec 'ShareProcess' do |sp|
    sp.dependency '1.0.61/QqcShare'
    sp.source_files = 'QqcShare/ShareProcess/*.{h,m}'
  end

  s.subspec 'Views' do |sp|
    sp.source_files = 'QqcShare/Views/*.{h,m}'
    sp.dependency '1.0.61/QqcShare'
    sp.subspec 'Panel' do |ssp|
      ssp.source_files = 'QqcShare/Views/Panel/*.{h,m}'
    end
  end

  s.dependency 'ShareSDK3'
  s.dependency 'MOBFoundation'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/QQ'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
  s.dependency 'ShareSDK3/ShareSDKPlatforms/WeChat'
  s.dependency 'QqcProgressHUD'
  s.dependency 'QqcUtilityUI'
  
end
