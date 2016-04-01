$:.unshift File.expand_path '../lib', __FILE__
require 'cant_even/version'

Gem::Specification.new do |s|
  s.name       = 'cant_even'
  s.version    = CantEven::VERSION
  s.author     = 'D.E. Akers'
  s.email      = '0x0dea@gmail.com'

  s.summary    = 'foo'
  s.homepage   = 'https://github.com/0x0dea/cant_even'
  s.license    = 'WTFPL'

  s.files      = `git ls-files`.split
  s.extensions = %w[Rakefile]
end
