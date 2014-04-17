require_relative "ex43puzzleroom"
require_relative "ex43redroom"
require_relative "ex43orangeroom"
require_relative "ex43yellowroom"
require_relative "ex43greenroom"
require_relative "ex43blueroom"
require_relative "ex43purpleroom"
require_relative "ex43hubroom"
require_relative "ex43map"

class Engine					
	
	def prompt
		print "> "
		response = gets.chomp.downcase
	end

	def start
		puts "You wake up in a dimly lit area.  Your head hurts."
    room = Map.hub
    room.hubroom_colors_description
    leave_hub
  end

  def leave_hub
    puts "Which color do you head towards?"
#    room = nil
    room = Map.to_room(prompt)
    while !room or room.brightness == 3
      if !room
        puts "Please try an actual color!"
      elsif room.brightness == 3
        puts "That door's already open."
        puts "Something tells you that you don't need to head back there again."
        puts "Try another color."
      end
      room = Map.to_room(prompt)
    end
	  puts "Ok, you head to the #{room.color} glow."
	  puts "You see that it is in fact from coming under a door."
	  puts "You try the door.  It is unlocked.  You open it and step through."
	  puts "The door slams shut behind you."
	  puts "It doesn't look like you're going back through it anytime soon."
	  runner(room, "puzzle")
  end
  
	def runner(room, direction)		
		while room != HubRoom.new
      room, direction = play(room, direction)
		end
	end

	def play(room, direction)
    room.entrance(direction)
    new_subjective_direction = which_way?
    new_objective_direction = Map.objective_direction(direction, new_subjective_direction)
    new_room = send(new_objective_direction, room)
    new_direction = check_orientation(new_objective_direction)
    return new_room, new_direction
	end

  def which_way?
    puts "Which way do you want to go?  Left, right, forward, or back?"
    check_legit_direction(prompt)
  end
  
	def check_legit_direction(direction)
    subjective_directions = ["left", "right", "forward", "back"]
    while !subjective_directions.include? direction
			puts "Please try an actual direction!"
			direction = prompt
		end
    direction
	end
  
	def counterclockwise(room)
		puts "You go towards the #{Map.counterclockwise(room).color} glow and push open the door you find there."
    Map.counterclockwise(room)
	end

	def clockwise(room)
		puts "You go towards the #{Map.clockwise(room).color} glow and push open the door you find there."
    Map.clockwise(room)
	end
  
  def puzzle(room)    
    play_puzzle(room)
    puts "You turn around."
    room
  end

  def play_puzzle(room)
    room.machinery_description
    puts "Do you stay and watch to see what happens?"
    play_response = prompt
    if play_response == "y"
      if room.brightness <= 2
        room.puzzle_intro_description
        puts "Do you want to play?"
        round_result = room.play_a_round?(prompt)
        if round_result[0] == "win"
          go_to_hub(room, round_result[1])
        elsif round_result[0] == "lose"
          puts "You watch the machinery dismantle itself."
        end
      else
        puts "Actually, you really can't see anything else to do here."
      end
    else
      puts "OK."
    end
  end	
    
  def go_to_hub(room, status)
    room.increase_brightness
    win_room = room
    room = Map.hub
    room.entrance(win_room)
    puts "You might as well go towards one of them.  Which one?"
    leave_hub
  end
    
  def inward(room)
    puts "You size up this crazy door.  Maybe there's some way to open it after all? Try a magical password, maybe?"
    password = prompt
    puts "Nope, #{password} definitely isn't it."
    puts "You turn around."
    room
  end  
  
  def check_orientation(direction)
    one_eighty = ["puzzle", "inward"]
    if one_eighty.include? direction
      reversed_direction = one_eighty[(one_eighty.index(direction)+1).modulo(2)]
    else
      direction
    end
  end
  
end

here_we_go = Engine.new
here_we_go.start