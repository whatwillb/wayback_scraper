class CreateConfessions < ActiveRecord::Migration
  def change
    create_table :confessions do |t|
      t.text     :body
      t.integer  :user_id
    end
  end
end
