class LinksController < ApplicationController
  before_action :set_link, only: %i[ edit update destroy ]

  def index
    @group = Group.find_by(title: params[:group])
    @links = Link.by_group(@group)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path, notice: "Link was successfully crated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to links_path, notice: "Link was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    redirect_to links_path, notice: "Link was successfully destroyed"
  end

  private
  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url, :group_id)
  end
end
