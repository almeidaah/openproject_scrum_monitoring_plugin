class AlterTableContexts < ActiveRecord::Migration
  def change
    add_column :contexts, :inspection_preparation_average, :integer
    add_column :contexts, :inspection_duration_average, :integer
    add_column :contexts, :rework_average, :integer
    Context.reset_column_information
  end
end