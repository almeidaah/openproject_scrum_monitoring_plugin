# OpenProject Scrum Monitoring Plugin

OpenProject ScrumMonitoring depends on OpenProject Backlogs Plugin. Add the following lines to your openproject_folder/Gemfile.plugins

gem "openproject-pdf_export", git: "https://github.com/finnlabs/openproject-pdf_export.git", :branch => "stable/4.2"
gem "openproject-backlogs", git: "https://github.com/finnlabs/openproject-backlogs.git", :branch => "stable/4.2"

bundle install

This plugin contains migrations. To migrate the database, run:

rake db:migrate
