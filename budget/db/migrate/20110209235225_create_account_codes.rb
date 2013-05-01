class CreateAccountCodes < ActiveRecord::Migration
  def self.up
    create_table :account_codes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :account_codes
  end
end
