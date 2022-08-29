class ChangeHashName < ActiveRecord::Migration[7.0]
  def change
    rename_column :bitcoin_blocks, :hash, :hash_id
    add_index :bitcoin_blocks, :hash_id, unique: true
  end
end
