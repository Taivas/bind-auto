'use strict';

let express = require('express');
let bodyParser = require('body-parser');
let app = express();
app.use(bodyParser.json());
let config = require('./config.js');
let handle = require('./zone.js').handle;

app.post('/', function (req, res) {
    handle({
        ip: req.body.ip,
        name: req.body.name,
        action: req.body.action
    });
    res.write('done');
    res.end();
});

app.listen(config.port, 'localhost', () => {
    console.log('Server started: http://:' + config.port + '/');
});


