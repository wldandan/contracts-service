require 'httparty'

class ContractServiceGateway
  include HTTParty

  base_uri 'http://products-service.prod.com'

  def get_products
    parse(JSON.parse(self.class.get("/products").body))
  end

  def parse(products)
    products["_embedded"].each do |_, values|
      values.each do |value|
        value[:title] = "#{value['id']}_#{value['name']}_#{value['price']}"
        value.delete('id')
        value.delete('name')
        value.delete('price')
      end
    end
  end
end
