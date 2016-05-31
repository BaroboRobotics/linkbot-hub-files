'use strict';

var os = require('os');
var ifaces = os.networkInterfaces();

// From StackOverflow, shows how we can pare down the interface spam
/*
Object.keys(ifaces).forEach(function (ifname) {
  var alias = 0;

  ifaces[ifname].forEach(function (iface) {
    if ('IPv4' !== iface.family || iface.internal !== false) {
      // skip over internal (i.e. 127.0.0.1) and non-ipv4 addresses
      return;
    }

    if (alias >= 1) {
      // this single interface has multiple ipv4 addresses
      console.log(ifname + ':' + alias, iface.address);
    } else {
      // this interface has only one ipv4 adress
      console.log(ifname, iface.address);
    }
    ++alias;
  });
});
*/

var messenger = require('rtc-switchboard-messenger');
var signaller = require('rtc-signaller')(messenger('http://barobo.com:42005/'));

signaller.on('error', function(err) {
    console.log('error: ', err);
}).on('connected', function() {
    console.log('connected');
}).on('disconnected', function() {
    console.log('disconnected');
}).on('local:announce', function(data) {
    console.log('local:announce: ', data);
}).on('peer:filter', function(id, data) {
    console.log('peer:filter: ', id, data);
}).on('peer:connected', function(id) {
    console.log('peer:connected: ', id);
}).on('peer:announce', function(data) {
    console.log('peer:announce: ', data);
    signaller.to(data.id).send('/interfaces', JSON.stringify(ifaces));
}).on('peer:update', function(data) {
    console.log('peer:update: ', data);
}).on('message:interfaces', function(text) {
    console.log('message:interfaces: ', text);
});

signaller.announce({ room: 'linkbot-labs' });
signaller.connect();
