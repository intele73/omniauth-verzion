# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/verzion/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-verzion"
  spec.version       = Omniauth::Verzion::VERSION
  spec.authors       = ["Mahtab Alam"]
  spec.email         = ["storeapp73@gmail.com"]

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  # end

  spec.summary       = %q{A Verzion using access-token strategy for OmniAuth. Can be used for client side Verzion login.}
  spec.description   = %q{A Verzion using access-token strategy for OmniAuth. Can be used for client side Verzion login}
  spec.homepage      = "https://github.com/intele73/omniauth-verzion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'json', '~> 1.3'
  spec.add_dependency 'omniauth-oauth', '~> 1.1'

end
