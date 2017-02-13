Pod::Spec.new do |s|
  s.name             = 'CircleAnimatedMenu'
  s.version          = '0.1.0'
  s.summary          = 'Customizable library "CircleAnimatedMenu"'

  s.description      = <<-DESC
"CircleAnimatedMenu" - convenient customizable menu which can be used to show and select different categories. Selection can be done by sliding around the center of menu or just by tapping at section. 
                       DESC

  s.homepage         = 'https://github.com/redwerk/CircleAnimatedMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexandr Honcharenko' => 'honcharenko13@redwerk.com' }
  s.source           = { :git => 'https://github.com/redwerk/CircleAnimatedMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CircleAnimatedMenu/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'CircleAnimatedMenu' => ['CircleAnimatedMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
end
