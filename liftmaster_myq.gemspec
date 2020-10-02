# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liftmaster_myq/version'

Gem::Specification.new do |spec|
  spec.name          = 'liftmaster_myq'
  spec.version       = LiftmasterMyq::VERSION
  spec.authors       = ['David Pfeffer']
  spec.email         = ['david@pfeffer.org']
  spec.description   = 'Unofficial Liftmaster MyQ Controller'
  spec.summary       = 'Gem to access and control the Liftmaster MyQ garage door system.'
  spec.homepage      = 'http://github.com/pfeffed/liftmaster_myq'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.12.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
