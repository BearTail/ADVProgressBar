Pod::Spec.new do |s|
  s.name     = 'ADVProgressBar'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'Progress Bar Design with Percentage values.'
  s.homepage = 'https://github.com/appdesignvault'
  s.author   = { 'appdesignvault' => 'appdesignvault' }
  s.source   = { :git => 'https://github.com/exilias/ADVProgressBar.git', :commit => 'aa995dcacfe2e1bc1f5b82f2b38a7a48d24ceee5' }
  s.platform = :ios  
  s.source_files = 'ADVProgressBar/Classes/*.{h,m}'
  s.resources = "ADVProgressBar/Resources/*.png"
  s.framework = 'UIKit', 'QuartzCore'

  s.requires_arc = true  
end
