class Battleships
  
  @players_board = []
  @big_ship = []
  @little_ship = []
  
  def init_players_board
    @players_board = Array.new(3) { Array.new(3, "-") }
  end
    
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
  
  def play
    init_players_board
    place_big_ship
    place_little_ship
    print @big_ship; puts
    print @little_ship; puts
  end
  

end

new_game = Battleships.new
new_game.play
