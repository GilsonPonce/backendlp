require 'mongoid'

class Producto
  include Mongoid::Document

  field :marca, type: String
  field :modelo, type: String
  field :valor, type: Double
  field :descuento, type: Float
  field :pais, type: String
  field :cantidad, type: Int
  field :proveedor, type: Persona

  #marca, modelo, valor, descuento, pais, cantidad, proveedor

  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))
  end
end