require_relative "championship.rb"
require_relative "player.rb"
require_relative "team.rb"
require_relative "table.rb"
require_relative "match.rb"
class Program
	def initialize
		count = 0
		while count == 0
			puts 'Ingrese Nombre Del campeonato: ' 
			STDOUT.flush
			name_championship = gets.chomp
			puts 'Cantidad de jugadores (5-7-11)' 
			STDOUT.flush
			type_championship = gets.chomp
			case type_championship.to_i
			when 5
				count=1
			when 7
				count=1
			when 11
				count=1
			else
				puts 'Cantidad de jugadores No valida'
			end
		end
		@championship = Championship.new(name_championship, type_championship)
	end
	def championship_can_be_played
		count_teams = @championship.count_teams
		if count_teams >= 16
		'Cantidad exedida de equipos para disputar el campeonato'
		elsif count_teams == 0
			'No hay equipos para Disputar el campeonato'
		elsif count_teams %2 == 0
			temp = @championship.teams
			verifiacion=true
			temp.each { |e| if e.players.size==@championship.type; verifiacion=false  end}
			if verifiacion==true
				puts 'Todo bien, se puede continuar el campeonato sin problemas'
			else
				'Hay equipos que tienen menos o mas de la cantidad de jugadores requeridos'
			end

		elsif count_teams %2 != 0
		'La cantidad de equipos disponibles debe ser par'
		end
	end
	def championship_start
		cross=Array.new
		b2=Array.new
		team=Array.new
		@championship.teams.each { |e| team << e}
		a1 = team
		while b2!=team[0]
			b2=a1.last
			a1.pop
			a1.each{|e| cross<<[e,b2]}
		end
		@table_match=Table.new(cross)
		@cross2= @table_match.team_cross
	end
	def championship_name
		@championship.name
	end
	def add_team
		count=0
		while count == 0	
			puts 'Ingrese nombre del equipo'
			STDOUT.flush
			name=gets.chomp
			beta = @championship.consulta_cuadro(name)
			if beta == nil
				team=Team.new(name)
				@championship.add_team(team)
				count=1
			else
				puts "El equipo ya esta ingresado"
				count=0
			end
		end
	end
	def add_player
		count = 0
		puts 'Ingrese Nombre' 
		STDOUT.flush
		name = gets.chomp
		while count == 0
			ci=nil
			beta2=""
			puts 'Ingrese Cedula de Indentidad'
			STDOUT.flush
			ci = gets.chomp
			ci=ci
			case 
			when ci.match(/(\d{1}).(\d{3}).(\d{3})-(\d{1})/)
				puts "cedula de identidad valida"
				beta2 = @championship.consulta_jugador(ci)
				if beta2 == nil
					puts 'desea asignar cuadro ahora? (si/no)'
					STDOUT.flush
					option1 = gets.chomp
					if option1=="si"
						puts 'Equipo al que pertenece'
						STDOUT.flush
						team = gets.chomp
						beta = @championship.consulta_cuadro(team)
						if beta == nil
							puts "El equipo no existe"
							count = 0
						else
							if beta.players.size==@championship.type
								puts "El equipo ya posee la cantidad nesesaria para disputar el campeonato"
							else
								player = Player.new(name, ci)
								beta.players << player
								count = 1
								@championship.add_player(player)
								@championship.player_input(player)
							end
						end
					elsif option1=="no"
					  player = Player.new(name, ci)
					  @championship.add_player(player)
					  count = 1
					else
					  puts 'La opcion ingresada es incorrecta'
					  count = 0
					end
				else
					puts "La cedula de identidad ya esta ingresada en el sistema"
					count = 0
				end
			else
				puts "cedula de identidad no valida"
				count=0
			end
		end	
	end
	def print_table
		puts "Equipo               |PJ |PG |PE |PP |Puntos"
		@championship.teams.each { |e| printf "%-21s|%2d |%2d |%2d |%2d |#{e.pg*3+e.pe} \n",e.name, e.pj, e.pg, e.pe, e.pp}
		puts "-----------------------------------------------"
                beta=0
                alfa=""
                @championship.teams.each{ |e| if e.pg*3+e.pe>=beta; alfa=e; beta=e.pg*3+e.pe end}
                puts "El ganador del campeonato #{@championship.name} es el equipo : #{alfa.name}"

	end
	def  add_player_to_team
		count = 0
		while count == 0
			puts 'Que jugador desea agregar? Ingrese CI: '
			STDOUT.flush
			ci = gets.chomp
			ci=ci
			case 
			when ci.match(/(\d{1}).(\d{3}).(\d{3})-(\d{1})/)
				puts "cedula de identidad valida"
				beta2 = @championship.consulta_jugador(ci)
				if beta2 == nil 
					puts "el jugador no existe"
					count = 0
				else
					beta=@championship.player_to_team(beta2)
					if beta == nil
						@championship.player_input(beta2)
						puts 'A que equipo: '
						STDOUT.flush
						who_team = gets.chomp	
						beta = @championship.consulta_cuadro(who_team)
						if beta == nil
							puts "El equipo no existe"
							count = 0
						else
							beta.players << beta2
							count = 1
						end
					else
						puts "El jugador ya pertenece a un equipo"
						count=0
					end
				end
			else
				puts "cedula de identidad no valida"
			end
		end
	end
	def display_players
		@championship.mostrar_player
	end
	def display_teams
		@championship.mostrar_team
	end
	def next_match
		@cross3 = @cross2.last
		count = 0
		if @cross3==nil
			puts "Ya no hay mas partidos para jugar"
		else
			match = Match.new(@cross3[0], @cross3[1])
			counts=0
			while counts==0
				puts "Goles de #{@cross3[0].name}"
				STDOUT.flush
				socers1 = gets.chomp
				case
				when socer1.match(/[a-zA-Z]\d/)
					puts "los goles no contienen letras"
					counts=0
				when socer1.match(/\d[a-zA-Z]/)
					puts "los goles no contienen letras"
					counts=0
				when socers1.match(/\d/)
					puts "Goles de #{@cross3[1].name}"
					STDOUT.flush
					socers2 = gets.chomp
					case
					when socer1.match(/[a-zA-Z]\d/)
						puts "los goles no contienen letras"
						counts=0
					when socer1.match(/\d[a-zA-Z]/)
						puts "los goles no contienen letras"
						counts=0
					when socers2.match(/\d/)
						result = match.finish_match(socers1, socers2)
						@cross3[0].pj = @cross3[0].pj + 1
						@cross3[1].pj = @cross3[1].pj + 1
						if result=="Empate"
							@cross3[0].pe = @cross3[0].pe + 1
							@cross3[1].pe = @cross3[1].pe + 1
							puts "Hubo empate"
						elsif result==@cross3[0]
							puts "Gano el equipo de #{result.name}"
							@cross3[0].pg = @cross3[0].pg + 1
							@cross3[1].pp = @cross3[1].pp + 1
						else
							puts "Gano el equipo de #{result.name}"
							@cross3[1].pg = @cross3[1].pg + 1
							@cross3[0].pp = @cross3[0].pp + 1
						end
						counts=1
					when socer1.match(/[a-zA-Z]/)
						puts "Estas son letras"
						counts=0
					else
						puts "Los goles no contienen letras"
						counts=0
					end
				when socer1.match(/[a-zA-Z]/)
					puts "Estas son letras"
					counts=0
				else
					puts "Los goles no contienen letras"
					counts=0
				end
			end
		end
		@cross2.pop
	end
	def display_fixture
		cross = @table_match.team_cross
		cross.each { |e| puts "#{e[0].name} vs #{e[1].name}"}
	end
	def display_team_players
		count=0
		while count == 0
			p 'Seleccione equipo a mostrar jugadores por nombre:'
			@championship.list_team
			STDOUT.flush
			who_team = gets.chomp
			beta	 = @championship.consulta_cuadro(who_team)

			if beta == nil
				puts "El equipo no existe"
				count = 0
			else
				@championship.player_in_team(who_team)
				count = 1
			end
		end
	end
end
