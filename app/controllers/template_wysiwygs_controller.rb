class TemplateWysiwygsController < ApplicationController
  before_action :set_template_wysiwyg, only: [:show, :edit, :update, :destroy]

  def index
    @template_wysiwygs = TemplateWysiwyg.all
  end

  def show
  end

  def new
    @template_wysiwyg = TemplateWysiwyg.new
  end

  def create
    @template_wysiwyg = TemplateWysiwyg.new(template_wysiwyg_params)
    if @template_wysiwyg.save
      redirect_to template_wysiwygs_path, notice: 'TemplateWysiwyg was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @template_wysiwyg.update(template_wysiwyg_params)
      redirect_to template_wysiwygs_path, notice: 'TemplateWysiwyg was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @template_wysiwyg.destroy
    redirect_to template_wysiwygs_path, notice: 'TemplateWysiwyg was successfully destroyed.'
  end

  private

  def set_template_wysiwyg
    @template_wysiwyg = TemplateWysiwyg.find(params[:id])
  end

  def template_wysiwyg_params
    params.require(:template_wysiwyg).permit(:title, :template)
  end
end
