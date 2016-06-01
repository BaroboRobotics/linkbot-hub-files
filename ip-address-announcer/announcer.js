'use strict';

var os = require('os');

var getInterfaces = function () {
    var interfaces = os.networkInterfaces();
    Object.keys(interfaces).filter(function (name) {
        // Only report the interfaces that make sense on the RPi.
        return ['wlan0', 'eth0'].indexOf(name) == -1;
    }).forEach(function (name) {
        delete interfaces[name];
    });
    return interfaces;
}

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
    signaller.to(data.id).send('/interfaces', JSON.stringify(getInterfaces()));
}).on('peer:update', function(data) {
    console.log('peer:update: ', data);
}).on('message:interfaces', function(text) {
    console.log('message:interfaces: ', text);
});

var profile = {
    room: os.hostname(),
    type: 'linkbot-hub',
    interfaces: JSON.stringify(getInterfaces())
};

signaller.announce(profile);
signaller.connect();
