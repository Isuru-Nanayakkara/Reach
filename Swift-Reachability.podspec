Pod::Spec.new do |spec|
  spec.name = 'Swift-Reachability'
  spec.version = '0.1.0'
  spec.summary = 'A simple class to check for internet connection availability in Swift.'
  spec.homepage = 'https://github.com/Isuru-Nanayakkara/Swift-Reachability'
  spec.license = 'MIT'
  spec.author = { 'Isuru Nanayakkara' => 'isuru.nan@gmail.com' }
  spec.source = { :git => 'https://github.com/Isuru-Nanayakkara/Swift-Reachability.git', :tag => "#{spec.version}" }
  spec.source_files = 'Swift-Reachability/Reachability.swift'
  spec.requires_arc = true
  spec.frameworks = 'SystemConfiguration'
end
