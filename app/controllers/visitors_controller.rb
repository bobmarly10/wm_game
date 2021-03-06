class VisitorsController < ApplicationController

  prepend_before_filter :mock_current_user,           :only => [:please_login]
  prepend_before_filter :redirect_unless_in_facebook, :only => [:index]
  before_filter :load_ranking


  def index 
    Invitation.save_invitations(current_user, params[:request_ids]) if params[:request_ids]
    @games          = Game.pending.includes(:team_a, :team_b).order('start_at')
    @current_games  = Game.running.order('start_at')
    @next_game      = @games.first
    @past_games     = Game.ended.order('start_at DESC')
    @bets           = current_user.fetch_bets
    @chat_message   = ChatMessage.new
    @chat_messages  = ChatMessage.order('id DESC').limit(25)
    @bet            = Bet.new
  end

  def log_invitation
    (params[:invited_users]||[]).each do |invited_user_id|
      Invitation.create( user_id: current_user.id, request_id: params[:request_id], guest_id: invited_user_id)
    end
    head :ok
  end

  def please_login
    render text: 'please log in to facebook...'
  end


  def pending_games
    @games = Game.pending.order('start_at')
    render partial: 'upcoming'
  end

  def current_games
    @current_games = Game.running.order('start_at')
    render partial: 'current_games'
  end

  def past_games
    @past_games = Game.ended.order('start_at DESC')
    render partial: 'past_games'
  end

  def next_game
    @next_game = Game.pending.order('start_at').first
    render partial: 'next_game'
  end

  def ranking
  end


 protected
 
  def mock_current_user
    @current_user = User.new
  end

  def redirect_unless_in_facebook
    redirect_to 'https://apps.facebook.com/testcloud_wm_game/' and return  if !user_signed_in? && params[:signed_request].nil?
  end

  def load_ranking
    @users = User.order('score DESC').limit(25)
  end

end
