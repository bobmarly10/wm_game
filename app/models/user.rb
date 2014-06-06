class User < ActiveRecord::Base

  attr_accessor :facebook_user

  # relations
  has_many :bets
  has_many :chat_messages

  # validations
  #validates :email, :first_name, :last_name, :locale, presence: true

  # plugins
  #rank_by :score


  def self.find_or_create_from_facebook(facebook_user)
    find_by(uid: facebook_user.id) || create!(
      :email            => facebook_user.email,
      :first_name       => facebook_user.first_name,
      :last_name        => facebook_user.last_name,
      :username         => facebook_user.username,
      :image_url        => facebook_user.image_url,
      :large_image_url  => facebook_user.large_image_url,
      :small_image_url  => facebook_user.small_image_url,
      :square_image_url => facebook_user.square_image_url,
      :locale           => facebook_user.locale,
      :uid              => facebook_user.id
    )
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['extra']
        user.gender = auth['extra']['raw_info']['gender']
        user.timezone = auth['extra']['raw_info']['timezone']
        user.locale = auth['extra']['raw_info']['locale']
        user.link = auth['extra']['raw_info']['link']
        user.age_range = "#{auth['extra']['raw_info']['age_range']['min']}-#{auth['extra']['raw_info']['age_range']['max']}"
      end
      if auth['info']
         user.email = auth['info']['email'] || ""
         user.name = auth['info']['name'] || ""
         user.first_name = auth['info']['first_name'] || ""
         user.last_name = auth['info']['last_name'] || ""
         user.image_url = auth['info']['image'] || ""
      end
    end
  end

  def self.score_change!
    Resque.enqueue(PublishScoreChange)
  end


  def score_ranking
    #User.find_by_sql("SELECT COUNT(*) + 1 AS ranking FROM users WHERE ").ranking
    User.where("score > (SELECT score FROM users WHERE id = #{id})").count + 1
  end


  def percent_bet
    @percent_bet ||= ((bets.for_game(Game.pending.pluck(:id)).count / (Game.pending.count.nonzero? || 1).to_f) * 100).round
  end



  def short_locale
    locale ? locale.to_s[0..1] : :en
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def fetch_bets
    Rails.cache.fetch(['user_bets', cache_key].join('/')) { bets.all }
  end


  def update_score!
    self.score = bets.scored.sum(:score)
    save!
  end


end
