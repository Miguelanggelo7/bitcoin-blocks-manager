class ChangeBigintToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :bitcoin_blocks, :bits, :integer

  end
end
