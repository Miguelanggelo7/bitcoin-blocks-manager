class RemoveHashIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :bitcoin_blocks, name: 'index_bitcoin_blocks_on_hash'
  end
end
