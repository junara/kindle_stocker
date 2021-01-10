# frozen_string_literal: true

require_relative 'lib/kindle_stocker/version'

Gem::Specification.new do |spec|
  spec.name          = 'kindle_stocker'
  spec.version       = KindleStocker::VERSION
  spec.authors       = ['jungo ARAKI']
  spec.email         = ['jung5araki@gmail.com']

  spec.summary       = 'Extract Kindle highlights.'
  spec.description   = 'Stock your kindle history.'
  spec.homepage      = 'https://github.com/junara'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/junara'
  spec.metadata['changelog_uri'] = 'https://github.com/junara'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'ferrum', '~> 0.9'
end
