@client @attribute_settings

Feature: Set default, normal, and override attributes 
  In order to easily configure similar systems
  As an Administrator
  I want to use different kinds of attributes 

  Scenario: Set a default attribute in a cookbook attribute file
    Given a validated node
      And it includes the recipe 'attribute_settings'
     When I run the chef-client
     Then the run should exit '0'
     Then a file named 'attribute_setting.txt' should contain '1'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '1'

  Scenario: Set the default attribute in a role 
    Given a 'role' named 'attribute_settings_default' exists
      And a validated node
      And it includes the role 'attribute_settings_default'
     When I run the chef-client
     Then the run should exit '0'
      And a file named 'attribute_setting.txt' should contain '2'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '2'
     
  Scenario: Set the default attribute in a recipe 
    Given a 'role' named 'attribute_settings_default' exists
      And a validated node
      And it includes the role 'attribute_settings_default'
      And it includes the recipe 'attribute_settings::default_in_recipe'
     When I run the chef-client
     Then the run should exit '0'
      And a file named 'attribute_setting.txt' should contain '3'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '3'

  Scenario: Set a normal attribute in a cookbook attribute file
    Given a validated node
      And it includes the role 'attribute_settings_default'
      And it includes the recipe 'attribute_settings::default_in_recipe'
      And it includes the recipe 'attribute_settings_normal'
     When I run the chef-client
     Then the run should exit '0'
     Then a file named 'attribute_setting.txt' should contain '4'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '4'

  Scenario: Set a normal attribute in a cookbook recipe 
    Given a validated node
      And it includes the role 'attribute_settings_default'
      And it includes the recipe 'attribute_settings::default_in_recipe'
      And it includes the recipe 'attribute_settings_normal::normal_in_recipe'
     When I run the chef-client
     Then the run should exit '0'
     Then a file named 'attribute_setting.txt' should contain '5'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '5'

  Scenario: Set a override attribute in a cookbook attribute file
    Given a validated node
      And it includes the role 'attribute_settings_default'
      And it includes the recipe 'attribute_settings::default_in_recipe'
      And it includes the recipe 'attribute_settings_normal::normal_in_recipe'
      And it includes the recipe 'attribute_settings_override'
     When I run the chef-client
     Then the run should exit '0'
     Then a file named 'attribute_setting.txt' should contain '6'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '6'

  Scenario: Set the override attribute in a role 
    Given a 'role' named 'attribute_settings_default' exists
      And a 'role' named 'attribute_settings_override' exists
      And a validated node
      And it includes the role 'attribute_settings_default'
      And it includes the recipe 'attribute_settings::default_in_recipe'
      And it includes the recipe 'attribute_settings_normal::normal_in_recipe'
      And it includes the recipe 'attribute_settings_override'
      And it includes the role 'attribute_settings_override'
     When I run the chef-client
     Then the run should exit '0'
      And a file named 'attribute_setting.txt' should contain '7'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '7'
     
  Scenario: Set the override attribute in a recipe 
    Given a 'role' named 'attribute_settings_default' exists
      And a 'role' named 'attribute_settings_override' exists
      And a validated node
      And it includes the role 'attribute_settings_default'
      And it includes the recipe 'attribute_settings::default_in_recipe'
      And it includes the recipe 'attribute_settings_normal::normal_in_recipe'
      And it includes the recipe 'attribute_settings_override'
      And it includes the role 'attribute_settings_override'
      And it includes the recipe 'attribute_settings_override::override_in_recipe'
     When I run the chef-client
     Then the run should exit '0'
      And a file named 'attribute_setting.txt' should contain '8'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '8'

  Scenario: Data is removed from override attribute in a recipe 
    Given a 'role' named 'attribute_settings_override' exists
      And a validated node
      And it includes the role 'attribute_settings_override'
     When I run the chef-client
     Then the run should exit '0'
      And a file named 'attribute_setting.txt' should contain '7'
     When the node is retrieved from the API
     Then the inflated responses key 'attribute_priority_was' should be the integer '7'
    Given a validated node
    Given it includes no recipes
      And it includes the recipe 'no_attributes'
     When I run the chef-client
     Then the run should exit '0'
      And a file named 'attribute_setting.txt' should contain 'snakes'


