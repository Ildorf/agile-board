class CreateCards < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE TYPE status  AS ENUM(
        'idea', 'to-do', 'in-progress', 'on-review', 'commited', 'done'
      )
    SQL

    create_table :cards do |t|
      t.references :board, null: false, index: true
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, null: false
      t.column :status, :status, null: false, default: :idea
      t.integer :doer_id

      t.timestamps
    end
  end

  def down
    drop_table :cards
    execute <<-SQL
      DROP TYPE status
    SQL
  end
end
