class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references :board, null: false, index: true
      t.text :content, null: false
      t.string :status, null: false, default: :idea

      t.timestamps
    end
  end
end
