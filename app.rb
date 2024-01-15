require 'sinatra'
require 'mongoid'
require_relative 'models/persona'
require_relative 'controllers/persona_controller'
require_relative 'controllers/pedido_controller'

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






# Ruta para obtener todos los pedidos
get '/pedidos' do
  PedidosController.index
end

# Ruta para obtener un pedido por ID
get '/pedidos/:id' do
  PedidosController.show(params[:id])
end

# Ruta para obtener pedidos por cliente
get '/pedidos/cliente/:cliente_id' do
  PedidosController.por_cliente(params[:cliente_id])
end

# Ruta para crear un nuevo pedido
post '/pedidos' do
  PedidosController.create(request.body.read)
end

# Ruta para actualizar un pedido por ID
put '/pedidos/:id' do
  PedidosController.update(params[:id], request.body.read)
end

# Ruta para eliminar un pedido por ID
delete '/pedidos/:id' do
  PedidosController.destroy(params[:id])
end