class stylist
  attr_reader :id, :name

  define_method(:initialize) do
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

end
