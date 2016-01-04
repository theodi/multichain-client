Feature: CLI

  Scenario: Get version
    When I run `multichain -v`
    Then the output should contain "multichain version"

