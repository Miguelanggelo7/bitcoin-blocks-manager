class CreateBitcoinBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :bitcoin_blocks do |t|
      t.string :hash, index: {unique: true}
      t.string :prev_block
      t.bigint :bits
      t.date :time
      t.integer :block_index

      t.timestamps
    end
  end
end
