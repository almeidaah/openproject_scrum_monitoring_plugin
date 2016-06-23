class ChangeContextsTable < ActiveRecord::Migration
  def change
    change_table :contexts do |t|
    t.change :inspection_preparation_average, :string
    t.change :inspection_duration_average, :string
    t.change :rework_average, :string
    end
  end
end