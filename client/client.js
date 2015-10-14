"use strict";

let config = require('../config.js');
let ip = require('ip');

console.log(ip.address());



let postData = {};

let options = {
    hostname: 'localhost',
    port: config.port,
    path: '/upload',
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': postData.length
    }
};