class GroupsController < ApplicationController
  before_action :correct_user, :users, only: [:new]
  before_action :get_group, only: [:show, :edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)

    redirect_to user_path(current_user)
    
  end

  def show
    if has_access_to_group?
    else
      flash[:warning] = "You don't have access to the group."
      redirect_to user_path(current_user)
    end
  end

  def edit
    @users = User.all
  end

  def update
    if @group.update(member_params())
      flash[:success] = "Group updated successfully"
      redirect_to group_path(@group)
    else
      redirect_to edit_group_path(@group)
    end
    
  end
  
  private

  def get_group
    @group = Group.find(params[:id])
  end

  def group_params
    owner_id = current_user.id
    params[:group][:owner_id] = current_user.id.to_s
    params[:group][:user_ids] = params[:group][:user_ids].push(owner_id.to_s)
    params.require(:group).permit(:name,:owner_id, :user_ids => [])
  end

  def member_params
   member_param_arr = params.require(:group).permit(:name, user_ids: [])
   member_param_arr[:user_ids].shift
   member_param_arr
  end

  def users
    @users = User.all - [current_user]
  end

  def has_access_to_group?
    current_user.groups.include?(Group.find(params[:id]))
  end

end
