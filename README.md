# dockerhub-slack-webhook
[Docker Hub](https://hub.docker.com/) webhook for slack notification after build

![Slack](img/slack.png)

[![CircleCI](https://circleci.com/gh/sue445/dockerhub-slack-webhook.svg?style=svg)](https://circleci.com/gh/sue445/dockerhub-slack-webhook)
[![docker-gcp](https://github.com/sue445/dockerhub-slack-webhook/actions/workflows/docker-gcp.yml/badge.svg)](https://github.com/sue445/dockerhub-slack-webhook/actions/workflows/docker-gcp.yml)
[![docker-ghcr](https://github.com/sue445/dockerhub-slack-webhook/actions/workflows/docker-ghcr.yml/badge.svg)](https://github.com/sue445/dockerhub-slack-webhook/actions/workflows/docker-ghcr.yml)
[![Coverage Status](https://coveralls.io/repos/github/sue445/dockerhub-slack-webhook/badge.svg?branch=master)](https://coveralls.io/github/sue445/dockerhub-slack-webhook?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/a013ff2962f7a49b77f3/maintainability)](https://codeclimate.com/github/sue445/dockerhub-slack-webhook/maintainability)

## Usage
### 1. Create Incoming WebHook URL
https://slack.com/apps/A0F7XDUAZ-incoming-webhooks

### 2. Deploy Docker image to your environment
This application is provided as a Docker image, so you can run it wherever you like.

#### Images
* [GitHub Container Registry](https://github.com/sue445/dockerhub-slack-webhook/pkgs/container/dockerhub-slack-webhook) **(Recommended)**
  * `ghcr.io/sue445/dockerhub-slack-webhook:latest`: Use latest version
  * `ghcr.io/sue445/dockerhub-slack-webhook:X.Y.Z`: Use specified version
* [Google Artifact Registry](https://console.cloud.google.com/artifacts/docker/dockerhub-slack-webhook/us/dockerhub-slack-webhook/app): If you want to run this app on [Cloud Run](https://cloud.google.com/run), use this image
  * `us-docker.pkg.dev/dockerhub-slack-webhook/dockerhub-slack-webhook/app:latest`: Use latest version
  * `us-docker.pkg.dev/dockerhub-slack-webhook/dockerhub-slack-webhook/app:X.Y.Z`: Use specified version
  * `us-docker.pkg.dev/dockerhub-slack-webhook/dockerhub-slack-webhook/app:edge`: The contents of the main branch are pushed to this tag

#### Available environment variables
* `SLACK_WEBHOOK_URL` **(Required)** : Incoming Webhook URL
* `PUMA_THREADS_MIN` : Puma minimum threads count. default is `0`
* `PUMA_THREADS_MAX` : Puma minimum threads count. default is `5`
* `PUMA_WORKERS` : Puma workers count. default is `1`
* `PUMA_PORT` : Puma port. default is `8080`
* `DEBUG_LOGGING` : If `true` is set, debug logs are output
* `SENTRY_DSN` : [Sentry](https://sentry.io) DSN. This variable is optional. If you want to use Sentry, please set DSN

### 3. Register webhook to Docker Hub
Register webhook url

e.g. 

* `https://example.com/webhook`
  * Without `channel` query, notify to `SLACK_CHANNEL`
* `https://example.com/webhook?channel=other_channel`
  * With `channel` query, notify to specific channel. (`#` is needless)

![Docker Hub](img/dockerhub.png)

### 4. Push image to Docker Hub

## Heroku
This application was offered as a Heroku application, but [since Heroku is ending its free plan](https://blog.heroku.com/next-chapter), I have made it possible to run it outside of Heroku.

So this app can run outside of Heroku.

If you want to run this app on Heroku, browse [heroku branch](https://github.com/sue445/dockerhub-slack-webhook/tree/heroku) and click "Deploy to Heroku" button.
