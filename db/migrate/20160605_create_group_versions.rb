class CreateGroupVersions < ActiveRecord::Migration
  def change
    create_table :group_versions do |t|
      t.references :version
      t.references :context
    end
  end
end
