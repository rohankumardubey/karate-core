Feature: the difference with variable scoping in 'isolated' and 'shared' mode
    since call is 'pass by reference' you need to clone using 'copy' if needed

Scenario: isolated scope: called feature does not over-write variables
    * def someString = 'before'
    * def someJson = { value: 'before' }
    * def result = call read('copy-called-overwrite.feature')
    * match someString == 'before'
    * match someJson == { value: 'before' }
    * assert typeof fromCalled == 'undefined'

Scenario: shared scope: called feature will over-write (and contribute) variables
    * def someString = 'before'
    * def someJson = { value: 'before' }
    * call read('copy-called-overwrite.feature')
    * match someString == 'after'
    * match someJson == { value: 'after' }
    * match fromCalled == { hello: 'world' }

Scenario: called feature (isolated scope) cannot mutate top-level variables
    * def foo = { key: 'value' }
    # json cannot be mutated in called features if isolated scope
    * def result = call read('copy-called.feature')
    * match foo == { key: 'value' }

Scenario: called feature (shared scope) can mutate top-level variables
    * def foo = { key: 'value' }
    # json can be mutated in called features if shared scope
    * call read('copy-called.feature')
    * match foo == { key: 'changed' }

Scenario: you can manually 'clone' a payload if needed
    * def original = { key: 'value' }
    # since the called feature mutates 'foo' we ensure it is a clone
    * copy foo = original
    * call read('copy-called.feature')
    * match foo == { key: 'changed' }
    # and original remains unchanged
    * match original == { key: 'value' }

Scenario: clone should be 'deep' and work even for nested data
    * def temp = call read('copy-called-nested.feature')
    * def a = temp.root
    * copy b = a
    * set b.name.name = 'copy'
    * match b.name.name == 'copy'
    * match a.name.name == 'inner'