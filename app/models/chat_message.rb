class ChatMessage < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper

  ICONS = [:ball, :smile, :sad, :laugh, :wink, :tongue, :coffee, :thumb_up, :thumb_down, :world, :music, :sun, :rain, :cloudy, :clouds, :lightning, :warn]

  # relations
  belongs_to :user

  # validations
  validates :body, presence: true

  # hooks
  after_create :broadcast



  def author_name
    user ? user.first_name : 'Ticker'
  end

  def author_locale
    user ? user.short_locale : 'sys'
  end

  def author_image
    user ? user.image_url : 'sys'
  end

  def author_points
    user ? user.score : 'sys'
  end

  def timestamp
    created_at.utc.to_i
  end

  def html_body
    strip_tags(body).gsub(/:([a-z]{2}):/, '<span class="flag \1" />').gsub(/:(#{ICONS.join('|')}):/, '<span class="\1" />').gsub(/\n/, '<br />')
  end

  def self.json_options
    { :methods => [:timestamp, :author_name, :author_locale, :author_image, :author_points, :html_body], :only => [] }
  end



 protected

  def broadcast
    Pusher['chat'].trigger('message', self.to_json(ChatMessage.json_options))
  end

end
