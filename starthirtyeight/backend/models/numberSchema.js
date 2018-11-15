var mongoose = require('mongoose');

//Define a schema
var Schema = mongoose.Schema;

var NumberSchema = new Schema({
    userPhoneNumber: String,
    targetPhoneNumbers: [
        {
            listName: String,
            recordingType: String,
            timesPerDay: Number,
            startDate: Date,
            endDate: Date,
            listNumbers: Array
        }
    ]
});

module.exports = mongoose.model('NumberSchema', NumberSchema );