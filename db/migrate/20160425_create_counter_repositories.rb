class CreateCounterRepositories < ActiveRecord::Migration
  def change
    create_table :counter_repositories do |t|
      t.string :name
      t.references :project
      t.string :url
    end
  end
end
