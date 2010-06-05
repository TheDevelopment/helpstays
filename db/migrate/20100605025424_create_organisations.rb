class CreateOrganisations < ActiveRecord::Migration
  def self.up
    create_table "organisations", :force => true do |t|
      t.column :user_id,              :integer
      t.column :name,                 :string
      t.column :organisation_type_id, :integer
      t.column :active,               :boolean, :default => false
    end

    create_table "beds" do |t|
      t.column :house_id,             :integer
    end

    create_table "organisation_types" do |t|
      t.column :name,                 :string
    end

    create_table "beds_for_organisations" do |t|
      t.column :organisation_type_id, :integer
      t.column :bed_id,               :integer
    end
  end

  def self.down
    drop_table "beds_organisation_types"

    drop_table "organisation_types"

    drop_table "beds"

    drop_table "organisations"
  end
end
