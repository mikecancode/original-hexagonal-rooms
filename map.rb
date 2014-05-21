class Map

  COLOR_CLASSES = [RedRoom, OrangeRoom, YellowRoom, GreenRoom, BlueRoom, PurpleRoom]
  COLOR_ROOMS = COLOR_CLASSES.map &:new
  HUB = HubRoom.new

  def self.hub
    HUB
  end

  def self.color_rooms
    COLOR_ROOMS
  end

  def self.color_rooms_length
    color_rooms.length
  end

  def self.to_room color
    mapping = Hash[color_rooms.map { |room| [room.color, room] } ]
    mapping[color]
  end

  def self.objective_direction last_objective_direction, current_subjective_direction
    subjective_directions = ["forward", "left", "back", "right"]
    objective_directions = ["puzzle", "counterclockwise", "inward", "clockwise"]
    objective_directions[(subjective_directions.index(current_subjective_direction) + objective_directions.index(last_objective_direction)).modulo(4)]
  end

  def self.clockwise from_room, steps = 1
    COLOR_ROOMS[(COLOR_ROOMS.index(from_room) + steps).modulo(6)]
  end

  def self.counterclockwise from_room, steps = 1
    COLOR_ROOMS[(COLOR_ROOMS.index(from_room) - steps).modulo(6)]
  end

end