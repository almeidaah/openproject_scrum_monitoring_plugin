require_dependency 'work_packages_controller'

module OpenProject::ScrumMonitoring::Patches::WorkPackagesControllerPatch
  def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
  end

  module InstanceMethods
  end
end

WorkPackagesController.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagesControllerPatch)
