Pod::Spec.new do |s|
  s.name = 'JXAutoEncoder'
  s.version = '1.0.2'
  s.license = 'MIT'
  s.summary = 'Encode model by Swift reflect'
  s.homepage = 'https://github.com/DeveloperJx/JXAutoEncoder'
  s.social_media_url = 'http://developerjx.github.io'
  s.authors = { 'Jason.Jiang' => 'jiangx.jason@gmail.com' }
  s.source = { :git => 'https://github.com/DeveloperJx/JXAutoEncoder.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/*.swift'
  s.requires_arc = true
  s.frameworks = "UIKit"
end
