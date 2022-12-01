product_page = ProductPage.new

And(/^click second product$/) do
  product_page.click_second_product
end

And(/^add the product to cart$/) do
  product_page.add_product_to_cart
end
