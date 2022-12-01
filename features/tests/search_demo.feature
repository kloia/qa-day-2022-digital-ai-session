Feature: Search Feature

  @search
  Scenario: Search product and add cart successfully
    Given skip setting page
    When search "dyson" in the search box on home
    And click first search list
    And click second product
    And add the product to cart
    Then verify login page
