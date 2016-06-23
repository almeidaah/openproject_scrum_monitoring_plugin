class CreateCorrectionFactors < ActiveRecord::Migration
  def change
    create_table :correction_factors do |t|
      t.string :complexity
      t.references :type
      t.references :context
      t.float :value
    end
    add_index :correction_factors, :type_id
    add_index :correction_factors, :context_id
  end
end
