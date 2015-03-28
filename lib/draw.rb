require "gosu"
require "./lib/simulation"

class SimulationWindow < Gosu::Window
  C = Gosu::Color::WHITE

  def initialize simulation, scale
    super scale, scale, false
    self.caption = "Repelling particles simulation"
    @simulation = simulation
    @simulation.add_particle Particle.new(rand(0.1), rand(0.1))
    @simulation.add_particle Particle.new(rand(0.1), rand(0.1))
    @scale = scale
    @dt = 0
  end

  def update
    @simulation.step
    @dt += 1
    # Every 500 frames, add a new particle
    if @dt%50 == 0
      # Jitter a little to avoid putting particles
      # right on top of each other
      #@simulation.add_particle Particle.new(rand(0.1), rand(0.1))
    end
  end

#  def draw
#    x = 300
#    y = 200
#    size = 120
#    draw_quad(x-size, y-size, 0xffff8888, x+size, y-size, 0xffffffff, x-size, y+size, 0xffffffff, x+size, y+size, 0xffffffff, 0)
#  end

  def draw_frame_number!
    Gosu::Font.new(self, "arial", 10).draw(@dt, 10, 10, 0)
  end

  def draw
    draw_frame_number!

    @simulation.particles.each do |particle|
      pos = particle.position.scale(1) + Vec2.new(@scale/2, @scale/2)
      half_width = 8
      draw_quad(pos.x-half_width, pos.y-half_width, C,
                pos.x-half_width, pos.y+half_width, C,
                pos.x+half_width, pos.y-half_width, C,
                pos.x+half_width, pos.y+half_width, C)
    end
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

end

def draw_circle px, py, radius, color, steps=16
  dd = 2*Math::PI/steps
  (0..2*Math::PI).step(dd).each do |d|
    draw_triangle(px, py, color,
                  px+Math.cos(d)*radius, py+Math.sin(d)*radius, color,
                  px+Math.cos(d+dd)*radius, py+Math.sin(d+dd)*radius, color)
  end
end


window = SimulationWindow.new Simulation.new(1), 800
window.show
