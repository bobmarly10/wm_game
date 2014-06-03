class BetsController < ApplicationController

  layout false

  def new
    @game = Game.find( bet_params )
    @bet  = current_user.bets.new(:game => @game)
    @bet.post_on_facebook = true
  end

  def create
    @bet = current_user.bets.new( bet_params )
    @game = @bet.game
    @bet.save
    Airbrake.notify(:error_class => "InvalidBet", :error_message => "InvalidBet: #{@bet.errors.full_messages.to_sentence}", :parameters => @bet.attributes.merge({ :errors => @bet.errors.full_messages.to_sentence })) unless @bet.id
    current_user.reload
  end

  def edit
    @bet  = current_user.bets.find( params[:id] )
    @bet.post_on_facebook = false
    @game = @bet.game
  end

  def update
    @bet = current_user.bets.find( params[:id] )
    @bet.update_attributes( bet_params )
    @game = @bet.game
    current_user.reload
  end

  def destroy
    @bet  = current_user.bets.find( params[:id] )
    @game = @bet.game
    @bet.destroy
    current_user.reload
  end


  def bet_params
    params.require(:bet).permit(:team_a_goals, :team_b_goals, :game_id)
  end

end
