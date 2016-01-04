Feature: CLI

  Scenario: Get version
    When I run `multichain -v`
    Then the output should contain "multichain version"

  Scenario: Encode a string

  Scenario: Verify an entry
    # It's not entirely clear what this means
