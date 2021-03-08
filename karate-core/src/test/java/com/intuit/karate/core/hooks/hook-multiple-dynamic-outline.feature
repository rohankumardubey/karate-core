@tagged
Feature: Test Hook Feature

Background:
  * def cats = [{name: 'cat1'}, {name: 'cat2'}];
  * def dogs = [{name: 'dog1'}, {name: 'dog2'}, {name: 'dog3'}];

Scenario Outline: cats: ${name}
  * match name == "<name>"
  Examples:
    | cats |

Scenario Outline: dogs: ${name}
  * match name == "<name>"
  Examples:
    | dogs |
  @tagged
  Examples:
    | dogs |