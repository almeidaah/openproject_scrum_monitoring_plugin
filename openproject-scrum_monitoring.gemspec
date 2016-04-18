# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

require 'open_project/scrum_monitoring/version'
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openproject-scrum_monitoring"
  s.version     = OpenProject::ScrumMonitoring::VERSION
  s.authors     = "Fernando Almeida"
  s.email       = "almeidascvn@gmail.com"
  s.homepage    = "https://www.openproject.org/projects/scrum-monitoring"  # TODO check this URL
  s.summary     = 'OpenProject Scrum Monitoring'
  s.description = ''
  s.license     = '' # e.g. "MIT" or "GPLv3"

  s.files = Dir["{app,config,db,lib}/**/*"] + %w(CHANGELOG.md README.md)

  s.add_dependency "rails", "~> 3.2.14"
end
