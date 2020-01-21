const chromedriver = require('chromedriver');
const geckodriver = require('geckodriver');

module.exports = {
    launch_url: process.env.LAUNCH_URL || "http://localhost/",

    silent: !process.env.NIGHTWATCH_VERBOSE,

    src_folders: [
      "tests"
    ],
  
    webdriver: {
      start_process: true,
      server_path: chromedriver.path,
      port: 4444,
      cli_args: ['--port=4444']
    },

    test_settings: {
      chrome: {
        desiredCapabilities: {
          browserName: "chrome",
          chromeOptions: {
            args: [
              "--headless",
              "--no-sandbox",
              "window-size=1280,1280",
            ]
          }
        },
        "screenshots": {
          "enabled": true,
          "on_failure": true,
          "on_error": true,
          "path": "tests/report/screenshots/"
        },
      },
      firefox: {
        webdriver: {
          server_path: geckodriver.path,
          cli_args: ['--port', '4444', '--log', 'debug' ]
        },
        desiredCapabilities: {
          browserName: 'firefox',
          javascriptEnabled: true,
          acceptSslCerts: true,
          marionette: true,
          "alwaysMatch": {
            "moz:firefoxOptions": {
              "args": ["-headless"]
            }
          }
        }
      }
    }
}
