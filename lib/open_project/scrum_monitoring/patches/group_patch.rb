require_dependency 'group'

module OpenProject::ScrumMonitoring::Patches::GroupPatch
  def self.included(base)
    base.class_eval do
      unloadable
      has_many :contexts, :dependent => :destroy
      include InstanceMethods
    end
  end

  module InstanceMethods
  end

end

Group.send(:include, OpenProject::ScrumMonitoring::Patches::GroupPatch)
