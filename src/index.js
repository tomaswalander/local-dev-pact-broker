#!/usr/bin/env node

import co from 'co'
import prompt from 'co-prompt'
import program from 'commander'

program
  .version('0.0.1')
  .arguments('<file>')
  .option('-u, --username <username>', 'The pact broker username')
  .option('-pwd, --password <password>', 'The pact broker password')
  .option('-c, --consumer <consumer>', 'The name of the consumer')
  .option('-p, --provider <provider>', 'The name of the provider')
  .option('-t, --tag <tag>', 'The name of the consumer')
  // eslint-disable-next-line no-undef
  .parse(process.argv)

/**
   * curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd --data @/Users/twal/Projects/Tier/discount-services/src/pactTest/provider/resources/pacts/discountservicetempconsumer-discountservice.json https://pact-broker.tier-services.io/pacts/provider/DiscountService/consumer/DiscountServiceTempConsumer/version/1.0.0


curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd https://pact-broker.tier-services.io/pacticipants/DiscountServiceTempConsumer/versions/1.0.0/tags/master

curl --verbose --request GET --header "Content-Type: application/json" --user pact_user:pact_pwd https://pact-broker.tier-services.io/pacts/provider/DiscountService


curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd --data @/Users/twal/Projects/Tier/discount-services/src/pactTest/provider/resources/pacts/discountservicetempconsumer-discountservice.json http://localhost:80/pacts/provider/DiscountService/consumer/DiscountServiceTempConsumer/version/1.0.0

curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd http://localhost:80/pacticipants/DiscountServiceTempConsumer/versions/1.0.0/tags/master && curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd http://localhost:80/pacticipants/DiscountServiceTempConsumer/versions/1.0.0/tags/1.0.0 && curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd http://localhost:80/pacticipants/DiscountServiceTempConsumer/versions/1.0.0/tags/1.0.0-2d53e82


curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd --data @/Users/twal/Desktop/platform-pact.json http://localhost:80/pacts/provider/DiscountService/consumer/Platform/version/1.0.0

curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd http://localhost:80/pacticipants/Platform/versions/1.0.0/tags/master && curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd http://localhost:80/pacticipants/Platform/versions/1.0.0/tags/1.0.0 && curl --verbose --request PUT --header "Content-Type: application/json" --user pact_user:pact_pwd http://localhost:80/pacticipants/Platform/versions/1.0.0/tags/1.0.0-2d53e82
   */
