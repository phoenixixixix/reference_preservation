class GroupsController < ApplicationController
  before_action :set_group, only: %i[ edit update destroy ]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("groups", @group)}
        format.html { redirect_to groups_url, notice: "Group was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_url, notice: "Group was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: "Group was successfully destroyed."
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:title)
  end
end
