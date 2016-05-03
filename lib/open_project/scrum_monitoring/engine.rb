# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'open_project/plugins'

module OpenProject::ScrumMonitoring
  class Engine < ::Rails::Engine
    engine_name :openproject_scrum_monitoring

    def self.settings
    {
    }
    end

    include OpenProject::Plugins::ActsAsOpEngine

    register 'openproject-scrum_monitoring',
           :author_url => 'http://fernando.almeida',
           :requires_openproject => '>= 3.0.0pre13',
           :settings => settings do
          Redmine::MenuManager.map :admin_menu do |menu|
              menu.push :contexts,
                        { controller: '/contexts' },
                        caption: "Contextos",
                        html: { class: 'statuses icon2 icon-flag' }
          end
          #Redmine::MenuManager.map :admin_menu do |menu|
          #      menu.push :counter_repositories,
          #              { controller: '/counter_repositories'},
          #              caption: "Repositórios",
          #              html: { class: 'icon2 icon-settings2' }
          #    end
           end

    #:ProjectsController Removido
    patches [:Group, :WorkPackage]
    end 
end
