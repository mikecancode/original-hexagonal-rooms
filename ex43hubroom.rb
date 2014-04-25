class HubRoom

  ALL_PUZZLES_SOLVED = [3,3,3,3,3,3]
  
  def hubroom_colors_description
    puts "You can just make out six faintly glowing colors."
    puts "Red, orange, yellow, green, blue, and purple."
    puts "You might as well head towards one of them."
  end
  
	def entrance(win_room)
    print all_brightnesses
    puts
    puts
    if win_room.brightness <= 2
		  puts "There is a blinding flash of #{win_room.color} light behind you."
		  puts "You turn around."
		  puts "The heavily locked door swings open and you get sucked through the opening."
      if all_levels_completed?
        puts "You look around."
        puts "All the doors are open and a rainbow of blinding color is pouring into the room."
        boss_round
      elsif last_level_completed?(win_room)
        puts "The door you just came from creaks a bit, but it doesn't close behind you this time."
        puts "You definitely remember this room.  It's brighter now.  Not all of the doors are shut."
        puts "You see:"
        show_room_brightnesses(win_room)
      elsif any_other_level_completed?
        puts "The door slams shut behind you."
        puts "You definitely remember this room.  It's brighter now.  Not all of the doors are shut."
        puts "You see:"
        show_room_brightnesses(win_room)
      else
        puts "The door slams shut behind you.  It's pretty dim all of a sudden."
		    puts "You kind of recognize this room.  It has 6 colored glows in it."
        show_room_brightnesses(win_room)
      end
    else
      puts "You step out of the #{win_room.color} light into a familiar room."
      puts "You definitely remember this room.  It's brighter now.  Not all of the doors are shut."
      show_room_brightnesses(win_room)
    end
	end
  
  def all_brightnesses
    all_brightnesses = Map::COLOR_ROOMS.map{ |room| room.brightness}
  end    
  
  def all_levels_completed?
    all_brightnesses == ALL_PUZZLES_SOLVED
  end
  
  def last_level_completed?(win_room)
    win_room.brightness == 3
  end
  
  def any_other_level_completed?
    all_brightnesses.include? 3
  end
  
  def show_room_brightnesses(win_room)
    (0..5).each{ |i| 
      if Map.clockwise(win_room,i).brightness == 3
        puts "A wide open door with a #{PuzzleRoom::BRIGHTNESS_MAPPING[Map.clockwise(win_room,i).brightness]} #{Map.clockwise(win_room,i).color} glow spilling from it."
      else
        puts "A #{PuzzleRoom::BRIGHTNESS_MAPPING[Map.clockwise(win_room,i).brightness]} #{Map.clockwise(win_room,i).color} glow."
      end
    }
  end

  def boss_round
    puts; puts "BOSS ROUND!!!"
  end

end