require 'sinatra'
require 'sinatra/base'
require_relative '../models/pedido'
require_relative '../models/cliente'

class PedidosController < Sinatra::Base


  def self.index
    pedidos = Pedido.all
    pedidos.to_json
  end

  def self.por_cliente(cliente_id)
    cliente = Cliente.find(cliente_id)
    
    if cliente
      pedidos = Pedido.where(cliente: cliente)
      pedidos.to_json
    else
      404
      { mensaje: 'Cliente no encontrado' }.to_json
    end
  end

  def self.create(request_body)
    nuevo_pedido = JSON.parse(request_body, symbolize_names: true)
    pedido = Pedido.create(nuevo_pedido)
    
    if pedido.valid?
      201
      pedido.to_json
    else
      422
      { mensaje: 'Error al crear el pedido', errores: pedido.errors.full_messages }.to_json
    end
  end

  def self.update(id, request_body)
    pedido = Pedido.find(id)

    if pedido
      datos_actualizados = JSON.parse(request_body, symbolize_names: true)
      pedido.update(datos_actualizados)
      
      if pedido.valid?
        pedido.to_json
      else
        422
        { mensaje: 'Error al actualizar el pedido', errores: pedido.errors.full_messages }.to_json
      end
    else
      404
      { mensaje: 'Pedido no encontrado' }.to_json
    end
  end

  def self.destroy(id)
    pedido = Pedido.find(id)
    
    if pedido
      pedido.destroy
      { mensaje: 'Pedido eliminado correctamente' }.to_json
    else
      404
      { mensaje: 'Pedido no encontrado' }.to_json
    end
  end
end
