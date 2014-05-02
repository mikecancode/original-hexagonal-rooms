class Battleships
  
  # This version of Battleships uses one general instance variable called @ships, 
  # which will allow for any board size up to 8, by changing the value of BOARD_SIZE.
  
  BOARD_SIZE = 8
  NUMBER_OF_SHIPS = BOARD_SIZE - 1
  
  # Not sure what to do about the fact that there are a finite number of these symbols.
  # But not sure who would want to play past an 8x8 board with 7 ships, either.
  
  SHIP_SYMBOLS =  { 1 => "*",
                    2 => "@",
                    3 => "0",
                    4 => "8",
                    5 => "%",
                    6 => "$",
                    7 => "+"
                  }
  
  # Same issue as above: finite number of letters.  Should this go past 8x8?
  
  LETTERS = ["a", "b", "c", "d", "e", "f", "g", "h"]
  
  @players_board = []
  @ships = []
  @winning_board = []
  @wins = []
  @win_requirement = nil
  @tries_required = nil
  
  def prompt
    puts
    print "> "
    response = gets.chomp.downcase
  end
  
  # This function is the heart of the new @ships version of the game
  
  def place_ships
    @ships = Array.new
    (0..NUMBER_OF_SHIPS - 1).each do |i|
      ship = nil
      while !ship or ship_overlaps?(ship)
        ship = Array.new
        ship_size = NUMBER_OF_SHIPS - i
        x, y = rand(BOARD_SIZE - ship_size), rand(BOARD_SIZE)
        if [:horizontal, :vertical].sample == :horizontal
          puts "horizontal"
          (0..ship_size - 1).each { |j| ship.push([x + j, y]) }
        else
          puts "vertical"
          (0..ship_size - 1).each { |j| ship.push([y, x + j]) }
        end        
        print ship; puts
      end
#      print ship; puts
      @ships.push(ship)
    end
#    print @ships; puts    
  end

  # Below is the helper function that checks for overlaps in place_ships
  # Originally i had:
  
  # def ship_overlaps?(new_ship)
  #   @ships.each do |ship|
  #     ship.each do |square|
  #       new_ship.each do |new_square|
  #         if square == new_square
  #           return true
  #         end
  #       end
  #     end
  #   end
  #   false
  # end

  # Anshul advised me to use & and .empty? instead of iteration
  # Below is the second version of the helper function
  # It looked great but does not work!
  # Basically it compares an array of arrays of arrays to an array of arrays
  
  # def ship_overlaps?(new_ship)
  #   !(@ships & new_ship).empty?
  # end

  # Below is the third version of the helper function
  # It does work - compares apples to apples, not the above problem
  # I'm wondering if it could be refactored to be better
  
  def ship_overlaps?(new_ship)
    @ships.each do |ship|
      if !(ship & new_ship).empty?
        return true
      end
    end
    false
  end
  
  def create_winning_board
    @ships.each do |ship|
      ship.each do |coordinates|
        @winning_board[coordinates[0]][coordinates[1]] = SHIP_SYMBOLS[ship.length]
      end
    end
  end

  # This was my first use of reduce
  
  def set_win_and_tries_requirements
    @win_requirement = (1..NUMBER_OF_SHIPS).reduce(:+)
    @tries_required = BOARD_SIZE ** 2 / 2
  end

  def setup_round
    @wins = ["seed"]

    # Need to refactor the following two lines; see IMs with Anshul
    @players_board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, nil) }
    @winning_board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, nil) }

    place_ships
    create_winning_board
    set_win_and_tries_requirements
  end
  
  def cheat
    (0..NUMBER_OF_SHIPS - 1).each do |i|
      print @ships[i]
      puts
    end
  end

  # Everything above is done for the moment except refactoring creating the nil boards
  
  # Everything else below is in the process of being debugged
  # It runs but the win condition is not met correctly - otherwise seems to work
  
  def play
    setup_round
    puts
    puts
    tries = 0
    while @wins.length < @win_requirement
      cheat
      tries += 1
      show_board(@players_board)
      show_board(@winning_board)
      guess = any_errors?(take_and_check_guess(tries))
      result = hit_or_miss(translate(guess))
      show_board(@players_board)
      if @wins.length < @win_requirement
        if tries == @tries_required
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
  end

  def take_and_check_guess(tries)
    puts "There are #{NUMBER_OF_SHIPS} ships out there in the ocean."
    puts "One of each length from 1 to #{NUMBER_OF_SHIPS}."
    puts "See if you can find them in #{@tries_required} tries or less."
    puts "Have a guess (like a1, b3, etc.)!"
    puts
    puts "Try Number #{tries}:"
    guess = prompt
  end

  def any_errors?(guess)
    guess = guess_kosher?(guess)
    guess = already_got_right?(guess)
  end

  # My first use of splat below, in the condition

  def guess_kosher?(guess)
    while guess.length != 2 or !( LETTERS.include? guess[0] and [*1..(BOARD_SIZE)].to_s.include? guess[1] )
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
    guess = [LETTERS.index(guess[0]), guess[1].to_i - 1]
  end

  # Not sure about ship_size - whether it's necessary or useful
      
  def hit_or_miss(guess)
    (0..NUMBER_OF_SHIPS - 1).each do |i|
      ship_size = NUMBER_OF_SHIPS - i
      ship_size.times do |j|
        print [guess[0], guess[1]]; puts
        if [guess[0], guess[1]] == @ships[i][j]
          puts
          puts "Congratulations!  You've scored a hit on the #{SHIP_SYMBOLS[ship_size]} ship!"
          add_to_wins(guess, ship_size)
          if (@wins & @ships[i]).length == @ships[i].length
            puts
            puts "Congratulations!  You've sunk the #{SHIP_SYMBOLS[ship_size]} ship!"
          end
          return
        end
      end
    end
    puts
    puts "Sorry, that shot was a miss."    
  end

  def add_to_wins(guess, size)
    @wins.push(guess)
    @players_board[guess[0]][guess[1]] = SHIP_SYMBOLS[size]
  end
    
  def show_board(board)
    puts
    letterline
    3.times{puts}
    (0..BOARD_SIZE-1).each do |j|      
      print "      "
      numbercolumn(j)
      (0..BOARD_SIZE-1).each do |i|
        print (board[i][BOARD_SIZE-1-j] or "-")
        print "      "
      end
      numbercolumn(j)
      3.times{puts}
    end
    letterline
    3.times{puts}
  end
  
  def letterline
    print "             "
    (0..BOARD_SIZE-1).each do |i|
      print LETTERS[i]
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