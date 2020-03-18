# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'azure/loganalytics/datacollectorapi/version'

Gem::Specification.new do |spec|
  spec.name          = "azure-loganalytics-datacollector-api"
  spec.version       = Azure::Loganalytics::Datacollectorapi::VERSION
  spec.authors       = ["Yoichi Kawasaki"]
  spec.email         = ["yoichi.kawasaki@outlook.com"]
  spec.summary       = %q{Azure Log Analytics Data Collector API Ruby Client}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/yokawasa/azure-log-analytics-data-collector"
  spec.license       = "MIT"

    # Tests
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
