class PuzzleRoom
  
  def brightness
	  @brightness
  end

  def increase_brightness
	  @brightness += 1
  end	
		
	BRIGHTNESS_MAPPING = ["barely visible",
                        "low",
                        "quite bright",
                        "ridiculously strong"
                        ]
  
	def entrance(direction_youre_facing)
    if objective_direction_index?(direction_youre_facing) % 2 == 1
      puts "You close the door behind you.  It doesn't lock or anything sinister."
    end
    puts
    puts "The room is glowing #{BRIGHTNESS_MAPPING[brightness]} #{color}."
		puts "To your left #{description_second_half(direction_youre_facing,0)}"
		puts "To your right #{description_second_half(direction_youre_facing,2)}"
		puts "Directly in front of you #{description_second_half(direction_youre_facing,1)}"
		puts "Behind you #{description_second_half(direction_youre_facing,3)}"
  end
  
  def description_second_half(direction_youre_facing, array_index)
    puzzle_facing_views = ["is a #{BRIGHTNESS_MAPPING[Map.clockwise(self).brightness]} #{Map.clockwise(self).color} glow.",
                          "is #{inward_description}",
                          "is a #{BRIGHTNESS_MAPPING[Map.counterclockwise(self).brightness]} #{Map.counterclockwise(self).color} glow.",
                          "\b, you can just make out a bunch of machinery.  It is glowing #{BRIGHTNESS_MAPPING[@brightness]} #{color}."
                          ]
    puzzle_facing_views[(objective_direction_index?(direction_youre_facing) + array_index).modulo(4)]
  end
  
  def inward_description
    if brightness <= 2
      "a tightly sealed and locked door.\nIt doesn't look like you're going back through it anytime soon."
    else
      "a huge door that was until recently tightly locked, but now hangs wide open."
    end
  end
  
  def objective_direction_index?(direction)
    objective_directions = ["inward", "counterclockwise", "puzzle", "clockwise"]
    objective_directions.index(direction)
  end
  
  def machinery_description
    puts
    puts "As you get closer the machinery reveals itself to be a mass of antiquated technology."
    puts "You see vacuum tubes, cables and old CRT monitors, among a lot of other items."
    puts "You approach it even closer.  It rotates, shifts, and morphs into a discernable shape."
    if brightness == 3
      puts "It's interesting, but it's blindingly bright.  You're not sure what to do at this point."
    end
  end
      
end