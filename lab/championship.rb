class Championship
 attr_accessor :name, :type, :teams, :matches, :players, :player_input_team
 def initialize(in_name, in_type)
 	@name=in_name
 	@type=in_type
 	@teams=Array.new
	@matches=Array.new
	@players=Array.new
	@player_input_team=Array.new
 end
 def count_teams
 	a=@teams
 	a.size
 end
 def add_player(instance)
 	@players.push(instance)
 end
  def add_team(instance)
 	a=@teams
 	a.push(instance)
 end
 def list_team
 	a=@teams
 	a.each{ |e| puts e.name}
 end
 def consulta_cuadro(team)
 	@beta= nil
	a=@teams
 	a.each { |e| if e.name==team; @beta = e end}
	@beta
 end
 def consulta_jugador(player)
 	@beta2 = nil
	@players.each { |e| if e.identitycard==player; @beta2 = e end}
	@beta2
 end
 def mostrar_player
 	@players.each { |e| puts "#{e.name} (#{e.identitycard})" }
 end
 def mostrar_team
 	a=@teams
 	a.each { |e| puts "#{e.name} (#{e.players.size} jugadores: #{e.players.map {|a| a.name}.join(', ')})"}
 end
 def player_to_team(input)
 	@beta3=nil
	@player_input_team.each { |e| if e==input; @beta3=e end}
	@beta3
 end
 def player_input(input)
 	@player_input_team << input
 end
 def player_in_team(input)
 	a=@teams
 	a.each { |e| if e.name==input; puts "#{e.players.map {|a| "#{a.name} (#{a.identitycard})"}.join"\n"}" end}
 end
end