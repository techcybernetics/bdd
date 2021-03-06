
Feature: API Test
  Background:
    Given I setup the uri


  Scenario: Check id for getUser API

    When I call the getUser API
    Then I validate the id
    And I validate the first_name


    Scenario Outline: Check api response for getUser
      When I call the getUser API by "<id>"
      Then I validate the "<firstName>"
      Examples:
      |id|firstName|
      |1 |George   |
  Scenario Outline: Check api response for getUser
    When I call the getUser API by "<id>"
    Then I validate the api response by the json path "<jsonPath>" expected "<value>"
    Examples:
      |id|  jsonPath       |value    |
      |1 | data.last_name,data.first_name,data.email,data.avatar  |  Bluth,George,george.bluth@reqres.in,https://reqres.in/img/faces/1-image.jpg  |


  Scenario Outline: Check api response for post request
    When I call the postRequest API by "<email>" and "<password>"
    Then I validate the api response by the json path "<jsonPath>" expected "<value>"
    Examples:
      |email                  |password|      jsonPath       |value    |
      |eve.holt@reqres.in     |  pistol      | createdAt             |  2020    |


  Scenario Outline: Check api response for put request update
    When I call the putRequest API by "<name>" and "<job>"
    Then I validate the api response by the json path "<jsonPath>" expected "<value>"
    Examples:
      |name        |job                 |      jsonPath               |value    |
      |morpheus    |  zion resident      |      updatedAt             |  2020    |


  Scenario Outline: Check api response for patch request update
    When I call the patchRequest API by "<name>" and "<job>"
    Then I validate the api response by the json path "<jsonPath>" expected "<value>"
    Examples:
      |name        |job                 |      jsonPath               |value    |
      |morpheus    |  zion resident      |      updatedAt             |  2020    |


  Scenario Outline: Check api response for deleteUser
    When I call the deleteUser API by "<id>"

    Examples:
      |id|
      |1 |


   Scenario Outline:  Check api response by path params
     Given I setup the url for path param
     When I call the get request by passing the param "<season>"
     Then I validate the api response by the json path "<jsonPath>" expected "<value>"
     Examples:
     |season    |jsonPath           |value|
     |   2017   | MRData.series     |f1|
     |   2016   | MRData.CircuitTable.season     |2016|
     |   2016   | MRData.CircuitTable.Circuits[0].circuitId  |albert_park|
     |   2016   | MRData.CircuitTable.Circuits[0].Location.country   |Australia|


  Scenario Outline:  Validate circuit ID
    Given I setup the url for path param
    When I call the get request by passing the param "<season>"
    Then I validate the response attribute "<responseAttribute>" by json path "<jsonPath>"

    Examples:
      |season    |responseAttribute   |jsonPath|
      |   2016   |  albert_park, americas, bahrain, BAK|  MRData.CircuitTable.Circuits.circuitId         |
      |   2016   |  catalunya |     MRData.CircuitTable.Circuits.circuitId        |
      |   2016   |  interlagos|   MRData.CircuitTable.Circuits.circuitId       |
      |   2016   |  Australia|   MRData.CircuitTable.Circuits.Location.country  |

  Scenario Outline: Check api response for query param
  Given I setup the url for query param
  When I call the get request by passing the query param "<url>"

      Examples:
      |url|
      |https://www.amazon.com|
      |ebay|
      |softinnovas|
      |america|
      |world|

    # we are testing 2 apis together --> the response of 1 api is the request for the other one



  @api
  Scenario Outline:  Validate country from circuit ID
    Given I setup the url for path param
    When I call the get request by passing the param "<season>"
    # capture the circuit ID from the 1st response
   And I capture the circuit ID from the response
    #pass the circuit ID to the 2nd API as a path param
    And I call the 2nd api with the circuit ID from the previous API response
    #Then validate the country
    Then I validate the country

    Examples:
      |season    |
      |   2017  |












