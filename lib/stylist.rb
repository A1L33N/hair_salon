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






end
