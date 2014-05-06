class Battleships
  
  # This version of Battleships uses one general instance variable called @ships, 
  # which will allow for any board size up to 8, by changing the value of BOARD_SIZE.
  
  # The proportions may be off depending on the game difficulty desired.
  # To alter game difficulty, consider less ships per board size, or a higher guess limit.
  # Edit: I have increased the guess limit to 3/4 of the board size (rounded).
  
  BOARD_SIZE = 5
  NUMBER_OF_SHIPS = BOARD_SIZE - 1
  
  # For board sizes greater than 8x8, more symbols need to be added to this hash.
  
  SHIP_SYMBOLS =  { 1 => "*",
                    2 => "@",
                    3 => "&",
                    4 => "#",
                    5 => "%",
                    6 => "$",
                    7 => "+"
                  }
                  
  SHIP_NAMES = {    1 => "Cute Little Tugboat",
                    2 => "Weekend Warrior Catamaran",
                    3 => "Pioneer Era Wooden Canoe",
                    4 => "Action Movie Speedboat",
                    5 => "Golden Years Cruise Liner",
                    6 => "Abandoned Water Treatment Plant",
                    7 => "Floating Death Star"
                  }
  
  # Same issue as above: finite number of letters.  Should this go past 8x8?
  
  LETTERS = (97..97 + BOARD_SIZE).map &:chr
  
  def initialize
    @players_board = []
    @ships = []
    @hits = []
    @win_requirement = nil
    @guess_limit = nil
    @ships_sunk = nil
  end
  
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
          (0..ship_size - 1).each { |j| ship.push([x + j, y]) }
        else
          (0..ship_size - 1).each { |j| ship.push([y, x + j]) }
        end        
      end
      @ships.push(ship)
    end
  end

  # Below is the original helper function that checks for overlaps in place_ships
  
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
  # Anshul says it's good as is; I will leave it
  
  def ship_overlaps?(new_ship)
    @ships.each do |ship|
      if !(ship & new_ship).empty?
        return true
      end
    end
    false
  end
  
  # This was my first use of reduce!
  
  def setup_game_size
    @win_requirement = (1..NUMBER_OF_SHIPS).reduce(:+)
    @guess_limit = (BOARD_SIZE ** 2) * 3/4
  end

  def setup_round
    @players_board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, nil) }  
    place_ships
    setup_game_size
  end
  
  # show_solution is for debugging, to be able to see where to get hits and misses
  
  def show_solution
    (0..NUMBER_OF_SHIPS - 1).each do |i|
      print @ships[i]
      puts
    end
  end
  
  def play
    setup_round
    puts
    puts
    @ships_sunk = 0
    guess_number = 0
    while @hits.length < @win_requirement      
#      show_solution
      guess_number += 1
      show_board(@players_board)
      guess = (take_guess(guess, guess_number))
      if guess != "quit"
        result = hit_or_miss(translate(any_errors?(guess)))
        if @hits.length < @win_requirement
          if guess_number == @guess_limit
            puts
            puts "Unfortunately you've met your guess limit."
            puts "Please try again later."
            puts
            show_board(@players_board)
            return
          end
        end
      else
        puts
        puts "OK, see you later."
        puts
        return
      end
    end
    puts
    puts "Nice job! YOU WIN!"
    puts
    show_board(@players_board)
    puts
  end

  def take_guess(guess, guess_number)
    puts "There are #{NUMBER_OF_SHIPS} ships out there in the ocean."
    puts "You have sunk #{@ships_sunk} of them."
    puts "One of each length from 1 to #{NUMBER_OF_SHIPS}."
    puts "See if you can find them in #{@guess_limit} guesses or less."
    puts
    puts "You have #{@guess_limit - guess_number + 1} guesses left."
    puts "Enter your guess! (a1, b3, etc.)"
    puts "(Or type \"quit\" to quit)"
    puts
    puts "Guess Number #{guess_number}:"
    guess = prompt
   end
  
  def any_errors?(guess)
    guess = guess_kosher?(guess)
    guess = already_got_right?(guess)
  end
  
  # My first use of splat below (in the condition)!

  def guess_kosher?(guess)
    while guess.length != 2 or !( LETTERS.include? guess[0] and [*1..(BOARD_SIZE)].include? guess[1].to_i )
      puts "Please try again and type a legitimate guess."
      guess = prompt
    end
    guess
  end

  def already_got_right?(guess)
    while @hits.include?(translate(guess))
      puts "You already got that one right! Please try a new guess."
      guess = prompt
    end
    guess
  end
  
  def translate(guess)
    guess = [LETTERS.index(guess[0]), guess[1].to_i - 1]
  end
      
  def hit_or_miss(guess)
    (0..NUMBER_OF_SHIPS - 1).each do |i|
      ship_size = NUMBER_OF_SHIPS - i
      ship_size.times do |j|
        if [guess[0], guess[1]] == @ships[i][j]
          puts
          puts "Congratulations!  You've scored a hit on the #{SHIP_NAMES[ship_size]}!"
          add_to_wins(guess, ship_size)
          if (@hits & @ships[i]).length == @ships[i].length
            @ships_sunk += 1
            puts
            puts "Congratulations!  You've sunk the #{SHIP_NAMES[ship_size]}!"
          end
          return
        end
      end
    end
    deal_with_miss(guess)
  end

  def add_to_wins(guess, size)
    @hits.push(guess)
    @players_board[guess[0]][guess[1]] = SHIP_SYMBOLS[size]
  end

  def deal_with_miss(guess)
    puts "Sorry, that shot was a miss."    
    @players_board[guess[0]][guess[1]] = "."
  end
    
  def show_board(board)
    puts
    letterline
    3.times{puts}
    (0..BOARD_SIZE-1).each do |j|      
      print " " * 6
      numbercolumn(j)
      (0..BOARD_SIZE-1).each do |i|
        print (board[i][BOARD_SIZE-1-j] or "-")
        print " " * 6
      end
      numbercolumn(j)
      3.times{puts}
    end
    letterline
    3.times{puts}
  end
  
  def letterline
    print " " * 13
    (0..BOARD_SIZE-1).each do |i|
      print LETTERS[i]
      print " " * 6
    end
  end

  def numbercolumn(i)
    print BOARD_SIZE - i
    print " " * 6
  end
    
end

new_game = Battleships.new
new_game.play