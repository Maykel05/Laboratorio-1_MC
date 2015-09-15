class Match
  attr_accessor :team_a, :team_b ,:team_a_socers, :team_b_socers
  def initialize(team_a, team_b)
  	@team_a = team_a
  	@team_b = team_b
  end
  def finish_match(socers_a, socers_b)
  	@team_a_socers = socers_a
  	@team_b_socers = socers_b
  	if @team_a_socers.to_i > @team_b_socers.to_i
		team_a
	elsif @team_a_socers.to_i < @team_b_socers.to_i
		team_b
	else
		"Empate"
	end
  end
end