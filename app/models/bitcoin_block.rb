class BitcoinBlock < ApplicationRecord
  validates :hash, presence: true
  validates :prev_block, presence: true
  validates :time, presence: true
  validates :bits, presence: true
end
