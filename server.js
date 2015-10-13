'use strict';

let fs = require('fs');
let express = require('express');
let app = express();
let config = require('./config.js');

let zone = JSON.parse(fs.readFileSync(config.zonefile));
console.log(config.port);

app.post();

app.listen(config.port, () => {
    console.log('Server started: http://:' + config.port + '/');
});
