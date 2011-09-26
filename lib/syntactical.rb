require 'redcarpet'
require 'pygments'

#custom renderer to mix Pygments and Redcarpet
class Syntactical < Redcarpet::Render::HTML
  include Pygments
  def block_code(code, language)
    highlight code, :lexer => lexer_name_for(:lexer => language)
  end
end

class SyntacticalTemplate < Tilt::RedcarpetTemplate::Redcarpet2
  def generate_renderer
    Syntactical
  end
end

Tilt::register SyntacticalTemplate, 'isaac'
