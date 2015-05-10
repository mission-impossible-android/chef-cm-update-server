var fs = require('fs');
var path = require('path');

var filepath = module.filename;
var filename = filepath.slice(filepath.lastIndexOf(path.sep)+1, filepath.length -3);
var env = filename;

var configFile = __dirname + path.sep + env + '.json';
var configData = JSON.parse(fs.readFileSync(configFile, 'utf8'));

module.exports = configData;
