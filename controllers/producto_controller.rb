require 'sinatra'
require 'sinatra/base'
require_relative '../models/producto'

class ProductosController < Sinatra::Base

  def self.index
    productos = Producto.all
    productos.to_json
  end

  def self.show(id)
    producto = Producto.find(id)
    
    if producto
        producto.to_json
    else
      404
      { mensaje: 'Producto no encontrado' }.to_json
    end
  end

  def self.create(request_body)
    nuevo_producto = JSON.parse(request_body, symbolize_names: true)
    producto = Producto.create(nuevo_producto)
    
    if producto.valid?
      201
      producto.to_json
    else
      422
      { mensaje: 'Error al crear el producto', errores: producto.errors.full_messages }.to_json
    end
  end

  def self.update(id, request_body)
    producto = Producto.find(id)

    if producto
      datos_actualizados = JSON.parse(request_body, symbolize_names: true)
      producto.update(datos_actualizados)
      
      if producto.valid?
        producto.to_json
      else
        422
        { mensaje: 'Error al actualizar el producto', errores: producto.errors.full_messages }.to_json
      end
    else
      404
      { mensaje: 'Producto no encontrado' }.to_json
    end
  end

  def self.destroy(id)
    producto = Producto.find(id)
    
    if producto
        producto.destroy
      { mensaje: 'Producto eliminado correctamente' }.to_json
    else
      404
      { mensaje: 'Producto no encontrado' }.to_json
    end
  end
end