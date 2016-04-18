require_dependency 'projects_controller'

module OpenProject::ScrumMonitoring::Patches::ProjectsControllerPatch
    def self.included(base)
      base.class_eval do
        include InstanceMethods
      end
    end

    module InstanceMethods
      def save_project_configs

          @project.inspection_preparation_average = params[:project]['inspection_preparation_average']
          @project.inspection_duration_average = params[:project]['inspection_duration_average']
          @project.rework_average = params[:project]['rework_average']
          @project.productivity_average = params[:project]['productivity_average']

          @project.save!

          redirect_to :action => 'settings', :id => @project, :tab => 'info'

      end
    end

end

ProjectsController.send(:include, OpenProject::ScrumMonitoring::Patches::ProjectsControllerPatch)
