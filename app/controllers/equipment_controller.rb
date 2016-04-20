class EquipmentController < ApplicationController
  def update
    session[:return_to] = request.referer

    @equipment_params = params[:equipment]
    @equipment = Equipment.find @equipment_params[:equipment_id]

    @equipment.name = @equipment_params[:name]
    @equipment.condition = @equipment_params[:condition]

    if @equipment_params[:user_id]
      @equipment.user_id = nil
    end

    unless @equipment.save
      flash[:error] = @equipment.errors.full_messages.to_sentence
    end

    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    @equipment = Equipment.find params[:id]
    if @equipment.team.leaders.include? current_user
      @equipment.delete
    else
      flash[:error] = "Only team leaders can do that!"
    end
    redirect_to session.delete(:return_to)
  end

  def create
    session[:return_to] = request.referer
    @t = Team.find params[:equipment][:team_id]
    if @t.leaders.include? current_user
      @e = Equipment.new name: params[:equipment][:name], condition: params[:equipment][:condition], team_id: params[:equipment][:team_id]
      unless @e.save
        flash[:error] = @e.errors.full_messages.to_sentence
      end
    else
      flash[:error] = "Only team leaders can do that!"
    end
    redirect_to session.delete(:return_to)
  end

  def checkout
    session[:return_to] = request.referer
    @e = Equipment.find params[:id]
    if @e.checked_out?
      flash[:error] = "That's already checked out!"
    elsif not @e.team.users.include? current_user
      flash[:error] = "Only team members can checkout equipment!"
    else
      @e.user = current_user
      @e.save
    end
    redirect_to session.delete(:return_to)
  end

  def return
    @e = Equipment.find params[:id]
    session[:return_to] = request.referer
      if not @e.user == current_user
        flash[:error] = "You can't return something you don't own!"
      else
        @e.user_id = nil
        @e.save
      end
    redirect_to session.delete(:return_to)
  end
end
