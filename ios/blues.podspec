#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_blue.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'blues'
  s.version          = '1.0.0+1'
  s.summary          = 'Bluetooth Low Energy plugin for Flutter.'
  s.description      = <<-DESC
  This plugin provides a cross-platform (Android, iOS) API to access platform specific Bluetooth Low Energy services.
                       DESC
  s.homepage         = 'https://github.com/Baseflow/blues'
  s.license          = { :file => '../LICENSE', :type => 'BSD'}
  s.author           = { 'Baseflow' => 'hello@baseflow.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/*.m', 'Headers/*.h', 'gen/*.pbobjc.{h,m}'
  s.public_header_files = 'Headers/BluesPlugin.h'
  s.dependency 'Flutter'
  s.dependency 'Protobuf', '~> 3.9', '>= 3.9.2'
  s.cocoapods_version = '>= 1.4.0'
  s.static_framework = false
  s.prefix_header_file = false

  s.platform = :ios, '10.0'
  s.framework = 'CoreBluetooth'

  s.subspec 'Protos' do |ss|
    ss.source_files = 'gen/*.pbobjc.{h,m}', 'Headers/FlutterBluePlugin.h'
    ss.public_header_files = 'Headers/FlutterBluePlugin.h', 'gen/*.pbobjc.h'
    ss.requires_arc = false
    ss.dependency 'Protobuf'
  end

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64', 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1', }

end
