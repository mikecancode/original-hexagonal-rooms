class Battleships
  
  # Now working to implement one general instance variable called @ships, 
  # which will allow for any board size and number of ships by just changing the constant below
  BOARD_SIZE = 3
  
  @players_board = []
  @ships = []
  @winning_board = []
  @wins = []
  @ships_found = false
  
  def prompt
    puts
    print "> "
    response = gets.chomp.downcase
  end
  

  # This function is the heart of the new @ships version
  # It currently works - mostly.
  
  def place_ships
    number_of_ships = BOARD_SIZE - 1
    @ships = Array.new
    (0..number_of_ships - 1).each do |i|
      ship = Array.new
      ship_size = number_of_ships - i
      x, y = rand(ship_size - 1), rand(ship_size)
      if [:horizontal, :vertical].sample == :horizontal
        puts "horizontal"
        (0..ship_size - 1).each { |j| ship.push([x + j, y]) }
      else
        puts "vertical"
        (0..ship_size - 1).each { |j| ship.push([y, x + j]) }
      end
      @ships.push(ship)
    end
  end

  
  #old
  def create_winning_board
    (0..1).each do |i|
      a, b = @big_ship[i]
      @winning_board[a][b] = "@"
    end
    a, b = @little_ship[0]
    @winning_board[a][b] = "*"
  end

  #old
  def setup_round
    @wins = ["seed"]
    @players_board = Array.new(BOARD_SIZE) { Array.new(3, nil) }
    @winning_board = Array.new(3) { Array.new(3, nil) }
    

    place_big_ship
    place_little_ship
    create_winning_board
  end
  
  def cheat
    print "big ship: "; print @big_ship; print ";  little ship: "; print @little_ship; puts
  end
  

  # currently running battleships.rb just looks at the ships.  Still working out those kinks.
  def play
#    setup_round
    place_ships
    print @ships
    puts
    puts
=begin
    tries = 0
    while @wins.length < 4
      cheat
      tries += 1
      show_board(@players_board)
      guess = any_errors?(take_and_check_guess(tries))
      result = hit_or_miss(translate(guess))
      show_board(@players_board)
      if @wins.length < 4
        if tries == 7 # hard coding but I'm leaving it for now; I may have the game range in board size rather than number of tries; we'll see
          puts "Sorry, you've exceeded your guess limit."
          puts "Please try again later."
          return
        end
        if !go_again?
          puts "OK, see you later."
          return
        end
      end
    end
    puts "Nice job! YOU WIN!"
    puts
=end
  end

  # everything else below is waiting to be refactored after the place_ships functiion is done

  def take_and_check_guess(tries)
    puts "There are two ships out there in the ocean."
    puts "One of length 2, one of length 1."
    puts "See if you can find them in 7 tries or less."
    puts "Have a guess (like a1, b3, etc.)!"
    puts
    puts "Try Number #{tries}:"
    guess = prompt
  end

  def any_errors?(guess)
    guess = guess_kosher?(guess)
    guess = already_got_right?(guess)
  end

  def guess_kosher?(guess)
    while guess.length != 2 or !( ["a", "b", "c"].include? guess[0] and ["1", "2", "3"].include? guess[1] )
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
  
  # at one point the coordinates were backwards and I didn't know why so I just switched them again in guess below; bad idea - everything is as it should be now
  def translate(guess)
    translation = ["a", "b", "c"]
    guess = [translation.index(guess[0]), guess[1].to_i - 1]
  end

  # there will be a lot of iteration once @ships replaces @little_ship and @big_ship, including on sections like this one - but it will be worth it
  def hit_or_miss(guess)
    if [guess[0], guess[1]] == @big_ship[0] or [guess[0], guess[1]] == @big_ship[1]
      puts
      puts "Congratulations!  You've scored a hit on the Big Ship!"
      add_to_wins(guess, "big")
      if @wins.include?(@big_ship[0]) and @wins.include?(@big_ship[1])
        puts "Congratulations! You've sunk the Big Ship!"
      end
    elsif [guess[0], guess[1]] == @little_ship[0]
      puts
      puts "Congratulations! You've sunk the Little Ship!"
      add_to_wins(guess, "little")
    else
      puts
      puts "Sorry, that shot was a miss."
      return
    end
  end

  # same comment as last method
  def add_to_wins(guess, ship_size)
    @wins.push(guess)
    if ship_size == "big"
      @players_board[guess[0]][guess[1]] = "@"
    elsif ship_size == "little"
      @players_board[guess[0]][guess[1]] = "*"
    end
  end
    
  # here's where not hard-coding is already making it easier to generalize the board size, I hope
  def show_board(board)
    puts
    letterline
    BOARD_SIZE.times{puts}
    (0..BOARD_SIZE-1).each do |j|      
      print "      "
      numbercolumn(j)
      (0..BOARD_SIZE-1).each do |i|
        print (board[i][BOARD_SIZE-1-j] or "-")
        print "      "
      end
      numbercolumn(j)
      BOARD_SIZE.times{puts}
    end
    letterline
    BOARD_SIZE.times{puts}
  end
  
  # this will be harder to generalize, maybe
  def letterline
    letters = ["a", "b", "c"]
    print "             "
    (0..BOARD_SIZE-1).each do |i|
      print letters[i]
      print "      "
    end
  end

  def numbercolumn(i)
    print BOARD_SIZE - i
    print "      "
  end
    
  def go_again?
    puts
    puts "Would you like to fire another shot? (y/n)"
    if prompt != "y"
      puts
      puts "Would you like to quit? (y/n)"
      if prompt == "y"
        return false
      end
    end
    true
  end
  
end

new_game = Battleships.new
new_game.play