require 'minitest/autorun'
require './lib/simulation'

class TestSimulation < MiniTest::Spec
  def setup
    @s = Simulation.new 2
    @p = Particle.new
  end

  # def test_adding_particles
  #   @s.add_particle @p
  #   @s.particles.must_equal [Particle.new]
  # end

  def test_step_updates_particles
    @p.velocity = Vec2.new 1, 0
    @s.add_particle @p
    @s.step
    @p.position.must_equal Vec2.new 1, 0
  end

  def test_can_keep_particles_in_circle
    @p.velocity = Vec2.new 1, 0
    @s.add_particle @p
    @s.step # 0->1
    @s.step # 1->2
    @s.step # 2->3
    @s.step # 3->3 because of circle's radius
    @p.position.must_equal Vec2.new 3, 0
    @p.velocity.must_equal Vec2.new 0, 0
  end

  def test_particles_repel
    @s.add_particle Particle.new 1, 0
    @s.add_particle Particle.new 0, 0
    @s.step
    @s.particles[0].distance_from(@s.particles[1]).must_be :>,1
  end

  def test_particles_keep_going
    @s.add_particle Particle.new 1, 0
    @s.add_particle Particle.new 0, 0
    @s.step
    @s.particles[0].position.must_equal Vec2.new 1.1, 0
    @s.particles[1].position.must_equal Vec2.new (-0.1), 0
    @s.step
    @s.particles[0].position.must_equal Vec2.new 1.3, 0
  end

  def test_particles_slow_down
    @s.add_particle Particle.new 1, 0
    @s.add_particle Particle.new 0, 0
    @s.step
  end

end
