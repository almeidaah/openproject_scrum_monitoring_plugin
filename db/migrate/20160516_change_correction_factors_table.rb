class ChangeCorrectionFactorsTable < ActiveRecord::Migration
  def change
    change_table :correction_factors do |t|
    t.change :type_id, :string
    end
  end
end
