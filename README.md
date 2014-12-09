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

Go to your Slack account and set up an outgoing webhook, and have it point to your server. Use trigger words `slackmeme:` and `slackgame:`. Also set up an incoming webhook for the channel you want. Put the `incoming webhook URL`, `trigger words` and `channel` in your .env. You can disable the outgoing hook for testing purposes. The `meme list url` is added here too because i'm too lazy to handle it in another way.

```
INCOMING_HOOK=slackurl
MEME_TRIGGER_WORD=slackmeme:
GAME_TRIGGER_WORD=slackgame:
CHANNEL=channel
OUTGOING_HOOK_ENABLED=1
MEME_LIST_URL=http://full.url.to/list
```

## How it works

Slack will post to this app, every time the trigger words are used. 

Based on the trigger words, the app will either:

* generate a meme and post the resulting image back to slack, or 
* it will play rock-paper-scissors

## Memes

### Meme list
```
slackmeme: give me the list please
```
This will post the URL to the list view (full url from your .env). The list view gives an overview of the Top 100 memes of the last 30 days from [Imgflip](https://imgflip.com/), with a name, template image and example how to use it in Slack. 

### Generate a meme
```
slackmeme: meme-name|line1|line2
```
This will generate the meme and post the URL into Slack. Slack will autoload the image and fun will be had. 

`line1` and `line2` are optional (e.g. `meme-name||line2` or `meme-name|line1`)

The `meme-name` is partially matched with the full name from the list (e.g. `Ski|line1|line2` matches the full `Super Cool Ski Instructor|line1|line2`). If more than one name is matched, slackmeme will take the first one.

## Rock-paper-scissors

```
slackgame: rock-paper-scissors: :hand:
```
and it will post 
```
SlackGame: I have :v: You win! (<your name> | 12 games | 2 wins | 4 draws)
...
```

Have fun!