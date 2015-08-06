require_relative 'piece'

class Board
	attr_accessor :board, :white_king, :white_queen, :white_pawn, :white_rook, :white_bishop, :white_knight, :black_pawn, :black_rook, :black_bishop, :black_knight, :black_king, :black_queen
	def initialize
		@white_king = King.new("white")
		@white_queen = Queen.new("white")
		@white_rook = Rook.new("white")
		@white_bishop = Bishop.new("white")
		@white_knight = Knight.new("white")
		@white_pawn = Pawn.new("white")
		@black_king = King.new("black")
		@black_queen = Queen.new("black")
		@black_rook = Rook.new("black")
		@black_bishop = Bishop.new("black")
		@black_knight = Knight.new("black")
		@black_pawn = Pawn.new("black")
		eight = ["8",@black_rook,@black_knight,@black_bishop,@black_queen,@black_king,@black_bishop,@black_knight,@black_rook]
		seven = ["7",@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn]
		six = ["6","_","_","_","_","_","_","_","_"]
		five = ["5","_","_","_","_","_","_","_","_"]
		four = ["4","_","_","_","_","_","_","_","_"]
		three = ["3","_","_","_","_","_","_","_","_"]
		two = ["2",@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn]
		one = ["1",@white_rook,@white_knight,@white_bishop,@white_queen,@white_king,@white_bishop,@white_knight,@white_rook]
		@board = [eight,seven,six,five,four,three,two,one]
	end

	def get_coord(piece)
		board.each_with_index do |row, b_index|
			row.each_with_index do |p, r_index|
				if p.to_s == piece
					coord = [r_index, b_index]
					return coord
				end
			end
		end
	end

  def get_piece(coord)
  	coordy,coordx = coord[1],coord[0]
  	piece = board[coordy][coordx]
  	return piece
  end

  def put(coord, piece)
  	coordy,coordx = coord[1],coord[0]
  	board[coordy][coordx] = piece
  end

  def clear_path?(from, to)
  	fromx, fromy = from[0], from[1]
  	tox,toy = to[0],to[1]
  	x,y = fromx,fromy
  	if toy == fromy
	  	clear_horizontal(fromx,tox,x,y)
	  elsif tox == fromx
	   	clear_vertical(fromy,toy,x,y)
	  else
	  	clear_diagonals(fromx,fromy,tox,toy)
	  end
  end

  def clear_vertical(fromy,toy,x,y)
  	if fromy < toy
	  	while y < toy
	  		y += 1
	  		piece = board[y][x]
	  		p_coord = [x,y]
	  		return false, piece, p_coord if board[y][x] != "_"
	  	end
	  else
	  	while y > toy
	  		y -= 1
	  		piece = board[y][x]
	  		p_coord = [x,y]
	  		return false, piece, p_coord if board[y][x] != "_"
	  	end
	  end
	  true
  end

  def clear_horizontal(fromx,tox,x,y)
  	if fromx < tox
		  while x < tox
		  	x += 1
		  	piece = board[y][x]
		  	p_coord = [x,y]
		  	return false, piece, p_coord if board[y][x] != "_"
		  end
	  else
		 	while x > tox
		 		x -= 1
		 		piece = board[y][x]
		 		p_coord = [x,y]
		 		return false, piece, p_coord if board[y][x] != "_"
		 	end
		end
		true
	end

	def clear_diagonals(fromx,fromy,tox,toy)
  	x,y = fromx,fromy
		if fromx < tox && fromy < toy #south east
			while x < tox
		  	x += 1
		  	y += 1
		  	piece = board[y][x]
		  	p_coord = [x,y]
		  	return false, piece, p_coord if board[y][x] != "_"
		  end
		elsif fromx < tox && fromy > toy #north east
			while x < tox
		  	x += 1
		  	y -= 1
		  	piece = board[y][x]
		  	p_coord = [x,y]
		  	return false, piece, p_coord if board[y][x] != "_"
		  end
		elsif fromx > tox && fromy > toy #north west
			while x > tox
		  	x -= 1
		  	y -= 1
		  	piece = board[y][x]
		  	p_coord = [x,y]
		  	return false, piece, p_coord if board[y][x] != "_"
		  end
		else #south west
			while x > tox
		  	x -= 1
		  	y += 1
		  	piece = board[y][x]
		  	p_coord = [x,y]
		  	return false, piece, p_coord if board[y][x] != "_"
		  end
		end
		true
	end

	def max_coords(coords)
		n = [coords[0], 0]
		e = [8, coords[1]]
		s = [coords[0], 7]
		w = [1, coords[1]]
	  ne = ne(coords)
	  se = se(coords)
	  sw = sw(coords)
	  nw = nw(coords)
	  return [n,ne,e,se,s,sw,w,nw]
	end

	def ne(coords)
		x,y = coords[0],coords[1]
		while (x<8 && y>0)
			x+=1
			y-=1
    end
    return [x,y]
	end

	def se(coords)
		x,y = coords[0],coords[1]
		while x<8 && y<7
			x+=1
			y+=1
    end
    return [x,y]
	end

	def sw(coords)
		x,y = coords[0],coords[1]
		while x>1 && y<7
			x-=1
			y+=1
    end
    return [x,y]
	end

	def nw(coords)
		x,y = coords[0],coords[1]
		while x>1 && y>0
			x-=1
			y-=1
    end
    return [x,y]
	end

  def knight_positions(coords)
  	one = [coords[0]+2,coords[1]+1] 
  	two = [coords[0]+2,coords[1]-1]
  	three = [coords[0]+1,coords[1]+2]
  	four = [coords[0]+1,coords[1]-2]
  	five = [coords[0]-2,coords[1]+1]
  	six = [coords[0]-2,coords[1]-1]
  	seven = [coords[0]-1,coords[1]-2]
  	eight = [coords[0]-1,coords[1]+2]
  	return [one,two,three,four,five,six,seven,eight]
  end

  def knight_check?(p, coords)
  	positions = knight_positions(coords)
  	positions.each do |possible|
  		unless possible[0] > 8 || possible[0] < 1 || possible[1] > 7 || possible[1] < 0
	  		piece = get_piece(possible)
	  		unless piece.nil?
	  			if piece.class == Knight
	  			 	return true if p == 1 && piece.colour == "black"
	  			 	return true if p == 2 && piece.colour == "white"
	  			end 
	  		end
	  	end
  	end
  	return false
  end

	def display_board
		board.each do |row|
			row.each do |element|
				print "#{element} "
			end
			puts
		end
		puts "  1 2 3 4 5 6 7 8"
	end

end

=begin
#six = ["\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}"]
#five = ["\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}"]
#four = ["\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}"]
#three = ["\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}"]
=end