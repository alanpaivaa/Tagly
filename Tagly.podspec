Pod::Spec.new do |spec|
  spec.name         = "Tagly"
  spec.version      = "0.1.0"
  spec.summary      = "A Cocoapods library tag provides a tag cloud view for use in SwiftUI"

  spec.description  = <<-DESC
  This Cocoapods library allows you to easily display views in a tag cloud manner in your SwiftUI app.
  You just need to pass in your data and a ViewBuilder closure, like you'd with regular Lists.
                   DESC

  spec.homepage     = "https://github.com/astarkian/Tagly"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Alan Paiva" => "jpaiva.alan@gmail.com" }

  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/astarkian/Tagly.git", :tag => "#{spec.version}" }
  spec.source_files  = "Tagly/**/*.{h,m,swift}"
end
