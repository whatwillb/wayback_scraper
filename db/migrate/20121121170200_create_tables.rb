class CreateTables < ActiveRecord::Migration
  def change
    create_table :confessions do |t|
      t.integer     :post_id
      t.text        :body
    end
    add_index :confessions, [:post_id], :unique => true
  end
end