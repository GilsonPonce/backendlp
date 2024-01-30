require 'sinatra'
require 'mongoid'
require 'json'
require 'sinatra/cross_origin'

require_relative 'models/persona'
require_relative 'controllers/persona_controller'

Mongoid.load!('mongoid.yml', :development)

configure do
  enable :cross_origin
end

before do
    puts "ANTES DE RUTA"
    content_type 'application/json'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
end

options '*' do
  response.headers['Allow'] = 'GET, POST, PUT, DELETE, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Credentials'] = 'true'
  200
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

