class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :recipe, index: true
      t.references :chef, index: true
      t.boolean :liked

      t.timestamps
    end
  end
end
