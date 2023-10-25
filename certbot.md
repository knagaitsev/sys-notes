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
  -d example1.com -d example2.com
```
