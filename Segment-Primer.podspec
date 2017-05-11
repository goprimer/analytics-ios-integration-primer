Pod::Spec.new do |s|
  s.name              = "Segment-Primer"
  s.version           = "2.0.2"
  s.summary           = "Primer Integration for Segment's analytics-ios library."

  s.description       = <<-DESC
                        Analytics for iOS provides a single API that lets you
                        integrate with over 100s of tools.

                        This is the Primer integration for the iOS library.
                        DESC

  s.homepage          = "https://goprimer.com/"
  s.documentation_url = "http://docs.goprimer.com/"
  s.license           = { :type => "MIT", :file => "LICENSE.md" }
  s.author            = { "Primer" => "success@goprimer.com" }
  s.source            = { :git => "https://github.com/goprimer/analytics-ios-integration-primer.git", :tag => s.version.to_s }
  s.social_media_url  = "https://twitter.com/GoPrimer"

  s.platform          = :ios, "8.0"
  s.requires_arc      = true

  s.source_files      = "Pod/Classes/**/*"

  s.dependency "Analytics", "~> 3.6"
  s.dependency "Primer", "~> 3.3"
end