class Client
  attr_reader :id, :name, :stylist_id

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    client_list = []
    returned_clients.each() do |client|
      client_id = client.fetch('id').to_i
      client_name = client.fetch('name')
      stylist_id = client.fetch('stylist_id').to_i
      client = Client.new(:id => client_id, :name => client_name, :stylist_id => stylist_id)
      client_list.push(client)
    end
    client_list
  end

  define_method(:save) do
     result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id}) RETURNING id;")
     @id = result.first.fetch('id').to_i
  end

  define_method(:==) do |another_client|
    self.name == another_client.name && self.id == another_client.id
  end

  define_method(:delete_client) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id};")
  end

  define_method(:update) do |attributes|
      @name = attributes.fetch(:name, @name)
      @styelist_id = attributes.fetch(:styelist_id, @stylist_id)
      @id = self.id
      DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
      DB.exec("UPDATE clients SET stylist_id = '#{@styelist_id}' WHERE id = #{@id};")
  end



end
