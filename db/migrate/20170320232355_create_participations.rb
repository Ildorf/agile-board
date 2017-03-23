class CreateParticipations < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE TYPE role AS ENUM('member', 'manager')
    SQL

    create_table :participations do |t|
      t.references :user, null: false, index: true
      t.references :board, null: false, index: true
      t.column :role, :role, null: false, default: 'member'

      t.timestamps
    end

    add_index :participations, [:user_id, :board_id], unique: true
  end

  def down
    drop_table :participations
    execute <<-SQL
      DROP TYPE role
    SQL
  end
end
