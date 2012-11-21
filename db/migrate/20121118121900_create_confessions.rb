class CreateConfessions < ActiveRecord::Migration
  def change
    create_table :confessions do |t|
      t.text     :body
      t.integer  :post_id
    end
    add_index :confessions, [:post_id], :unique => true
  end
end
