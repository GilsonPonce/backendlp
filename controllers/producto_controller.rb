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

  def self.create(request_body,params)
    nuevo_producto = JSON.parse(request_body, symbolize_names: true)
    
    if params[:imagen]
    # Directorio donde se guardarán las imágenes (ajústalo según tus necesidades)
    upload_directory = File.join(settings.public_folder, 'uploads')

    # Asegúrate de que el directorio exista
    FileUtils.mkdir_p(upload_directory) unless File.exist?(upload_directory)

    # Genera un nombre único para la imagen
    image_name = SecureRandom.hex(10) + File.extname(params[:imagen][:filename])

    # Guarda la imagen en el directorio de subidas
    image_path = File.join(upload_directory, image_name)
    File.open(image_path, 'wb') { |f| f.write(params[:imagen][:tempfile].read) }

    # Asocia la ruta de la imagen con el producto
    request_body[:imagen_path] = "/uploads/#{image_name}"
  end
    
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