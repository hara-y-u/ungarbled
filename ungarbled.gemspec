$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'ungarbled/version'

Gem::Specification.new do |s|
  s.name        = 'ungarbled'
  s.version     = Ungarbled::VERSION
  s.authors     = ['yukihiro hara']
  s.email       = ['yukihr@gmail.com']
  s.homepage    = 'https://github.com/yukihr/ungarbled'
  s.summary     = 'Ungarbled filenames for downloads.'
  s.description = 'Ungarbled filenames for downloads with rails integration.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*',
                'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'browser', '~> 0.6'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'bundler', '>= 0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rails', '~> 4'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'pry-meta'
  s.add_development_dependency 'minitest-rails-capybara'
end
