class CorrectionFactor < ActiveRecord::Base
  
  attr_accessible :complexity, :context, :type, :value
  
  belongs_to :context
  belongs_to :type
  
  validates :complexity, inclusion: { in: %w(Low Medium High) }
end
