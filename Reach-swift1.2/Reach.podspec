Pod::Spec.new do |spec|
  spec.name = 'Reach'
  spec.version = '1.0.0'
  spec.summary = 'A simple class to check for internet connection availability in Swift.'
  spec.homepage = 'https://github.com/Isuru-Nanayakkara/Reach'
  spec.license = 'MIT'
  spec.author = { 'Isuru Nanayakkara' => 'isuru.nan@gmail.com' }
  spec.source = { :git => 'https://github.com/Isuru-Nanayakkara/Reach.git', :tag => "#{spec.version}" }
  spec.source_files = 'Reach-swift1.2/Reach.swift'
  spec.requires_arc = true
  spec.frameworks = 'SystemConfiguration'
end