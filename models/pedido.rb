require 'mongoid'
#class
class Pedido
    include Mongoid::Document

    field :nombre, type: Persona
    field :correo, type: String
    field :telefono, type: String
    field :marca, type: String
    field :modelo, type: String
    field :cantidad, type: Integer
    field :nombreProducto, type: String

    def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))
  end
end
    

