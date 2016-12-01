# Fail2ban Docker

The docker container include two customize jail `normal-request` and `apache-bench`.
When condition was established, The Fail2ban will execute `aws-acl-action` to `ban`/`unban` ip with AWC command.

## How to use

```
# Run 'nginx' container and expose '/var/log/nginx'
docker run -d -p 80:80 --name nginx -v /tmp/log/nginx:/var/log/nginx    

# Run `fail2ban` container with required environments and link `nginx`
docker run -d --link nginx --env AWS_ACCESS_KEY_ID=<access_key> --env AWS_SECRET_ACCESS_KEY=<secret_key> --env ACL_ID=<acl_id> --volumes-from nginx --name=fail2ban shopline/fail2ban    
```

## Where are the logs saved

fail2ban log with `STDOUT`. So we can setup docker `log driver` to collect logs.
