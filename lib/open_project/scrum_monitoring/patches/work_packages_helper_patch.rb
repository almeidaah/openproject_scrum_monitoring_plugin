require_dependency 'work_packages_helper'

module OpenProject::ScrumMonitoring::Patches::WorkPackagesHelperPatch
  def self.included(base)
    base.module_eval do
      def show_scrummonitoring_columns(work_package)
      	puts work_package
      	custom_field_attributes = work_package_show_custom_fields(work_package)
      	puts custom_field_attributes

      end

     end
  end
end

WorkPackagesHelper.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagesHelperPatch)
