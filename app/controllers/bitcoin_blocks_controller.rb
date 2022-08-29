class BitcoinBlocksController < ApplicationController
  def index
    # aqui se mostraran todos los actuales creados
    @pagy, @blocks = pagy(BitcoinBlock.all.order(created_at: :desc))
  end

  def create
    # metodo para almacenar el bloque en la bbdd
    @block = BitcoinBlock.new(block_params)
    respond_to do |format|
      @block.save!
      format.turbo_stream {render partial: 'bitcoin_blocks/change_block', locals: {block: @block, creating: true, notice: 'Block created successfully!'}}
      
    end
  end

  # 

  def destroy
    # metodo para borrar el bloque de la bbdd
    @block = BitcoinBlock.find(params[:id])
    @block.destroy!

    respond_to do |format|
      format.turbo_stream {render partial: 'bitcoin_blocks/change_block', locals: {block: @block, creating: false, notice: 'Block deleted successfully!'}}
    end
  end

  private 
    def block_params
      params.require(:bitcoin_block).permit(:hash_id, :prev_block, :bits, :time, :block_index )
    end

end
