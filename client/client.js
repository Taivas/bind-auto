"use strict";

let config = require('./config.js');

let requestName = process.argv[4];
let action = process.argv[3];
let port = process.argv[2];

//setTimeout(send, 500);
send();

function send() {
    let data = {
        ip: require('ip').address(),
        name: requestName,
        action: action
    };
    let postData = JSON.stringify(data);
    sendReq(postData);
}
function sendReq(data) {
    let options = {
        hostname: 'localhost',
        port: port,
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
