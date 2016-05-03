require_dependency 'work_packages_controller'

module OpenProject::ScrumMonitoring::Patches::WorkPackagePatch
  def self.included(base)
      base.class_eval do
 #       include InstanceMethods
 #       extend ClassMethods
      end
  end

#  module InstanceMethods
#    def update
#      puts '==================PARAMETROS_INSTANCEMETHODS====================='
#    end
#  end
#  module ClassMethods
#    def update
#      puts '==================PARAMETROS_CLASSMETHODS====================='
#    end
#  end
end

WorkPackage.send(:include, OpenProject::ScrumMonitoring::Patches::WorkPackagePatch)
