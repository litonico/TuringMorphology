require 'minitest/autorun'
require './lib/particles'

class TestParticle < MiniTest::Spec
  def setup
    @p = Particle.new
  end

  def test_particle_default_position
    @p.position.must_equal Vec2.new(0, 0)
  end

  def test_particle_given_position
    Particle.new(2,2).position.must_equal Vec2.new(2, 2)
  end

  def test_particle_can_move
    @p.velocity.x = 1
    @p.step.position.must_equal Vec2.new(1, 0)
  end

end
