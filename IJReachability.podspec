Pod::Spec.new do |spec|
  spec.name = 'IJReachability'
  spec.version = '0.1.0'
  spec.summary = 'A simple class to check for internet connection availability in Swift.'
  spec.homepage = 'https://github.com/Isuru-Nanayakkara/IJReachability'
  spec.license = 'MIT'
  spec.author = { 'Isuru Nanayakkara' => 'isuru.nan@gmail.com' }
  spec.source = { :git => 'https://github.com/Isuru-Nanayakkara/IJReachability.git', :tag => "#{spec.version}" }
  spec.source_files = 'IJReachability/IJReachability.swift'
  spec.requires_arc = true
  spec.frameworks = 'SystemConfiguration'
end
