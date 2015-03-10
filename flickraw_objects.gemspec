# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flickraw_objects/version'

Gem::Specification.new do |spec|
  spec.name          = "flickraw_objects"
  spec.version       = FlickrawObjects::VERSION
  spec.authors       = ["Chris Field"]
  spec.email         = ["chris@christopherfield.co.uk"]
  spec.summary       = %q{A slim, customisable object-oriented Flickr api that uses flickraw to do all the communication.}
  spec.description   = %q{Use this gem as a simple way to use Flickraw but with an object-orientated "data model".
    Classes for Person, Photoset and Photos are included. I anticipate 
    users of this Gem will map other data they need. It's easy to do.}
  spec.homepage      = "https://github.com/chrisfield/flickraw_objects"
  spec.license       = "MIT"

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.files         = Dir["README.md", "LICENSE", "lib/**/*"]

  spec.add_dependency "flickraw", "~> 0.9"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
