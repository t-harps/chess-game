require_relative 'board'
require 'yaml'

class Game
  attr_accessor :board
  def initialize
  	@board = Board.new
  	player = 1
  	puts "Would you like to load a previous game?"
		input = gets.chomp.downcase
		if input == "yes" || input == "load"
  		@board = load_game
  		@board.display_board
  	end
  	play(player)
  end

  def play(player)
  	board.display_board
  	bool = true
   	i = 1
		x = 0
		while bool == true
			from,to = get_input(player)
			move_piece(player,from,to,x)
			board.display_board
			player = switch_player(player)
			if check?(player)
				puts "Check on Player #{player}"
				bool = false if checkmate?(player)
			end
			x += 1
			i += 1 if x%2==0
		end
		puts "Game-over"
  end

	def move_piece(player,from,to,x)
		piece = board.get_piece(from)

		if piece == "_"
			puts "No piece there,choose again"
			from,to = get_input(player)
			move_piece(player,from,to,x)
			return
		else
			piece.colour == "white" ? bool1 = true : bool1 = false
			player == 1 ? bool2 = true : bool2 = false
		end

		if piece.legal_move?(board,from,to) && bool1 == bool2
			board.put(from, "_")
			to_piece = board.get_piece(to)
    	board.put(to, piece)
    	if check?(player) && x != 1001
    		puts "Can't move into check" unless x ==1000
    		board.put(to, to_piece)
    		board.put(from, piece)
    		unless x == 1000
    			from,to = get_input(player) 
					move_piece(player,from,to,x)
				end
			else
				if x == 1000
					return false
				end
    	end
  	else
  		return true if x == 1000
  		from,to = get_input(player)
			move_piece(player,from,to,x)
		end

  end

  def get_input(player)
  	puts "Player #{player} enter piece coordinates and destination coordinates: x,y x,y (save?)"
  	input = gets.chomp
  	if /^save$/ === input
  		save_game(player)
  		get_input(player)
  	elsif /^[1-8],[1-8]\s[1-8],[1-8]$/ === input
  		from,to = convert_input(input)
  		return from, to
  	else 
  		puts "You must select coordinates between 1-8, using the format x,y x,y"
  		get_input(player)
  	end
  end

  def convert_input(input)
  	input_array = input.split(" ")
  	from = input_array[0].split(",")
  	to = input_array[1].split(",")
  	f = convert_coordinates([from[0].to_i, from[1].to_i])
  	t = convert_coordinates([to[0].to_i, to[1].to_i])
  	return f, t
  end

  def convert_coordinates(coord)
  	coord[0]
  	x = coord[0]
  	coord[1]
  	case coord[1]
  	when 1
  		y = 7
  	when 2
  		y = 6
  	when 3
  		y = 5
  	when 4
  		y = 4
  	when 5
  		y = 3
  	when 6
  		y = 2
  	when 7
  		y = 1
  	when 8
  		y = 0
  	end
  	return [x,y]
  end

  def check?(p)
  	in_check = false
  	if p == 1
  		coords = board.get_coord("\u{2654}")
  		knight_check = board.knight_check?(p, coords)
  		return true if knight_check == true
  		max = board.max_coords(coords)
  		max.each do |to|
  			in_check = false
  			in_check, piece, p_coord = board.clear_path?(coords,to)
  			if piece.nil? || piece.colour == "white"
  				in_check = false 
  			else
  				in_check = check_again?(piece,coords,p_coord)
  			end
  			if in_check == true
  				return in_check
  			end
  		end
  	else
  		coords = board.get_coord("\u{265A}")
  		knight_check = board.knight_check?(p, coords)
  		return true if knight_check == true
  		max = board.max_coords(coords)
  		max.each do |to|
  			in_check = false
  			in_check, piece, p_coord = board.clear_path?(coords,to) 
  			if piece.nil? || piece.colour == "black"
  				in_check = false
  			else
  				in_check = check_again?(piece,coords,p_coord)
  			end
  			if in_check == true
  				return in_check
  			end
  		end
  	end
  	return in_check
  end

  def check_again?(piece,king_coords,piece_coords)
  	in_check = false
  	dif_x = king_coords[0]-piece_coords[0]
  	dif_y = king_coords[1]-piece_coords[1]
  	if piece_coords[0] == king_coords[0] || piece_coords[1] == king_coords[1]
  		if piece.class == Queen || piece.class == Rook
  			in_check = true
  		end
  	elsif dif_y.abs == dif_x.abs && dif_y.abs == 1
  		if piece.class == Pawn || piece.class == Queen || piece.class == Bishop
  			in_check = true
  		end
  	elsif dif_y.abs == dif_x.abs
  		if piece.class == Queen || piece.class == Bishop
  			in_check = true
  		end
  	end

  	return in_check
  end

  def checkmate?(p)
 		coords = []
  	if p == 1
  		coords = board.get_coord("\u{2654}")
  	else
  		coords = board.get_coord("\u{265A}")
  	end
  	possible = possible_king_moves(coords)
  	possible.each do |to|
      unless to[0] > 8 || to[0] < 1 || to[1] > 7 || to[1] < 0
    		unless move_piece(p,coords,to,1000)
    			in_check = check?(p)
    			if in_check == false
    				move_piece(p,to,coords,1001)
    				board.put(to, to_piece)
    				return false
    			end
    		end
      end
  	end
  	puts "checkmate"
  	return true
  end

  def possible_king_moves(coords)
  	possible = []
  	possible << [coords[0],coords[1]+1]
  	possible << [coords[0],coords[1]-1]
  	possible << [coords[0]+1,coords[1]]
  	possible << [coords[0]-1,coords[1]]
  	possible << [coords[0]-1,coords[1]-1]
  	possible << [coords[0]+1,coords[1]+1]
  	possible << [coords[0]+1,coords[1]-1]
  	possible << [coords[0]-1,coords[1]+1]
  	return possible
  end

  def switch_player(p)
		if p == 1
			return 2
		else
			return 1
		end
	end

	def save_game(player)
    print "Name your save game: "
    name = gets.chomp.downcase
 		yaml = YAML::dump(board)
  	game_file = File.open("../saves/#{name}.yaml", "w")
  	game_file.write(yaml)
  	game_file.close
  end

  def load_game
  	puts "Which game would you like to load?"
		name = gets.chomp.downcase
  	game_file = File.open("../saves/#{name}.yaml", "r")
  	saved_board = YAML::load(game_file.read)
  	return saved_board
	end

end

a = Game.new

