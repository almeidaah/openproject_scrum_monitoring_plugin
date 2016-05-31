require_dependency 'work_packages_helper'

module OpenProject::ScrumMonitoring::Patches::WorkPackagesHelperPatch
  def self.included(base)
    base.module_eval do
      def show_scrummonitoring_columns(work_package)
      	    custom_field_attributes = work_package_show_custom_fields(work_package)
      	    member = Member.where(:project_id => work_package.project_id, :user_id => work_package.assigned_to_id)
      	    puts member
      	    #porcentagem_linhas = 
      end

     end
  end
end

WorkPackagesHelper.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagesHelperPatch)
