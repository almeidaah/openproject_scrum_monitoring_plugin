class CorrectionFactorController < ApplicationController

  def destroy(correction_factors)
      @correction_factors = correction_factors
      @correction_factors.destroy
  end
   
end
