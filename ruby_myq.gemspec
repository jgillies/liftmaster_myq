# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_myq/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_myq'
  spec.version       = RubyMyq::VERSION
  spec.authors       = ['Jesse Gillies']
  spec.email         = ['jessegillies@gmail.com']
  spec.description   = 'Unofficial controller for Chamberlain/Liftmaster MyQ'
  spec.summary       = 'Gem to access and control the Chamberlain/Liftmaster MyQ garage door system.'
  spec.homepage      = 'http://github.com/jgillies/ruby_myq'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.17.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
end
