
Complete XMPP > Telegram bridge solution in one docker [ Prosody + telegabber ]

You can now connect all your retro or non standard OS machines to telegram.



You should setup three dns'es. For my local intranet i set up these:
* xmpp.lan .env setting MAIN_HOST
* telegabber.xmpp.lan .env setting BRIDGE_HOST
* media.xmpp.lan .env setting LINK_HOST

# HowTo RUN?

* Move example environment file: `mv .env-example .env`
* Edit .env value to suit your needs, you can also edit telegabber.yml (docker compose file to tune it a little bit)
* Run: `make build_libs && make build`
* Run: `make up`

Else will be generated automatically..

After running docker container connect, register and authenticate:
* Enter JID telegabber.xmpp.lan and sign in
* Enter /login <your phone number>
* Confirm code sent to telegram via /code <code>

Thats all!

![pic1](/pics/scr1.png)
![pic2](/pics/scr2.png)
![pic3](/pics/scr3.png)
![pic4](/pics/scr4.png)
