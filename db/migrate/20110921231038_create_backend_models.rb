class CreateBackendModels < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :name
      t.text :raw_input
      t.integer :user_id

      t.timestamps
    end

    create_table :nodes do |t|
      t.integer :graph_id
      t.string :name

      t.timestamps
    end

    create_table :fields do |t|
      t.integer :node_id
      t.string :name

      t.timestamps
    end

    create_table :connections do |t|
      t.integer :start_node_id
      t.integer :end_node_id
      t.string :start_type
      t.string :end_type
      t.string :line_type

      t.timestamps
    end
  end
end
