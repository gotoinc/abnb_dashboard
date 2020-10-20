class CreateScannings < ActiveRecord::Migration[6.0]
  def change
    create_table :scannings do |t|
      t.string :title
      t.string :location
      t.string :abnb_id, uniq: true
      t.string :url
      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
