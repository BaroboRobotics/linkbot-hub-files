## Linkbot Hub IP Address Announcer

To broadcast a Linkbot Hub's network interfaces:

```
while true; do
    node announcer.js
    sleep 1
done
```

To test if it's working:

```
node test-client.js
```

You should see a list of network interface data.
