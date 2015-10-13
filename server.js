
var fs = require('fs');
var express = require('express');
var app = express();
var config = require('./config.js');

console.log(config.port);

app.listen(config.port, () => {
    console.log('Server started: http://localhost:' + config.port + '/');
});
