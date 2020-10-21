class CreateAbnbDates < ActiveRecord::Migration[6.0]
  def change
    create_table :abnb_dates do |t|
      t.datetime :date
      t.boolean :available, default: nil
      t.boolean :available_checkin, default: nil
      t.boolean :bookable, default: nil
      t.references :scanning, null: false
      t.timestamps
    end
  end
end
