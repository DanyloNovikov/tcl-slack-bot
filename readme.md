# TestCaseLab Bot

Slack bot for getting notification about different events on the TestCaseLab side.
---

### Technical stack:

* ruby: 3.1.2
* sinatra: 3.0.5
* hosting: heroku

---

### How i can start this bot on local machine?

1. Run bundler:


        bundle

2. Add your env:


        cp .env.example .env


4. Run bot:


        ruby app.rb


---

### example .env variable:

    SLACK_API_TOKEN='xoxb-4921674889313-4976906260691-KxZ2Wf64BwsDqu8CU2Em9KD6'
    TCL_SECRET='c5699a5a66a1b7657ff47c9013714816e8fdea1820fd268b8cd0e0cca60e4a8a8dea32818de1ac086de92a3cc2c82c5b2311a3be7cd506b621a47ac6a58f7bb9'
    TCL_DOMAIN='http://localhost:3000'

---
## How to use

Firstly you need create slack bot in https://api.slack.com/apps
and create your slack bot, take token from bot setting with type: `xoxb`.
Then you need insert TCL secret and TCL prod domain.
