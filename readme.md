# TestCaseLab Bot

Slack bot for getting notification about different events on the TestCaseLab side


## Technical stack

* ruby: 3.1.2
* sinatra: 3.0.5

## How i can start this bot on local machine?

1.Run bundler:

        bundle

2.Add your env:

        cp .env.example .env

3.Run bot:

        ruby app.rb

## Example of .env file

    SLACK_API_TOKEN=xoxb-<your bot token>

    #need for hashing JWT tokens
    TCL_SECRET=<secret token from TestCaseLab Backend>

    TCL_DOMAIN='http://localhost:3000'

    # 15 days
    EXPIRE_TIME=1682444575

## Slack Settings

1.You need to do it visit site <https://api.slack.com/>

2.Create new app.

* Open Apps page (<https://api.slack.com/apps>).
* Click button "Create New App".
* Click "From Scratch" (default configuration).
* You need Create new workspase as Admin.
* In Scratch select your workspace when you have role Admin.
* Entry name for the app.
* Click "Create app".

3.Setup permissions

* Open "OAuth & Permissions" page (<https://api.slack.com/apps/A0537FH2A9J/oauth?>). When you create yours app at can be another link with another app id.
* Open section "Scopes" and click "Bot Token Scopes".
* Add next scope: chat:write, chat:write.customize, chat:write.public, commands, incoming-webhook, links.embed:write, links:read, links:write (If you need, you can add more alowe permissions).
* Open the page "Basic Information".
* Open the section "Install your app".
* If you make previews steps correct you must have allowe button "Install to Workspace" click there.
* Install your app to new workspace click "Allow".

4.Setup commands.

* If you work on your local mashine you need to settup ngrok service. Instaration here(<https://ngrok.com/>).
* For start ngrok entry the next command (4567 it`s default port for Sinatra):

        ngrok http 4567
* Open the page "Slash Commands" (<https://api.slack.com/apps/A0537FH2A9J/slash-commands?>). When you create yours app at can be another link with another app id.
* Open page (<https://api.slack.com/apps/A0537FH2A9J/app-home>). When you create yours app at can be another link with another app id.
* In this page you need to see section "Show Tabs"
* Click: Allow users to send Slash commands and messages from the messages tab.
* Back to the "Slash Commands" page.
* Click button "Create New Command".
* Create all this commands.

        ngrok server example: https://99e0-46-98-152-116.ngrok-free.app

        Command: /help
        Request URL: <your ngrok server>/help

        Command: /login
        Request URL: <your ngrok server>/login

        Command: /link_project
        Request URL: <your ngrok server>/link_project

        Command: /unlink_project
        Request URL: <your ngrok server>/unlink_project

        Command: /list_projects
        Request URL: <your ngrok server>/list_projects

        Command: /list_event_notifications
        Request URL: <your ngrok server>/list_event_notifications

        Command: /change_status_event
        Request URL: <your ngrok server>/change_status_event

* For production server you need to change to your production address.

4.After all setups you need take bot token

* Open the page "OAuth & Permissions".
* In the section "OAuth Tokens for Your Workspace" copy your bot token and past to the env file.

## More

Youtube: <https://www.youtube.com/watch?v=RHn1UzwLqMw&ab_channel=SupeRails>

___
