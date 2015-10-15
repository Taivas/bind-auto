"use strict";

let config = require('./config.js');
send();

function send() {
    let data = {
        ip: require('ip').address(),
        name: process.argv[3],
        action: process.argv[2]
    };
    let postData = JSON.stringify(data);
    sendReq(postData);
}

function sendReq(data) {
    let options = {
        hostname: config.dns,
        port: config.port,
        path: '/',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Content-Length': data.length
        }
    };
    let req = require('http').request(options, (res) => {
    });

    req.on('error', function (e) {
        console.log('problem with request: ' + e.message);
    });
    console.log(data);
    req.write(data);
    req.end();
}
