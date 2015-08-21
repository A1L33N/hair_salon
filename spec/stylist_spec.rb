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
  



end
