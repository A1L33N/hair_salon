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

end
