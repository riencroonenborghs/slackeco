# SlackEco

## Credits

Got the idea from this post: [How to Build a Meme Generator Using Twilio MMS, Imgflip and Sinatra](https://www.twilio.com/blog/2014/10/how-to-build-a-meme-generator-using-twilio-mms-imgflip-and-sinatra.html?utm_source=rubyweekly&utm_medium=email).

## Set up

### Server

Clone this repository and set it up on a server somewhere.

Make sure it's accessible from the outside world, because Slack is going to post data to it.

#### Imgflip

[Imgflip](https://imgflip.com/) lets you generate memes. Simple as that. Sign up, you'll need it.

Put your credentials in .env

```
IMGFLIP_USERNAME=username
IMGFLIP_PASSWORD=itsasecret
```


### Slack

Go to your Slack account and set up an outgoing webhook, and have it point to your server. Use trigger words slackmeme: and slackgame:. Also set up an incoming webhook for the channel you want. Put the incoming webhook URL, trigger words and channel in your .env. You can disable the outgoing hook for testing purposes.

```
INCOMING_HOOK=slackurl
MEME_TRIGGER_WORD=slackmeme:
GAME_TRIGGER_WORD=slackgame:
CHANNEL=channel
OUTGOING_HOOK_ENABLED=1
```

## How it works

Slack will post to this app, every time the trigger words are used. 

Based on the trigger words, the app will either:

* generate a meme and post the resulting image back to slack, or 
* it will play rock-paper-scissors

## Memes

```
slackmeme: give me the list please
```
and it will post something like
```
SlackMeme: one does not simply _X_
i dont always _X_ but when I do _Y_
not sure if _X_ or _Y_
what if i told you _X_
brace yourselves _X_
...
```

## Rock-paper-scissors

```
slackgame: rock-paper-scissors: :hand:
```
and it will post something like
```
SlackGame: I have :fist: You win!
...
```

Have fun!