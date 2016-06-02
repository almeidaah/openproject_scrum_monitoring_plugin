class Context < ActiveRecord::Base
  extend Pagination::Model

  has_many :correction_factors

  def update_correction_factors(correction_factors, context_id)  
      correction_factors.each do |c|
        unless c[:value].nil?
          correction_factor = CorrectionFactor.where(:type_id => c[:type_id], :complexity => c[:complexity], :context_id => context_id).first
          if correction_factor.nil?
            correction_factor = CorrectionFactor.new
            correction_factor.context = self
            correction_factor.value = c[:value]
            correction_factor.type_id = c[:type_id]        
            correction_factor.complexity = c[:complexity]
            correction_factor.save
          else
            correction_factor.value = c[:value]
            correction_factor.save!
          end
        end
      end
    end

end
