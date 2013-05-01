class CreateAccountHeaders < ActiveRecord::Migration
  def self.up
    create_table :account_headers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :account_headers
  end
end
