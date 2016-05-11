class CreateGroupContext < ActiveRecord::Migration
  def change
    create_table :group_contexts do |t|
      t.references :group
      t.references :context
    end
  end
end
