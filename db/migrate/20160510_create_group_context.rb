class CreateGroupContext < ActiveRecord::Migration
  def change
    create_table :group_context do |t|
      t.references :group
      t.string :context
    end
  end
end
