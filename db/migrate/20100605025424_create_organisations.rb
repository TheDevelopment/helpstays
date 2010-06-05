class CreateOrganisations < ActiveRecord::Migration
  def self.up
    create_table "organistations", :force => true do |t|
      t.column :user_id,              :integer
      t.column :name,                 :string
      t.column :type_id,              :integer
    end

    create_table "beds" do |t|
      t.column :house_id,             :integer
    end

    create_table "organistion_types" do |t|
      t.column :name,                 :string
    end

    create_table "beds_organisation_types" do |t|
      t.column :organisation_type_id, :integer
      t.column :bed_id,               :integer
    end
  end

  def self.down
    drop_table "beds_organisation_types"
    drop_table "organistion_types"
    drop_table "beds"
    drop_table "organistations"
  end
end
