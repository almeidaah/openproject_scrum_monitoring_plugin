require_dependency 'group'

module OpenProject::ScrumMonitoring::Patches::GroupPatch
  def self.included(base)
    base.class_eval do
    end
  end

end

Group.send(:include, OpenProject::ScrumMonitoring::Patches::GroupPatch)
