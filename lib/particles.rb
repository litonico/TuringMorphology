class Vec2
  attr_accessor :x, :y
  def initialize x, y
    @x = x
    @y = y
  end

  def zipWith other, f
    Vec2.new f(@x, other.x), f(@y, other.y)
  end

  def + other
    Vec2.new @x+other.x, @y+other.y
  end

  def - other
    Vec2.new @x-other.x, @y-other.y
  end

  def scale s
    Vec2.new @x*s, @y*s
  end

  def == other
    @x == other.x && @y == other.y
  end

  def magnitude
    Math.sqrt(@x**2 + @y**2)
  end

  def normalize
    m = self.magnitude
    if m == 0
      Vec2.new 0, 0
    else
      Vec2.new @x.to_f/m, @y.to_f/m
    end
  end

end

class Particle
  attr_accessor :velocity, :position
  alias pos position

  def initialize x=0, y=0
    @velocity = Vec2.new 0, 0
    @position = Vec2.new x, y
  end

  def step
    @position += @velocity
    self
  end

  def distance_from other
    (other.position - self.position).magnitude
  end

end

