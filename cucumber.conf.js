const fs = require('fs');
const { setDefaultTimeout, After, AfterAll, BeforeAll } = require('cucumber');
const {
  createSession,
  closeSession,
  startWebDriver,
  stopWebDriver,
  getNewScreenshots
} = require('nightwatch-api');
const reporter = require('cucumber-html-reporter');

setDefaultTimeout(60000);

BeforeAll(async () => {
  await startWebDriver({ env: process.env.NIGHTWATCH_ENV || 'chrome' });
  await createSession();
});

AfterAll(async () => {
  await closeSession();
  await stopWebDriver();

  setTimeout(() => {
    reporter.generate({
      theme: 'bootstrap',
      jsonFile: 'tests/report/cucumber_report.json',
      output: 'tests/report/cucumber_report.html',
      reportSuiteAsScenarios: true,
      launchReport: false,
      metadata: {
        'Test Environment': process.env.TEST_ENVIRONMENT || 'Test',
      }
    });
  }, 1000);

});

After(function() {
  getNewScreenshots().forEach(file => this.attach(fs.readFileSync(file), 'image/png'));
});
