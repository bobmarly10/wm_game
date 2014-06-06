class PublishScoreChange
  @queue = :scores

  def self.perform
    Pusher['scores'].trigger('update', {})
  end

end