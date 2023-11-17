class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description, :null => true

      t.timestamps
    end
  end
end
