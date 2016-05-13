require_dependency 'work_package'

module OpenProject::ScrumMonitoring::Patches::WorkPackagePatch
  def self.included(base)
      base.class_eval do
       include InstanceMethods
       has_many :branches
      end
  end

  module InstanceMethods
  end
end

WorkPackage.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagePatch)
