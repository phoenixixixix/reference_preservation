class LinksController < ApplicationController
  before_action :set_link, only: %i[ edit update destroy ]
  before_action :groups_for_select, only: %i[ new edit ]

  def index
    @links = Link.all
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

  def groups_for_select
    @groups_for_select = Group.pluck(:title, :id)
  end
end
