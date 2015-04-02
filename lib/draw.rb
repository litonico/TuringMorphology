require 'sdl'
require './lib/simulation'
require './lib/thingy'

class SimulationWindow < Thingy
  WINSIZE = 800
  attr_accessor :simulation

  def initialize
    super WINSIZE, WINSIZE, 16, "Repulsing Particles"
    self.simulation = Simulation.new 1
  end

  def update dt
    if dt%10 == 0
      simulation.add_particle Particle.new((rand-0.5)*0.01, (rand-0.5)*0.01)
    end
    simulation.step
  end

  def draw dt
    blank
    simulation.particles.each do |particle|
      pos = particle.position.scale(50) + Vec2.new(WINSIZE/2, WINSIZE/2)
      screen.draw_circle pos.x, pos.y, 5, color[:white], true, true
    end
  end
end

SimulationWindow.new.run
