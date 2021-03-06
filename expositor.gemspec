Gem::Specification.new do |s|
  s.name        = 'expositor'
  s.version     = '0.9.1'
  s.date        = '2016-03-02'
  s.summary     = "Expositor will exposit!"
  s.description = "Expose all object methods to it class"
  s.authors     = ["Volodya Sveredyuk"]
  s.email       = 'sveredyuk@gmail.com'
  s.files       = ["lib/expositor.rb"]
  s.homepage    = 'https://github.com/sveredyuk/expositor'
  s.license     = 'MIT'

  # Dev gems
  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
end
