class GroupVersion < ActiveRecord::Base

  attr_accessible :version_id, :context_id, :id_sprint
  belongs_to :version
  belongs_to :context
end
