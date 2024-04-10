See https://certbot.eff.org/instructions?ws=other&os=ubuntuxenial&tab=wildcard

Run those commands in order. After you install the snap, the renew timer should appear by running:

```
systemctl list-timers
```

It is called `snap.certbot.renew.timer`

Next do this:

```
sudo snap install certbot-dns-cloudflare
```

Write to the file `~/cloudflare.ini`:

```
dns_cloudflare_api_token = ...
```

And do `chmod 600 cloudflare.ini`

Now run this:

```
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials ~/cloudflare.ini \
  --dns-cloudflare-propagation-seconds 60 \
  -d example.com -d *.example.com
```

--------

You may need to make a root cron job to put the cert where you want it:

```
cd ~
mkdir cert
cd cert
touch copy.sh
chmod +x copy.sh
nvim copy.sh
```

Then insert something like the following:

```
sudo cp /etc/letsencrypt/live/domain/fullchain.pem /home/username/cert
sudo cp /etc/letsencrypt/live/domain/privkey.pem /home/username/cert
sudo chmod 644 /home/username/cert/privkey.pem
sudo chmod 644 /home/username/cert/fullchain.pem
```

Then you need to do:
```
sudo crontab -e
```

To move the cert every hour, put the following cron job in:

```
0 * * * * /home/username/cert/copy.sh
```

As a test, you can first set the `0` to a `*` to see it run the script every minute.

*Important:*

You need to make sure the app using the cert restarts periodically as well, otherwise it will be stuck using the old cert!

