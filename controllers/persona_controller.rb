
require 'sinatra/base'
require 'json'
require_relative '../models/persona'

class PersonasController < Sinatra::Base

  configure do
    set :show_exceptions, false
  end

  def self.index
    personas = Persona.all
    personas.to_json
  end

  def self.show(id)
    persona = Persona.find(id)
    
    if persona
      persona.to_json
    else
      404
      { mensaje: 'Persona no encontrada' }.to_json
    end
  end

  def self.create(request_body)
    nuevo_persona = JSON.parse(request_body, symbolize_names: true)
    persona_encontrada = Persona.where(correo: nuevo_persona[:correo]).first

    if persona_encontrada
      422
      { mensaje: 'Error al crear la persona, Correo repetido', errores: 'Correo repetido' }.to_json
    else
      persona = Persona.create(nuevo_persona)
      if persona.valid?
        201
        persona.to_json
      else
        422
        { mensaje: 'Error al crear la persona', errores: persona.errors.full_messages }.to_json
      end
    end

    
  end

  def self.update(id, request_body)
    persona = Persona.find(id)

    if persona
      datos_actualizados = JSON.parse(request_body, symbolize_names: true)
      persona.update(datos_actualizados)
      
      if persona.valid?
        persona.to_json
      else
        422
        { mensaje: 'Error al actualizar la persona', errores: persona.errors.full_messages }.to_json
      end
    else
      404
      { mensaje: 'Persona no encontrada' }.to_json
    end
  end

  def self.destroy(id)
    persona = Persona.find(id)
    
    if persona
      persona.destroy
      { mensaje: 'Persona eliminada correctamente' }.to_json
    else
      404
      { mensaje: 'Persona no encontrada' }.to_json
    end
  end
end