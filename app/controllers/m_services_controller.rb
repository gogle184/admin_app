class MServicesController < ApplicationController
  before_action :set_m_service, only: [:show, :edit, :update, :destroy]

  def index
    @m_services = MService.all
  end

  def show
  end

  def new
    @m_service = MService.new
  end

  def create
    @m_service = MService.new(m_service_params)
    if @m_service.save
      redirect_to m_service_path(@m_service), notice: 'MService was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @m_service.update(m_service_params)
      redirect_to m_services_path, notice: 'MService was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @m_service.destroy
    redirect_to m_services_path, notice: 'MService was successfully destroyed.'
  end

  private

  def set_m_service
    @m_service = MService.find(params[:id])
  end

  def m_service_params
    params.require(:m_service).permit(:is_royalty, :is_browsing_history, :is_japan_concierge, :is_ai_concierge, :is_questionnaire, :is_keyword)
  end
end
