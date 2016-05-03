class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.references :counter_repository
      t.references :work_package
      t.integer :diff
    end
    add_index :branches, :work_package_id
  end
end
