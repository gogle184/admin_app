class MKeywordsController < ApplicationController
  before_action :set_m_keyword, only: [:show, :edit, :update, :destroy]

  def index
    @m_keywords = MKeyword.all
  end

  def show
  end

  def new
    @m_keyword = MKeyword.new
  end

  def create
    @m_keyword = MKeyword.new(m_keyword_params)
    if @m_keyword.save
      redirect_to m_keyword_path(@m_keyword), notice: 'MKeyword was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @m_keyword.update(m_keyword_params)
      redirect_to m_keyword_path(@m_keyword), notice: 'MKeyword was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @m_keyword.destroy
    redirect_to m_keywords_path, notice: 'MKeyword was successfully destroyed.'
  end

  private

  def set_m_keyword
    @m_keyword = MKeyword.find(params[:id])
  end

  def m_keyword_params
    params.require(:m_keyword).permit(:keyword, :word)
  end
end
