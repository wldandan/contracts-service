require 'service_providers/pact_helper'
require_relative '../app/contracts_service_gateway'

describe ContractServiceGateway, pact: true do

  before do
    ContractServiceGateway.base_uri 'localhost:8181'
  end

  subject { ContractServiceGateway.new }

  describe 'get_products' do
    before do
      products_service.given('products exist').
          upon_receiving('a request for all products').
          with(method: :get, path: '/products').
          will_respond_with(
              status: 200,
              headers: { 'Content-Type' => 'application/hal+json' },
              body:    {
                        _links: {
                            self: { href: "http://example.org/products" },
                        },
                        count: 2,
                        _embedded: {
                          products: [{id:1, name: 'Docker In Action', price: '59.00'},
                                     {id:2, name: 'Agile In Action',  price: '55.00'}]}
                        }
          )
    end

    it "returns products" do
      expect(subject.get_products).to eq({"products"=>[{:title=>"1_Docker In Action_59.00"},
                                                       {:title=>"2_Agile In Action_55.00"}]})
    end
  end

  describe 'parse' do
    it "parse the data" do
      expect(subject.parse({"_links"=>{"self"=>{"href"=>"http://localhost:9292/products"}},
                            "count"=>2,
                            "_embedded"=>{"products"=>[
                                {"id"=>1, "name"=>"Docker In Action", "price"=>"59.00"},
                                {"id"=>2, "name"=>"Agile In Action", "price"=>"55.00"}]}}))
      .to eq("products" => [{:title=>"1_Docker In Action_59.00"},
                            {:title=>"2_Agile In Action_55.00"}])
    end
  end
end
