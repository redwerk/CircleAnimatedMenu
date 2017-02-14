Pod::Spec.new do |s|
  s.name             = 'CircleAnimatedMenu'
  s.version          = '1.0.3'
  s.summary          = 'Customizable library "CircleAnimatedMenu"'

  s.description      = <<-DESC
"CircleAnimatedMenu" - convenient customizable menu which can be used to show and select different categories. Selection can be done by sliding around the center of menu or just by tapping at section. 
                       DESC

  s.homepage         = 'https://github.com/redwerk/CircleAnimatedMenu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Redwerk' => 'honcharenko13@redwerk.com' }
  s.source           = { :git => 'https://github.com/redwerk/CircleAnimatedMenu.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'CircleAnimatedMenu/Classes/**/*.swift'

end
