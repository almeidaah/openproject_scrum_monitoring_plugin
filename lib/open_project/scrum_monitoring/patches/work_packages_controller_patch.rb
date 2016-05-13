require_dependency 'work_packages_controller'

module OpenProject::ScrumMonitoring::Patches::WorkPackagesControllerPatch
  def self.included(base)
      base.class_eval do
      extend ClassMethods
      include InstanceMethods
      before_filter :update_diff, :only => :show
      end
  end

  module InstanceMethods
  	def update_diff
  	  @work_package = WorkPackage.find(params[:id])
      @work_package.branches.each do |branch|
        branch.diff = branch.get_diff
        branch.save!
      end
    end
  end
end

WorkPackagesController.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagesControllerPatch)
