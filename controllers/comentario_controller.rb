require 'sinatra'
require 'sinatra/base'
require_relative '../models/comentario'

class ComentariosController < Sinatra::Base

  def self.index
    comentarios = Comentario.all
    comentarios.to_json
  end

  def self.show(id)
    comentario = Comentario.find(id)
    
    if comentario
        comentario.to_json
    else
      404
      { mensaje: 'Comentario no encontrado' }.to_json
    end
  end

  def self.create(request_body)
    nuevo_comentario = JSON.parse(request_body, symbolize_names: true)
    comentario = Comentario.create(nuevo_comentario)
    
    if comentario.valid?
      201
      comentario.to_json
    else
      422
      { mensaje: 'Error al crear el comentario', errores: comentario.errors.full_messages }.to_json
    end
  end

  def self.update(id, request_body)
    comentario = Comentario.find(id)

    if comentario
      datos_actualizados = JSON.parse(request_body, symbolize_names: true)
      comentario.update(datos_actualizados)
      
      if comentario.valid?
        comentario.to_json
      else
        422
        { mensaje: 'Error al actualizar el comentario', errores: comentario.errors.full_messages }.to_json
      end
    else
      404
      { mensaje: 'Comentario no encontrado' }.to_json
    end
  end

  def self.destroy(id)
    comentario = Comentario.find(id)
    
    if comentario
        comentario.destroy
      { mensaje: 'Comentario eliminado correctamente' }.to_json
    else
      404
      { mensaje: 'Comentario no encontrado' }.to_json
    end
  end
end