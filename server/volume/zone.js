"use strict";

exports.handle = handle;

let fs = require('fs');
let config = require('./config.js');

let zone = JSON.parse(fs.readFileSync(config.zonejsonfile));

function add(host) {
    zone.a.push({
        name: host.name,
        ip: host.ip
    });
}
function del(host) {
    let length = zone.a.length;
    let i = 0;
    while (i < length) {
        if (zone.a[i].name === host.name && zone.a[i].ip === host.ip) {
            zone.a.splice(i, 1);
            length -= 1;
        } else {
            i += 1;
        }
    }
}
function handle(host) {
    host = host || {};
    process.stdout.write(JSON.stringify(host));
    if (host.action === 'add') {
        add(host);
    } else if (host.action === 'del') {
        del(host);
    }
    genConfigAndReloadBind();
}

function genConfigAndReloadBind() {
    fs.writeFileSync(config.zonejsonfile, JSON.stringify(zone, null, 4));
    try {
        require('child_process').execFileSync('./reloadZoneFile.sh');
        process.stdout.write("  success\n");
    } catch (e) {
        process.stdout.write("  fail\n");
    }
}

