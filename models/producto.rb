require 'mongoid'

class Producto
  include Mongoid::Document

  field :marca, type: String
  field :modelo, type: String
  field :valor, type: Float
  field :descuento, type: Float
  field :pais, type: String
  field :nombre, type: String
  field :descripcion, type: String
  field :cantidad, type: Integer
  field :proveedor, type: Persona
  field :imagen_path, type: String

  #marca, modelo, valor, descuento, pais, cantidad, proveedor

  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))
  end
end