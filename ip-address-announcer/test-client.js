'use strict';

var messenger = require('rtc-switchboard-messenger');
var signaller = require('rtc-signaller')(messenger('http://barobo.com:42005/'));

signaller.on('error', function(err) {
    console.log('error: ', err);
}).on('connected', function() {
    console.log('connected');
}).on('disconnected', function() {
    console.log('disconnected');
}).on('local:announce', function(peer) {
    console.log('local:announce: ', peer);
}).on('peer:filter', function(id, peer) {
    console.log('peer:filter: ', id, peer);
    peer.allow = peer.allow && peer.hasOwnProperty('type') && peer.type === 'linkbot-hub';
}).on('peer:connected', function(id) {
    console.log('peer:connected: ', id);
}).on('peer:announce', function(peer) {
    console.log('peer:announce: ', peer);
    console.log(peer.ipAddresses);
}).on('peer:update', function(peer) {
    console.log('peer:update: ', peer);
});

var profile = {
    room: process.argv[2],
    type: 'linkbot-labs'
};

signaller.announce(profile);
signaller.connect();
