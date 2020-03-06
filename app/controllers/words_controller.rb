class WordsController < ApplicationController

  def random
    @random_word = Word.where('id>=?', rand(Word.first.id..Word.last.id)).first
  end
  
  
  def new
    @newword = Word.new
    @allwords = Word.all
  end
  
  def create  
    @newword = Word.new(word_params)
    @allwords = Word.all
    
    if @newword.save
      flash[:sucess] = '候補が正常に投稿されました'
      redirect_to action: 'new'
    else
      flash.now[:danger] = '候補が正常に投稿されませんでした'
      render :new
    end
  end
  
  def destroy
    @pastword = Word.find(params[:id])
    
    if @pastword.destroy
      flash.now[:danger] = '候補が削除されました。'
      redirect_to action: 'new'
    else 
      flash.now[:danger] = 'なにも削除されてません'
    end
  end
  
  
  #strong parameter
  private
  def word_params
    params.require(:word).permit(:content)
  end
end
