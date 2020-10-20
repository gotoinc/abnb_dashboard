class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :login, uniq: true
      t.string :api_key, null: false, uniq: true
      t.timestamps
    end
  end
end
