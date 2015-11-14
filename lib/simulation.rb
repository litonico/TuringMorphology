require './lib/particles'

ORIGIN = Vec2.new(0, 0)
RADIAL_SPEED = 5
REPULSION_DISTANCE = 5
REPULSION_FORCE = 1
FRICTION = 0.8 # between 0 and 1-- 1 is slippery, 0 is no motion

class Simulation
  attr_reader :particles
  def initialize radius
    @radius = radius
    @particles = []
  end

  def add_particle p
    @particles << p
  end

  def step
    # Accumulate forces

    # Is there a better way (a la Array#product) to do this?
    @particles.each_with_index do |p1, i|
      @particles.each_with_index do |p2, j|
        if j < i
          next
        end
        repel p1, p2
      end
    end

    # Apply forces
    @particles.each do |particle|
      particle.step
      drift_away_from_center particle
      frictional_loss particle
    end
  end

  ##
  # Simulate the charged plate that carries all particles away from the center
  def drift_away_from_center p
    dir = (p.position - ORIGIN ).normalize
    speed = 1.0
    p.velocity += dir.scale 0.001 * speed * RADIAL_SPEED
  end

  def frictional_loss p
    p.velocity = p.velocity.scale FRICTION
  end

  def keep_inside_circle particle
    if particle.position.magnitude > @radius
      particle.velocity = Vec2.new 0, 0
    end
  end

  def cubic p1, p2
    x = (p1.distance_from p2).abs / REPULSION_DISTANCE
    if x > 1
      y = 0
    elsif x < 0
      y = 1
    else
      y = 1 - (x**2.0*(3.0-2.0*x))
    end
    y * 0.001 * REPULSION_FORCE
  end

  def inverse_exponential p1, p2
    x = (p1.distance_from p2).abs / REPULSION_DISTANCE
    if x == 0
      y = 0.0001
    else
      y = 1/x**2
    end
    y * REPULSION_FORCE * 0.0001
  end

  def repel p1, p2
    force = cubic(p1, p2)
    direction = (p2.position-p1.position).normalize
    p2.velocity += direction.scale force
    p1.velocity -= direction.scale force
  end

end
