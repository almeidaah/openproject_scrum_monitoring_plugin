class AddColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :inspection_preparation_average, :integer
    add_column :projects, :inspection_duration_average, :integer
    add_column :projects, :rework_average, :integer
    add_column :projects, :productivity_average, :integer
    Project.reset_column_information
  end
end
