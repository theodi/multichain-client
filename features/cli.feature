Feature: CLI

  Scenario: Get version
    When I run `multichain -v`
    Then the output should contain "multichain version"

  Scenario: Encode a string
    When I successfully run `multichain hexify http://heyre.be/snake/weight.json`
    Then the output should contain "c687474703a2f2f68657972652e62652f736e616b652f7765696768742e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c6231626236383364616438316539366334393938366364633934666331626366"

  Scenario: Decode a string
    When I successfully run `multichain dehexify 313435313933353531367c687474703a2f2f68657972652e62652f636174666163652e6a736f6e7c7b22416363657074223a226170706c69636174696f6e2f6a736f6e227d7c3961356364376261326330646663653536363033356164333132656635333265`
    Then the output should contain "1451935516|http://heyre.be/catface.json|"
    And the output should contain "application/json"
    And the output should contain "|9a5cd7ba2c0dfce566035ad312ef532e"

  Scenario: Verify an entry
    # It's not entirely clear what this means
