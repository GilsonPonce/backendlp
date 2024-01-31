require 'sinatra'
require 'sinatra/base'
require 'rack'
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
    nuevo_producto = {}
    if params[:imagen]
      upload_directory = 'uploads'
      FileUtils.mkdir_p(upload_directory) unless File.exist?(upload_directory)
      image_name = SecureRandom.hex(10) + File.extname(params[:imagen][:filename])
      image_path = File.join(upload_directory, image_name)
      File.open(image_path, 'wb') { |f| f.write(params[:imagen][:tempfile].read) }
      nuevo_producto[:imagen_path] = "/#{image_name}"
    end
    nuevo_producto[:nombre] = params[:nombre]
    nuevo_producto[:modelo] = params[:modelo]
    nuevo_producto[:marca] = params[:marca]
    nuevo_producto[:valor] = params[:valor]
    nuevo_producto[:descuento] = params[:descuento]
    nuevo_producto[:pais] = params[:pais]
    nuevo_producto[:descripcion] = params[:descripcion]
    nuevo_producto[:proveedor] = params[:proveedor]
    nuevo_producto[:cantidad] = params[:cantidad]

    producto = Producto.create(nuevo_producto)

    if producto.valid?
      201
      producto.to_json
    else
      422
      { mensaje: 'Error al crear el producto', errores: producto.errors.full_messages }.to_json
    end
  end

  def self.update(id, params)
    producto = Producto.find(id)

    if producto
      nuevo_producto = {}
      if params[:imagen]
        begin
          File.delete(producto[:image_path])
          puts "Archivo eliminado correctamente."
        rescue Errno::ENOENT
          puts "El archivo no existe."
        rescue => e
          puts "Error al intentar eliminar el archivo: #{e.message}"
        end
        upload_directory = 'uploads'
        FileUtils.mkdir_p(upload_directory) unless File.exist?(upload_directory)
        image_name = SecureRandom.hex(10) + File.extname(params[:imagen][:filename])
        image_path = File.join(upload_directory, image_name)
        File.open(image_path, 'wb') { |f| f.write(params[:imagen][:tempfile].read) }
        nuevo_producto[:imagen_path] = "/#{image_name}"
      end
      nuevo_producto[:nombre] = params[:nombre]
      nuevo_producto[:modelo] = params[:modelo]
      nuevo_producto[:marca] = params[:marca]
      nuevo_producto[:valor] = params[:valor]
      nuevo_producto[:descuento] = params[:descuento]
      nuevo_producto[:pais] = params[:pais]
      nuevo_producto[:descripcion] = params[:descripcion]
      nuevo_producto[:proveedor] = params[:proveedor]
      nuevo_producto[:cantidad] = params[:cantidad]
      producto.update(nuevo_producto)
      
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