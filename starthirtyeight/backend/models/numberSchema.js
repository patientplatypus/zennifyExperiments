var mongoose = require('mongoose');

//Define a schema
var Schema = mongoose.Schema;

var NumberSchema = new Schema({
    userPhoneNumber: String,
    targetPhoneNumbers: Array
});

module.exports = mongoose.model('NumberSchema', NumberSchema );