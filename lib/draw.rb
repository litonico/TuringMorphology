require 'graphics'
require './lib/simulation'

class SimulationWindow < Graphics::Simulation
  WINSIZE = 800
  attr_accessor :simulation

  def initialize
    super WINSIZE, WINSIZE, 16, "Repulsing Particles"
    self.simulation = Simulation.new 1
    #simulation.add_particle Particle.new((rand-0.5)*0.01, (rand-0.5)*0.01)
  end

  def update dt
    if dt%10 == 0
      simulation.add_particle Particle.new((rand-0.5)*0.01, (rand-0.5)*0.01)
    end
    simulation.step
  end

  def draw dt
    clear
    simulation.particles.each do |particle|
      pos = particle.position.scale(50) + Vec2.new(WINSIZE/2, WINSIZE/2)
      screen.draw_circle pos.x, pos.y, 6, color[:white]
    end
  end
end

SimulationWindow.new.run
