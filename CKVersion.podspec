#
# Be sure to run `pod lib lint CKVersion.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CKVersion'
  s.version          = '0.2.0'
  s.summary          = 'Simple comparable version type'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library provides a version object for semantic versioning which is formatted with "MAJOR.MINOR.PATCH".
It supports only numbers and dots(e.g. "1.0.0"). Not supporting release state like "-beta" suffix.  
                       DESC

  s.homepage         = 'https://github.com/chungchung1315/CKVersion'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcel Lee' => 'chungchung1315@gmail.com' }
  s.source           = { :git => 'https://github.com/chungchung1315/CKVersion.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'CKVersion/Classes/**/*'  
  s.swift_version = '5.0'
  # s.resource_bundles = {
  #   'CKVersion' => ['CKVersion/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
