require('spec_helper')

describe(Stylist) do

  describe "#name" do
    it "returns the name of the stylist" do
      stylist1 = Stylist.new({:id => nil, :name => 'Buffy Summers'})
      expect(stylist1.name).to eq('Buffy Summers')
    end
  end

  describe ".all" do
    it 'is an empty array at first' do
      expect(Stylist.all).to eq([])
    end
  end

  describe "#save" do
    it 'save a stylist to the list of stylists' do
      stylist1 = Stylist.new({:id => nil, :name => 'Buffy Summers'})
      stylist1.save
      stylist2 = Stylist.new({:id => nil, :name => 'Lara Croft'})
      stylist2.save
      expect(Stylist.all).to eq([stylist1, stylist2])
    end
  end

  describe "#==" do
    it 'will determine if a stylist is equal to another stylist based on its name and id' do
      stylist1 = Stylist.new({:id => nil, :name => 'Buffy Summers'})
      stylist1.save
      stylist2 = Stylist.new({:id => nil, :name => 'Lara Croft'})
      stylist2.save
      expect(Stylist.all).to eq([stylist1, stylist2])
    end
  end

  describe "#delete_stylist" do
    it 'deletes a stylist from the list of stylists' do
      stylist1 = Stylist.new({:id => nil, :name => 'Buffy Summers'})
      stylist1.save
      stylist2 = Stylist.new({:id => nil, :name => 'Lara Croft'})
      stylist2.save
      stylist3 = Stylist.new({:id => nil, :name => 'Leslie Knope'})
      stylist3.save
      stylist2.delete_stylist
      expect(Stylist.all).to eq([stylist1, stylist3])
    end
  end

  describe '#update' do
    it 'updates the name of a stylist' do
      stylist1 = Stylist.new({:id => nil, :name => 'Buffy Summers'})
      stylist1.save
      stylist1.update(:name => 'Valentine Wiggins')
      expect(stylist1.name).to eq('Valentine Wiggins')
    end
  end






end
