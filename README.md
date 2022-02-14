# Complete XMPP > Telegram bridge solution in one docker [ Prosody + telegabber ]

You can now connect all your retro or non standard OS machines to telegram. The setup works on any operating system with XMPP/Jabber supported IM client. You will need spare server or RaspberryPI for this software to run. It will bridge your xmpp connections to telegram.

# Prepare dns

You should setup two dns'es:
* `<maindomain.com>` -> main domain for your xmpp service
* `<media.maindomain.com>` -> host that will be used for media sharing	
For my local intranet i set up these:
* `xmpp.lan` -> you will also need declare it on `.env` file param `MAIN_HOST`
* `media.xmpp.lan` -> you will also need to declare it on `.env` file param `LINK_HOST`

# Run

* Move example environment file: `mv .env-example .env` 
* Edit `.env` file values to suit your needs, Change `MAIN_HOST` and `LINK_HOST` to your corresponding dns setup. Also don't forget to set `API_ID` and `API_HASH` you will get them from https://my.telegram.org/apps
* You can also edit telegabber.yml (docker compose file)
* <del>Build docker images: `make build_libs && make build`<del> not necessary now
* Run docker container: `make up`

Else will be generated automatically..

# Client side

After running docker container connect, register and authenticate:

* Register account
* Subscribe to telegabber JID or write message example.: telegabber.xmpp.lan
* Enter `/login <your phone number>`
* Confirm code sent to telegram via `/code <code>`

You can read more detailed information on the client side [setup here](http://vintage2000.org/telegram_for_old_computers).



<img src="https://github.com/e1z0/telegabber-docker/raw/master/pics/scr1.png" width=30% height=30%>
  
<img src="https://github.com/e1z0/telegabber-docker/raw/master/pics/scr2.png" width=30% height=30%>
  
<img src="https://github.com/e1z0/telegabber-docker/raw/master/pics/scr3.png" width=30% height=30%>
  
<img src="https://github.com/e1z0/telegabber-docker/raw/master/pics/scr4.png" width=30% height=30%>  

Original software used:
* https://dev.narayana.im/narayana/telegabber
* https://tdlib.github.io/td/
* https://prosody.im

Visit us at: http://vintage2000.org
