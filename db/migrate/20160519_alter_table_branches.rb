class AlterTableBranches < ActiveRecord::Migration
  def change
    add_column :branches, :version_id, :integer
    remove_column :branches, :work_package_id

    Context.reset_column_information
  end
end