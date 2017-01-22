#
# Be sure to run `pod lib lint SOA.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SOA'
  s.version          = '0.1.0'
  s.summary          = 'SOA is a lib created to interact with servers built with Coderockr\'s SOA server.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  SOA is a lib created to interact with servers built with [SOA Server](https://github.com/Coderockr/SOA).
                       DESC

  s.homepage         = 'https://github.com/espeiorin/SOA-iOS-SDK-Swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andre Espeiorin' => 'talk@andregustavo.me' }
  s.source           = { :git => 'https://github.com/espeiorin/SOA-iOS-SDK-Swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/espeiorin'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SOA\ iOS\ SDK/**/*.swift'

  # s.resource_bundles = {
  #   'SOA' => ['SOA/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
