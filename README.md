# cucumber and nighthawk in a box
This image wraps cucumber.js with chrome and firefox for headless e2e tests.

# Usage (quick start for the impatient)
- Create the folders "features" and "steps" somewhere in your home directory
- Create your test feature within the "features" subdirectory
- Enter the directory where you created features and steps
- Run the docker image like this

	docker run --rm -v $PWD:/home/node/tests -eLAUNCH_URL=http://my.host/something -eTEST_ENVIRONMENT=DEV MyLocalTest torstend/cunitest

- Grab the step templates from the resulting output
- Fill in the step implementation in the "steps" subdirectory
- Re-run the docker command from above
- Find the test report in the "report" subdirectory


To explicitely test against chrome

	docker run --rm -v $PWD:/home/node/tests -eLAUNCH_URL=http://my.host/something -eTEST_ENVIRONMENT=DEV MyLocalTest torstend/cunitest npm run test:chrome

To explicitely test against firefox

	docker run --rm -v $PWD:/home/node/tests -eLAUNCH_URL=http://my.host/something -eTEST_ENVIRONMENT=DEV MyLocalTest torstend/cunitest npm run test:firefox


