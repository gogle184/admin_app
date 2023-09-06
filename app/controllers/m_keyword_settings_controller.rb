class MKeywordSettingsController < ApplicationController
  before_action :set_m_keyword_setting, only: [:show, :edit, :update, :destroy]

  def index
    @m_keyword_settings = MKeywordSetting.all
  end

  def show
  end

  def new
    @m_keyword_setting = MKeywordSetting.new
  end

  def create
    @m_keyword_setting = MKeywordSetting.new(m_keyword_setting_params)
    if @m_keyword_setting.save
      redirect_to m_keyword_settings_path, notice: 'MKeywordSetting was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @m_keyword_setting.update(m_keyword_setting_params)
      redirect_to m_keyword_settings_path, notice: 'MKeywordSetting was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @m_keyword_setting.destroy
    redirect_to m_keyword_settings_path, notice: 'MKeywordSetting was successfully destroyed.'
  end

  private

  def set_m_keyword_setting
    @m_keyword_setting = MKeywordSetting.find(params[:id])
  end

  def m_keyword_setting_params
    params.require(:m_keyword_setting).permit(:exclud_url, :exclud_tag)
  end
end
