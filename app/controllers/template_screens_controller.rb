class TemplateScreensController < ApplicationController
  before_action :set_template_screen, only: [:show, :edit, :update, :destroy]

  def index
    @template_screens = TemplateScreen.all
  end

  def show
  end

  def new
    @template_screen = TemplateScreen.new
  end

  def create
    @template_screen = TemplateScreen.new(template_screen_params)
    if @template_screen.save
      redirect_to template_screens_path, notice: 'TemplateScreen was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @template_screen.update(template_screen_params)
      redirect_to template_screens_path, notice: 'TemplateScreen was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @template_screen.destroy
    redirect_to template_screens_path, notice: 'TemplateScreen was successfully destroyed.'
  end

  private

  def set_template_screen
    @template_screen = TemplateScreen.find(params[:id])
  end

  def template_screen_params
    params.require(:template_screen).permit(:title, :template)
  end
end
