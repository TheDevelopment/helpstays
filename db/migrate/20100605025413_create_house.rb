class CreateHouse < ActiveRecord::Migration
  def self.up
    create_table "houses", :force => true do |t|
      t.column :user_id,                   :integer
      t.column :address_1,                 :string
      t.column :address_2,                 :string
      t.column :country,                   :string
      t.column :state,                     :string
      t.column :post_code,                 :string
      t.column :suburb,                    :string
      t.column :lat,                       :float
      t.column :long,                      :float
    end
  end

  def self.down
    drop_table "houses"
  end
end
