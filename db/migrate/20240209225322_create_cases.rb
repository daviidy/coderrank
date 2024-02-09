class CreateCases < ActiveRecord::Migration[7.1]
  def change
    create_table :cases do |t|
      t.string :input
      t.string :output
      t.references :challenge, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
