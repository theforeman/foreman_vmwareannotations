require File.expand_path('../lib/foreman_vmwareannotations/version', __FILE__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'foreman_vmwareannotations'
  s.version     = ForemanVmwareannotations::VERSION
  # rubocop:disable Date
  s.date        = Date.today.to_s
  # rubocop:enable Date
  s.authors     = ['Timo Goebel']
  s.email       = ['mail@timogoebel.name']
  s.homepage    = 'https://github.com/theforeman/foreman_vmwareannotations'
  s.licenses    = ['GPL-3']
  s.summary     = 'This plug-in copies the host comment to VMWare annotations in The Foreman.'
  s.description = 'This plug-in copies the host comment to VMWare annotations in The Foreman.'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'deface'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
