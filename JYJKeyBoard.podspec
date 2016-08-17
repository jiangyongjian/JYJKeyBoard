Pod::Spec.new do |s|
  s.name         = "JYJKeyBoard"
  s.version      = "0.0.1"
  s.ios.deployment_target = '6.0'
  s.summary      = "The keyBoard of ID card"
  s.homepage     = "https://github.com/jiangyongjian/JYJKeyBoard"
  s.license      = "MIT"
  s.author             = { "JYJ" => "542829817@qq.com" }
  s.source       = { :git => "https://github.com/jiangyongjian/JYJKeyBoard.git", :tag =>s.version }
  s.source_files  = "JYJKeyBoard/JYJKeyBoard/JYJKeyBoard"
  s.requires_arc = true
end
