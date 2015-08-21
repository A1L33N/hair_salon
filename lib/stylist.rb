class Stylist
  attr_reader :id, :name

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylist_list = []
    returned_stylists.each() do |stylist|
      stylist_id = stylist.fetch('id').to_i
      stylist_name = stylist.fetch('name')
      stylist = Stylist.new(:id => stylist_id, :name => stylist_name)
      stylist_list.push(stylist)
    end
    stylist_list
  end

  define_method(:save) do
     result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
     @id = result.first.fetch('id').to_i
  end

  define_method(:==) do |another_stylist|
    self.name == another_stylist.name && self.id == another_stylist.id
  end

  define_method(:delete_stylist) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id};")
  end

  define_method(:update) do |attributes|
      @name = attributes.fetch(:name, @name)
      @id = self.id
      DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_singleton_method(:find) do |id_number|
    found_stylist = nil
    Stylist.all.each() do |stylist|
      if stylist.id == id_number
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:all_clients) do
    results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id}")
    returned_clients = []
    results.each() do |client|
      client_id = client.fetch('id').to_i
      client_name = client.fetch('name')
      stylist_id = client.fetch('stylist_id').to_i
      returned_clients.push(Client.new({:id => client_id, :name => client_name, :stylist_id => stylist_id}))
    end
    returned_clients
  end

  define_method(:find_client) do |search_client|
    found_client = nil
    stylist_clients = self.all_clients
    stylist_clients.each() do |client|
      if search_client == client.name 
        found_client = client
      end
    end
    found_client
  end


end
