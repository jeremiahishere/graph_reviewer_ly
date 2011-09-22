class CreateFrontendModels < ActiveRecord::Migration
  def change
    create_table :display_graphs do |t|
      t.integer :graph_id
      t.string :name
      t.string :public

      t.timestamps
    end

    create_table :display_nodes do |t|
      t.integer :display_graph_id
      t.integer :node_id
      t.integer :x_pos
      t.integer :y_pos

      t.timestamps
    end

    create_table :display_connections do |t|
      t.integer :display_graph_id
      t.integer :connection_id

      t.timestamps
    end
  end
end
