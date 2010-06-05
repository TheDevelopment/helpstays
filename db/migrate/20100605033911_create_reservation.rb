class CreateReservation < ActiveRecord::Migration
  def self.up
    create_table "reservations" do |t|
      t.column :start_date, :datetime
      t.column :end_date,   :datetime
      t.column :bed_id,     :integer
      t.column :organisation_id, :integer
    end
  end

  def self.down
    drop_table "reservations"
  end
end
