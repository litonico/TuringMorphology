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
    @particles.product(@particles).each do |p1, p2|
      repel p1, p2 unless p1 == p2
    end

    # Apply forces
    @particles.each do |particle|
      keep_inside_circle particle
      particle.step
    end
  end

  # TODO: faster-moving particles stop farther outside the circle
  # fix with vector math!
  def keep_inside_circle particle
    if particle.position.magnitude > @radius
      particle.velocity = Vec2.new 0, 0
    end
  end

  def repulsive_force p1, p2
    x = (p1.distance_from p2).abs * @radius
    1 - (x**2*(3-2*x))
  end

  def repel p1, p2
    force = repulsive_force(p1, p2)
    direction = (p2.position-p1.position).normalize
    p1.velocity += direction.scale force
    p2.velocity -= direction.scale force
  end

end
