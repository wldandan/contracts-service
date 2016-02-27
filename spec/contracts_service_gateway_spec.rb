require 'service_providers/pact_helper'
require_relative '../app/contracts_service_gateway'

describe ContractServiceGateway do

  subject { ContractServiceGateway.new }

  describe 'get_products' do

    it "returns products" do
      expect(subject.get_products).to eq({"products"=>[{:title=>"1_Docker In Action_59.00"},
                                                       {:title=>"2_Agile In Action_55.00"}]})
    end
  end
end
