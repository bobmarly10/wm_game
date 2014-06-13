class Game < ActiveRecord::Base
  attr_accessor :updated_from_oldb_match

  # relations
  belongs_to :team_a, class_name: "Team"
  belongs_to :team_b, class_name: "Team"
  has_many :bets

  # validations
  validates :team_a, :team_b, :start_at, :presence => true

  # plugins
  as_enum :group, { a:0, b:1, c:2, d:3, e:4, f:5, g:6, h:7 }
  as_enum :finals, { last_16:0, last_8:1, last_4:2, last_2:3 }

  # scopes
  scope :pending,           ->{ where( 'games.start_at > ?', Time.current ).where( end_at: nil ) }
  scope :running,           ->{ where( 'games.start_at <= ?', Time.current ).where( end_at: nil ) }
  scope :ended,             ->{ where( 'games.end_at IS NOT NULL' ) }
  scope :next,              ->{ pending.order('start_at') }
  scope :without_oldb_idx,  ->{ where( :oldb_idx => nil ) }

  # hooks
  after_save :set_scores


  def round
    finals.nil? ? group : finals
  end


  def finals?
    finals.present?
  end

  def pending?
    status == :pending
  end

  def running?
    status == :running
  end

  def ended?
    status == :ended
  end

  def status
    case
    when start_at > Time.current
      :pending
    when end_at.nil?
      :running
    else
      :ended
    end
  end


  def draw?
    team_a_goals == team_b_goals
  end

  def team_a_won?
    team_a_goals > team_b_goals
  end

  def team_b_won?
    team_b_goals > team_a_goals
  end



  def update_from_oldb( oldb_match )
    current_score = oldb_match[:match_results][:match_result].sort {|mr1,mr2| mr1[:result_order_id] <=> mr2[:result_order_id] }.last
    return unless current_score
    self.updated_from_oldb_match = true
    self.team_a_goals = current_score[:points_team1].to_i  unless current_score[:points_team1].to_i == -1
    self.team_b_goals = current_score[:points_team2].to_i  unless current_score[:points_team2].to_i == -1
  end


  def end!
    self.end_at = Time.now
    save!
  end




 protected

  def set_scores
    if ended? && end_at_changed?
      bets.map(&:score!)
      User.score_change!
    end
  end

end
