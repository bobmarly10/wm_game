class SyncOpenliga
  @queue = :sync

  #def self.country_map(country)
  #  return 'USA'      if country == 'Vereinigte Staaten'
  #  return 'Südkorea' if country == 'Republik Korea'
  #  country
  #end

  def self.perform
    # Replace this with your code
    Rails.logger.info "OpenligaDB Watch running at #{Time.now}:"
  
    if Game.without_oldb_idx.exists? || Game.running.exists?
      Rails.logger.info "-> executing!\n"
      require 'openligadb'
      liga = OpenLigaDB.new
      response = liga.request('matchdata_by_group_league_saison',
                                groupOrderId: 1,
                                leagueSaison: 2014,
                                leagueShortcut: 'WM-2014')
      I18n.locale = :de
      Game.without_oldb_idx.each do |game|
        oldb_team1 = I18n.t(game.team_a.country, :scope => 'countries')
        oldb_team2 = I18n.t(game.team_b.country, :scope => 'countries')
        #oldb_team1 = country_map(oldb_team1)
        #oldb_team2 = country_map(oldb_team2)
        oldb_match = response[:matchdata].select {|m| m[:name_team1].eql?(oldb_team1) && m[:name_team2].eql?(oldb_team2) }.first
        if oldb_match
          game.update_attribute(:oldb_idx, oldb_match[:match_id])
        else
          raise "could not find match #{game.id} (#{oldb_team1} vs. #{oldb_team2})"
        end
      end
      live_updates = []
      Game.running.each do |game|
        raise "game #{game.id} has no oldb_idx!" unless game.oldb_idx
        oldb_match = response[:matchdata].find {|m| m[:match_id].eql?(game.oldb_idx.to_s) }
        game.update_from_oldb( oldb_match )
        game.end_at = Time.current            if oldb_match[:match_is_finished]
        if game.team_a_goals_changed? || game.team_b_goals_changed? || game.end_at_changed?
          live_updates << { :game_id => game.id, :team_a => game.team_a_goals, :team_b => game.team_b_goals, :ended => game.ended? }
        end
        game.save!
      end
      Pusher['games'].trigger('score', live_updates) unless live_updates.empty?
    else
      Rails.logger.info "-> sleeping...\n"
    end
  end

end