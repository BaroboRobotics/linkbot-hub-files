'use strict';

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
}).on('peer:update', function(data) {
    console.log('peer:update: ', data);
}).on('message:interfaces', function(text) {
    console.log('message:interfaces: ', text);
});

signaller.announce({ room: process.argv[2] });
signaller.connect();
