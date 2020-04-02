class WordsController < ApplicationController
  before_action :get_all_words, only: [:new, :create, :destroy_all]

  def random
    @random_word = Word.where('id>=?', rand(Word.first.id..Word.last.id)).first
  end
  
  
  def new
    @newword = Word.new
    get_all_words
  end
  
  def create  
    @newword = Word.new(word_params)
    get_all_words
    
    if @newword.save
      flash[:success] = '候補が正常に投稿されました'
      redirect_to action: 'new'
    else
      flash.now[:danger] = '候補が正常に投稿されませんでした'
      render :new
    end
  end
  
  def destroy
    @pastword = Word.find(params[:id])
    
    if @pastword.destroy
      flash[:success] ="候補が正常に削除されました"
      redirect_to root_url
    else
      flash[:danger] = "候補は正常に削除されませんでした"
      render :new
    end
  end
  
  def destroy_all
    
    
    if @allwords.destroy_all
      flash[:success] = "トップページに戻ります"
      redirect_to root_url
    else
      render :new
    end
  end
  
  
  #strong parameter
  private
  def word_params
    params.require(:word).permit(:content)
  end

  
  def get_all_words
    @allwords = Word.all
  end
end
