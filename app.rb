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
  stylist_id = params.fetch('id').to_i
  @stylist = Stylist.find(stylist_id)
  erb(:stylist)
end

delete('/stylist_info/:id') do
  stylist_id = params.fetch('id').to_i
  @stylist = Stylist.find(stylist_id)
  @stylist.delete_stylist
  @all_stylists = Stylist.all
  erb(:stylist_list)
end
