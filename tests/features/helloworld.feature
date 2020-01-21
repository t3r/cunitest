# features/helloworld.feature
Feature: Say hello world
  In order start something
  As a developer
  I want to say "hello world"

  Scenario: hello world
    Given a greeting is "hello"
    When I add a scope "world"
    Then the output should say "hello world"
