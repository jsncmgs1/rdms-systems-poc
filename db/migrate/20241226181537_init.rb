class Init < ActiveRecord::Migration[8.0]
  def change
    create_table :systems do |t|
      t.string :name
    end

    create_table :nodes do |t|
      t.string :name
      t.string :component_type
      t.uuid :heroku_id
      t.boolean :gateway
      t.json :metadata
      t.references :system
      t.timestamps
    end

    create_table :edges do |t|
      t.references :start_node
      t.references :end_node
      t.json :metadata
      t.timestamps
    end
  end
end
