Rails.application.routes.draw do
  post '/', to: "bitcoin_blocks#create", as: :new_bitcoin_block
  delete '/:id', to: "bitcoin_blocks#destroy", as: :destroy_bitcoin_block
  
  root to: "bitcoin_blocks#index"
end
