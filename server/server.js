'use strict';

let fs = require('fs');
let express = require('express');
let app = express();
let config = require('./config.js');


let a = JSON.parse('{"sdf": 23}');

let zone = JSON.parse(fs.readFileSync(config.zonefile));
console.log(zone);

app.post('/', function (req, res) {
    console.log(req);
});

app.listen(config.port, () => {
    console.log('Server started: http://:' + config.port + '/');
});
