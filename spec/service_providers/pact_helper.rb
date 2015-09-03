require "pact/consumer/rspec"

Pact.service_consumer 'Contracts Service' do
  has_pact_with 'Products Service' do
    mock_service :products_service do
      port 8181
    end
  end
end
