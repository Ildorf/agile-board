class CreateCardMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :card_marks do |t|
      t.references :user, null: false
      t.references :card, null: false

      t.timestamps
    end

    add_index :card_marks, [:user_id, :card_id], unique: true
  end
end
