Pod::Spec.new do |s|
  s.name     = 'ADVProgressBar'
  s.version  = '0.0.3'
  s.license  = 'MIT'
  s.summary  = 'Progress Bar Design with Percentage values.'
  s.homepage = 'https://github.com/appdesignvault'
  s.author   = { 'appdesignvault' => 'appdesignvault' }
  s.source   = { git: 'https://github.com/BearTail/ADVProgressBar.git' }
  s.platform = :ios
  s.source_files = 'ADVProgressBar/Classes/*.{h,m}'
  s.resources = 'ADVProgressBar/Resources/*.png'
  s.framework = 'UIKit', 'QuartzCore'

  s.requires_arc = true
end
