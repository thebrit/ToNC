class CreatePoDetails < ActiveRecord::Migration
  def self.up
    create_table :po_details do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :po_details
  end
end
