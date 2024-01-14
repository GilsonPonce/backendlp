require 'sinatra'
require 'mongoid'
require_relative 'models/persona'
require_relative 'controllers/persona_controller'

Mongoid.load!('mongoid.yml', :development)

before do
    content_type 'application/json'
end

get '/' do
    'Hello world!'
end

# Ruta para obtener todos los personas
get '/personas' do
  PersonasController.index
end

# Ruta para obtener un persona por ID
get '/personas/:id' do
  PersonasController.show(params[:id])
end

# Ruta para crear un nuevo persona
post '/personas' do
  PersonasController.create(request.body.read)
end

# Ruta para actualizar un persona por ID
put '/personas/:id' do
  PersonasController.update(params[:id], request.body.read)
end

# Ruta para eliminar un persona por ID
delete '/personas/:id' do
  PersonasController.destroy(params[:id])
end

