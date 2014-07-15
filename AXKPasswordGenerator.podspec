Pod::Spec.new do |s|
  s.name          = 'AXKPasswordGenerator'
  s.version       = '1.0.0'
  s.license       = { :type => 'MIT' }
  s.homepage      = 'https://github.com/akolov/AXKPasswordGenerator'
  s.authors       = { 'Alexander Kolov' => 'me@alexkolov.com' }
  s.summary       = 'A simple password generator based on GPW by Tom Van Vleck'

# Source Info
  s.platform      = :ios, '7.0'
  s.source        = { :git => 'https://github.com/akolov/AXKPasswordGenerator.git', :tag => "#{s.version}" }

  s.requires_arc = true
  s.source_files  = 'AXKPasswordGenerator/Classes/*.{h,m}'
end
