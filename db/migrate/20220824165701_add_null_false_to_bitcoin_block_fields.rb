class AddNullFalseToBitcoinBlockFields < ActiveRecord::Migration[7.0]
  def change
    # only hash, prev_hash, time and bits are required
    change_column_null :bitcoin_blocks, :hash, false
    change_column_null :bitcoin_blocks, :prev_block, false
    change_column_null :bitcoin_blocks, :bits, false
    change_column_null :bitcoin_blocks, :time, false
  end
end
