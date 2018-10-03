# dockerhub-slack-webhook
[Docker Hub](https://hub.docker.com/) webhook for slack notification after build

![Slack](img/slack.png)

[![CircleCI](https://circleci.com/gh/sue445/dockerhub-slack-webhook.svg?style=svg)](https://circleci.com/gh/sue445/dockerhub-slack-webhook)
[![Coverage Status](https://coveralls.io/repos/github/sue445/dockerhub-slack-webhook/badge.svg?branch=master)](https://coveralls.io/github/sue445/dockerhub-slack-webhook?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/a013ff2962f7a49b77f3/maintainability)](https://codeclimate.com/github/sue445/dockerhub-slack-webhook/maintainability)

## Usage
### 1. Create Incoming WebHook URL
https://slack.com/apps/A0F7XDUAZ-incoming-webhooks

### 2. Create heroku app from following "Deploy to Heroku" button
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

### 3. Register webhook to Docker Hub
Register webhook url

e.g. 

* `https://MY-APP-NAME.herokuapp.com/webhook`
  * Without `channel` query, notify to `SLACK_CHANNEL`
* `https://MY-APP-NAME.herokuapp.com/webhook?channel=other_channel`
  * With `channel` query, notify to specific channel. (`#` is needless)

![Docker Hub](img/dockerhub.png)

### 4. Push image to Docker Hub
