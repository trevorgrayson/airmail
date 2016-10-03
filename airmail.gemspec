Gem::Specification.new do |s|
  s.name        = 'airmail'
  s.version     = '1.0.0'
  s.licenses    = ['MIT']
  s.summary     = "Incoming Email Router"
  s.description = "Incoming Email Router"
  s.authors     = ["Trevor Grayson"]
  s.email       = 'trevor@trevorgrayson.com'
  s.files = Dir['Rakefile', '{bin,lib,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  s.homepage    = 'https://rubygems.org/gems/airmail'


  s.add_dependency('activesupport')
  s.add_dependency('actionmailer')
  s.add_development_dependency('rspec', [">= 2.0.0"])
end
