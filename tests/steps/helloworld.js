import { client } from 'nightwatch-api';
import { Given, Then, When } from 'cucumber';
const { expect } = require("chai");
const { setWorldConstructor } = require("cucumber");

class HelloWorld {
  constructor() {
    this.greeting = 'Hi';
    this.scope = 'There';
  }
  say() {
    return this.greeting + ' ' + this.scope;
  }
}

setWorldConstructor(HelloWorld);

Given('a greeting is {string}', async function(string) {
  this.greeting = string;
});

When('I add a scope {string}', async function(string) {
  this.scope = string;
});

Then('the output should say {string}', async function(string) {
  await
    expect(this.say()).to.eql(string);
});

