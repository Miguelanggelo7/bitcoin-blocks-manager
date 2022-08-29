class ChangeTimeFieldFromTimestampToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :bitcoin_blocks, :time
    add_column :bitcoin_blocks, :time, :integer
    change_column_null :bitcoin_blocks, :time, false
  end
end
