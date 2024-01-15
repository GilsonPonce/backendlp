require 'mongoid'

class Pedido
    include Mongoid::Document

    field :cliente, type: Persona
    field :producto, type: String
    field :estado, type: String

    def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))
  end
end
    

