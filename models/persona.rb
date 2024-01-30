require 'mongoid'

class Persona
  include Mongoid::Document
  field :correo, type: String
  field :nombre, type: String
  field :telefono, type: String
  field :es_cliente, type: Boolean
  field :es_proveedor, type: Boolean
  field :password, type: String


  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))
  end
end