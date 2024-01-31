require 'sinatra'
require 'mongoid'
require 'json'
require 'sinatra/cross_origin'

require_relative 'models/persona'

require_relative 'controllers/persona_controller'
require_relative 'controllers/pedido_controller'
require_relative 'controllers/producto_controller'
require_relative 'controllers/comentario_controller'

Mongoid.load!('mongoid.yml', :development)

set :public_folder, File.dirname(__FILE__) + '/uploads'

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






# Ruta para obtener todos los pedidos
get '/pedidos' do
  PedidosController.index
end

# Ruta para obtener un pedido por ID
get '/pedidos/:id' do
  PedidosController.show(params[:id])
end

# Ruta para obtener pedidos por persona
get '/pedidos/persona/:persona_id' do
  PedidosController.por_persona(params[:persona_id])
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





# Ruta para obtener todos los productos
get '/productos' do
  ProductosController.index
end

# Ruta para obtener un producto por ID
get '/productos/:id' do
  ProductosController.show(params[:id])
end

# Ruta para crear un nuevo producto
post '/productos' do
  ProductosController.create(request.body.read)
end

# Ruta para actualizar un producto por ID
put '/productos/:id' do
  ProductosController.update(params[:id], request.body.read)
end

# Ruta para eliminar un producto por ID
delete '/productos/:id' do
  ProductosController.destroy(params[:id])
end




# Ruta para obtener todos los comentarios
get '/comentarios' do
  ComentariosController.index
end

# Ruta para obtener un comentario por ID
get '/comentarios/:id' do
  ComentariosController.show(params[:id])
end

# Ruta para crear un nuevo comentario
post '/comentarios' do
  ComentariosController.create(request.body.read)
end

# Ruta para actualizar un comentario por ID
put '/comentarios/:id' do
  ComentariosController.update(params[:id], request.body.read)
end

# Ruta para eliminar un comentario por ID
delete '/comentarios/:id' do
  ComentariosController.destroy(params[:id])
end
