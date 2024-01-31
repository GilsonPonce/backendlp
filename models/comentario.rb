require 'mongoid'

class Comentario
  include Mongoid::Document
  
  field :detalle, type: String
  field :cliente, type: Persona
  field :producto, type: Producto


  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))
  end
end