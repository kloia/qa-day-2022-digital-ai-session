home_page = HomePage.new

When(/^search "([^"]*)" in the search box on home$/) do |product_name|
  home_page.search_product(product_name)
end

And(/^click first search list$/) do
  home_page.click_search_list
end

Then(/^verify login page$/) do
  home_page.verify_open_login_page
end