class CreateContextsTable < ActiveRecord::Migration
  def up
    create_table :contexts do |t|
      t.string :name
      t.text :description
      t.text :productivity_average
    end
  end
 
  def down
    drop_table :contexts
  end
end