require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/client")
require("./lib/stylist")
require('pg')
require('pry')

DB = PG.connect({:dbname => "hair_salon_test"})

get("/") do
  erb(:index)
end

get('/stylists') do
  @all_stylists = Stylist.all
  erb(:stylist_list)
end

post('/stylists') do
  stylist_name = params.fetch('new_stylist')
  new_stylist = Stylist.new({:id => nil, :name => stylist_name})
  new_stylist.save
  @all_stylists = Stylist.all
  erb(:stylist_list)
end

get('/stylist_info/:id') do
  @all_stylists = Stylist.all
  @all_clients = Client.all
  stylist_id = params.fetch('id').to_i
  @stylist = Stylist.find(stylist_id)
  erb(:stylist)
end

delete('/stylist_info/:id') do
  stylist_id = params.fetch('id').to_i
  @stylist = Stylist.find(stylist_id)
  @stylist_clients = @stylist.all_clients
  @stylist_clients.each() do |client|
    client.delete_client
  end
  @stylist.delete_stylist
  @all_stylists = Stylist.all
  erb(:stylist_list)
end

patch('/stylist_info/:id') do
  name = params.fetch('name')
  id = params.fetch('id').to_i
  @stylist = Stylist.find(id)
  @stylist.update({:name => name})
  erb(:stylist)
end

get('/clients') do
  @all_stylists = Stylist.all
  @all_clients = Client.all
  erb(:client_list)
end

post('/clients') do
  @all_stylists = Stylist.all
  @all_clients = Client.all
  new_client = Client.new({:id => nil, :name => params.fetch('new_client'), :stylist_id => params.fetch('list_id').to_i})
  new_client.save
  @all_clients = Client.all
  erb(:client_list)
end

get('/client_info/:id') do
  @all_clients = Client.all
  client_id = params.fetch('id').to_i
  @client = Client.find(client_id)
  stylist_id = @client.stylist_id.to_i
  @stylist = Stylist.find(stylist_id)
  erb(:client)
end

delete('/client_info/:id') do
  client_id = params.fetch('id').to_i
  @client = Client.find(client_id)
  @client.delete_client
  @all_clients = Client.all
  erb(:client_list)
end

patch('/client_info/:id') do
  name = params.fetch('name')
  @client = Client.find(params.fetch("id").to_i())
  @client.update(:name => name)
  stylist_id = @client.stylist_id.to_i
  @stylist = Stylist.find(stylist_id)
  erb(:client)

end
