require 'httparty'

class ContractServiceGateway
  include HTTParty

  base_uri 'http://products-service.prod.com'

  def get_products
    JSON.parse(self.class.get("/products").body)
  end
end
