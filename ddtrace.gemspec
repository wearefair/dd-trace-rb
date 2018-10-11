# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ddtrace/version'

Gem::Specification.new do |spec|
  spec.name                  = 'fair-ddtrace'
  spec.version               = "#{Datadog::VERSION::STRING}#{ENV['VERSION_SUFFIX']}"
  spec.required_ruby_version = '>= 1.9.1'
  spec.authors               = ['Fair']
  spec.email                 = ['catherinec@fair.com']

  spec.summary     = 'Fair fork of Datadog tracing code for your Ruby applications'
  spec.description = <<-EOS
ddtrace is Datadog’s tracing client for Ruby. It is used to trace requests
as they flow across web servers, databases and microservices so that developers
have great visiblity into bottlenecks and troublesome requests.
Find the original version at: https://github.com/DataDog/dd-trace-rb
EOS

  spec.homepage = 'https://github.com/wearefair/dd-trace-rb'
  spec.license  = 'BSD-3-Clause'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'msgpack'

  spec.add_development_dependency 'rake', '~> 10.5'
  spec.add_development_dependency('rubocop', '~> 0.47') if RUBY_VERSION >= '2.1.0'
  spec.add_development_dependency 'minitest', '= 5.10.1'
  spec.add_development_dependency 'appraisal', '~> 2.1'
  spec.add_development_dependency 'yard', '~> 0.9'
end
