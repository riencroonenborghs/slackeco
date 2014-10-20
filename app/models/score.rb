class Score < ActiveRecord::Base
  validates_presence_of :username

  def self.game_won!(username)
    score = get_score_object(username)
    score.update_attributes!(games_played: score.games_played+1, games_won: score.games_won+1)
  end

  def self.game_lost!(username)
    score = get_score_object(username)
    score.update_attributes!(games_played: score.games_played+1)
  end

  def self.game_draw!(username)
    score = get_score_object(username)
    score.update_attributes!(games_played: score.games_played+1, games_draw: score.games_draw+1)
  end

  def self.score(username)
    score = get_score_object(username)
    "(#{username} | #{score.games_played}) games | #{score.games_won} wins | #{score.games_draw} draws" 
  end

private

  def self.get_score_object(username)
    score = self.where(username: username).first
    score ||= self.create!(username: username)
    score
  end
end
