# Example 1: Initializing the player's board

  def init_players_board
    @players_board = Array.new(3) { Array.new(3, "-") }
    (0..2).each do |i|
      (0..2).each do |j|
        @players_board[i][j] = "-"
      end
    end
  end

#		OR
		
  def init_players_board
    @players_board = Array.new(3) { Array.new(3, "-") }
  end

#		:)


# Example 2: Placing the ships

  def place_ships
    big_ship_first_vertical, big_ship_first_horizontal = rand(3), rand(3)
    vertical_or_horizontal = rand(2)
    if vertical_or_horizontal == 1
      if big_ship_first_horizontal == 3
        big_ship_second_vertical, big_ship_second_horizontal = big_ship_first_vertical, big_ship_first_horizontal - 1
      else
        big_ship_second_vertical, big_ship_second_horizontal = big_ship_first_vertical, big_ship_first_horizontal + 1
      end
    else 
      if big_ship_first_vertical == 3
        big_ship_second_vertical, big_ship_second_horizontal = big_ship_first_vertical - 1, big_ship_first_horizontal
      else          
        big_ship_second_vertical, big_ship_second_horizontal = big_ship_first_vertical + 1, big_ship_first_horizontal
      end
    end
    @big_ship = [[big_ship_first_vertical, big_ship_first_horizontal],[big_ship_second_vertical, big_ship_second_horizontal]]
    @little_ship = [big_ship_first_vertical, big_ship_first_horizontal]
    while @big_ship.include? @little_ship      
      little_ship_vertical, little_ship_horizontal = rand(3), rand(3)
      puts little_ship_vertical, little_ship_horizontal
      @little_ship = [little_ship_vertical, little_ship_horizontal]
	end  
  end

#	  		Below: An Improvement?

  def place_ships
    big_ship_x_1, big_ship_y_1 = rand(3), rand(3)
    orientation = rand(2)puts orientation
    if orientation == 0
      big_ship_x_2 = big_ship_x_1
      if big_ship_y_1 == 2
        big_ship_x_2, big_ship_y_2 = big_ship_x_1, big_ship_y_1 - 1
      else
        big_ship_x_2, big_ship_y_2 = big_ship_x_1, big_ship_y_1 + 1
      end
    else 
      if big_ship_x_1 == 2
        big_ship_x_2, big_ship_y_2 = big_ship_x_1 - 1, big_ship_y_1
      else          
        big_ship_x_2, big_ship_y_2 = big_ship_x_1 + 1, big_ship_y_1
      end
    end
    @big_ship = [[big_ship_x_1, big_ship_y_1],[big_ship_x_2, big_ship_y_2]]
    @little_ship = [big_ship_x_1, big_ship_y_1]
    while @big_ship.include? @little_ship      
      little_ship_x, little_ship_y = rand(3), rand(3)
      @little_ship = [little_ship_x, little_ship_y]
    end
  end
	
#			Below: A Real Improvement, I hope!
			
  def place_big_ship
    coordinate_1, coordinate_2, orientation = rand(3), rand(3), rand(2)
    coordinate_3 = (coordinate_1 + 1).modulo(3)
    if orientation == 0
      @big_ship = [[coordinate_1, coordinate_2], [coordinate_3, coordinate_2]]
    else
      @big_ship = [[coordinate_2, coordinate_1], [coordinate_2, coordinate_3]]
    end
  end
      
  def place_little_ship
    @little_ship = @big_ship[0]
    while @big_ship.include? @little_ship      
      coordinate_4, coordinate_5 = rand(3), rand(3)
      @little_ship = [coordinate_4, coordinate_5]
    end
  end
  
#     And below: One fix for the "torus problem" - take out the modulo and restrict
#     coordinate_1's initial options.  See first two lines of place_big_ship.

def place_big_ship
  coordinate_1, coordinate_2, orientation = rand(2), rand(3), rand(2)
  coordinate_3 = coordinate_1 + 1
  if orientation == 0
    @big_ship = [[coordinate_1, coordinate_2], [coordinate_3, coordinate_2]]
  else
    @big_ship = [[coordinate_2, coordinate_1], [coordinate_2, coordinate_3]]
  end
end
    
def place_little_ship
  @little_ship = @big_ship[0]
  while @big_ship.include? @little_ship      
    coordinate_4, coordinate_5 = rand(3), rand(3)
    @little_ship = [coordinate_4, coordinate_5]
  end
end