Feature: CLI

  Scenario: Get version
    When I run `multichain -v`
    Then the output should contain "multichain version"

  Scenario: Encode a string
    When I successfully run `multichain hexify http://heyre.be/snake/weight.json`
    Then the output should contain "c687474703a2f2f68657972652e62652f736e616b652f7765696768742e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c6231626236383364616438316539366334393938366364633934666331626366"

  Scenario: Verify an entry
    # It's not entirely clear what this means
