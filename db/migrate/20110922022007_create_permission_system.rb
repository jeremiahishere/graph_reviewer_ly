class CreatePermissionSystem < ActiveRecord::Migration
  def change
    create_table :role_assignments do |t|
      t.integer :role_id
      t.integer :user_id

      t.timestamps
    end

    create_table :display_graph_tokens do |t|
      t.integer :display_graph_id
      t.string :token
      t.string :permission_level
      t.datetime :expiration_date

      t.timestamps
    end

    add_index :display_graph_tokens, :token, :unique => true

    create_table :display_graph_permissions do |t|
      t.integer :display_graph_id
      t.integer :user_id
      t.string :permission_level

      t.timestamps
    end
  end
end
