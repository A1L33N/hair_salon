require('spec_helper')

describe(Client) do

    describe "#name" do
      it 'returns the name of the client' do
        client1 = Client.new({:id => nil, :name => 'Arya Stark', :stylist_id => nil})
        expect(client1.name).to eq("Arya Stark")
      end
    end

    describe '.all' do
      it 'is empty at first' do
        expect(Client.all).to eq([])
      end
    end

    describe "#save" do
      it 'saves an client to a list of clients' do
        client1 = Client.new({:id => nil, :name => 'Arya Stark', :stylist_id => 1})
        client1.save
        client2 = Client.new({:id => nil, :name => 'Sansa Stark', :stylist_id => 1})
        client2.save
        expect(Client.all).to eq([client1, client2])
      end
    end

    describe "#==" do
      it 'will determine if a client is equal to another client based on its name and id' do
        client1 = Client.new({:id => nil, :name => 'Arya Stark', :stylist_id => 1})
        client1.save
        client2 = Client.new({:id => nil, :name => 'Arya', :stylist_id => 1})
        client2.save
        expect(Client.all).to eq([client1, client2])
      end
    end

    describe "#delete_client" do
      it 'deletes a client from the list of clients' do
        client1 = Client.new({:id => nil, :name => 'Arya Stark', :stylist_id => 1})
        client1.save
        client2 = Client.new({:id => nil, :name => 'Sansa Stark', :stylist_id => 1})
        client2.save
        client3 = Client.new({:id => nil, :name => 'Bran Stark', :stylist_id => 1})
        client3.save
        client2.delete_client
        expect(Client.all).to eq([client1, client3])
      end
    end

    describe '#update' do
      it 'updates the name and/or stylist_id of a client' do
        client1 = Client.new({:id => nil, :name => 'Arya Stark', :stylist_id => 1})
        client1.save
        client1.update(:name => 'Jon Snow')
        expect(client1.name).to eq('Jon Snow')
        expect(client1.stylist_id).to eq(1)
      end
    end

    describe ".find" do
      it "finds a client by id number" do
        client1 = Client.new({:id => nil, :name => 'Arya Stark', :stylist_id => 1})
        client1.save
        client2 = Client.new({:id => nil, :name => 'Sansa Stark', :stylist_id => 1})
        client2.save
        client3 = Client.new({:id => nil, :name => 'Bran Stark', :stylist_id => 1})
        client3.save
        expect(Client.find(client2.id)).to eq(client2)
      end
    end




  end
