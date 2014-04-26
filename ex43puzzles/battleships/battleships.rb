class Battleships
  
  @players_board = []
  @big_ship = []
  @little_ship = []
  @wins = [] 
  
  def prompt
    puts
    print "> "
    response = gets.chomp.downcase
  end
  
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
  
  def cheat
    print @big_ship; puts
    print @little_ship; puts
  end
  
  def play
    @wins = ["seed"]
    init_players_board
    place_big_ship
    place_little_ship
    @ships_found = false
    while @wins.length < 4
      cheat
      show_board
      guess = any_errors?(take_and_check_guess)
      result = hit_or_miss(translate(guess))
      show_board
      if @wins.length < 4
        if go_again? != "y"
          puts "OK, see you later."
          return
        end
      end
    end
    puts "Nice job! YOU WIN!"
  end

  def take_and_check_guess
    puts "There are two ships out there in the ocean."
    puts "One of length 2, one of length 1."
    puts "See if you can find them."
    puts "Have a guess (like a1, b3, etc.)!"
    guess = prompt
  end

  def any_errors?(guess)
    guess = guess_kosher?(guess)
    guess = already_got_right?(guess)
  end

  def guess_kosher?(guess)
    while guess.length != 2 or !( ["a", "b", "c"].include? guess[0]) and ( ["1", "2", "3"].include? guess[1] )
      puts "Please try again and type a legitimate guess."
      guess = prompt
    end
    guess
  end

  def already_got_right?(guess)
    while @wins.include?(guess)
      puts "You already got that one right! Please try a new guess."
      guess = prompt
    end
    guess
  end
  
  def translate(guess)
    translation = ["a", "b", "c"]
    guess = [guess[1].to_i - 1, translation.index(guess[0])]
  end

  def hit_or_miss(guess)
    print [guess[0], guess[1]]
    if [guess[0], guess[1]] == @big_ship[0] or [guess[0], guess[1]] == @big_ship[1]
      puts "Congratulations!  You've scored a hit on the Big Ship!"
      if @wins.include?(@big_ship[0]) or @wins.include?(@big_ship[1])
        add_to_wins(guess, "big", )
        puts "Congratulations! You've sunk the Big Ship!"
      end
    elsif [guess[0], guess[1]] == @little_ship
      puts "Congratulations! You've sunk the Little Ship!"
      add_to_wins(guess, "little")
    else
      puts "Sorry, that shot was a miss."
      return
    end
  end

  def add_to_wins(guess, ship_size)
    @wins.push(guess)
    if ship_size == "big"
      @players_board[guess[0]][guess[1]] = "@"
    elsif ship_size == "little"
      @players_board[guess[0]][guess[1]] = "*"
    end
  end
  
  def show_board
    puts
    letterline
    3.times{puts}
    (0..2).each do |i|      
      print "      "
      numbercolumn(i)
      (0..2).each do |j|
        print @players_board[i][j]
        print "      "
      end
      numbercolumn(i)
      3.times{puts}
    end
    letterline
    3.times{puts}
  end
  
  def letterline
    letters = ["a", "b", "c"]
    print "             "
    (0..2).each do |i|
      print letters[i]
      print "      "
    end
  end

  def numbercolumn(i)
    print i+1
    print "      "
  end
    
  def go_again?
    puts "Would you like to fire another shot?"
    response = prompt
  end
  
end

new_game = Battleships.new
new_game.play