
var NumberSchema = require('../models/numberSchema');

const lookUpUserNumber = (userNumber) => {
    console.log('inside lookUpUserNumber');
    var returnNum = null;
    NumberSchema.findOne({'userPhoneNumber': userNumber}, (err, userNumberFound)=>{
      if (err) return console.log('there was an error: ', err);
      console.log('found userNumber: ', userNumberFound);
      returnNum = userNumber;
    })
    return returnNum;
  }
  
const createNewUserNumber = (userNumber, res) => {
    console.log('inside createNewUserNumber');
    var newNumber = new NumberSchema(
      {
          userPhoneNumber: userNumber,
          targetPhoneNumbers: []
      }
    );
  
    newNumber.save(function (err) {
        if (err) {
            return next(err);
        }
        res.send('Number inserted successfully')
    })
  }

const deleteUserNumber = (userNumber, res) => {
    console.log('inside deleteUserNumber');
    NumberSchema.findOneAndRemove({
        'userPhoneNumber': userNumber
    }, function(err, data) {
        if (err) return res.json({message: 'there was an error in deleting userNumber'})
        res.json({
            message: `deleted ${userNumber}`
        })
    });
}

const addNewIonCannonNumber = (ionNumber, userNumber, res) => {
    console.log('inside addNewIonCannonNumber');
    NumberSchema.findOneAndUpdate(
    { 'userPhoneNumber': userNumber }, 
    { $push: { 'targetPhoneNumbers': ionNumber } },
    {new: true},
    (error, success) => {
            if (error) {
                console.log("there was an error: ", error);
                res.json({message: 'there was an unknown error!'});
            } else {
                if(success!=null){
                    console.log("success: ", success);
                    res.json({message: 'success ion Cannon array updated'});
                }else{
                    console.log('error number not found!');
                    res.json({message: 'user number not found, ionCannon array not updated'});
                }
            }
        }
    );
}

const deleteIonCannonNumber = (ionNumber, userNumber, res) => {
    console.log('inside deleteIonCannonNumber');
    NumberSchema.updateMany(
        { 'userPhoneNumber': userNumber }, 
        { $pull: { 'targetPhoneNumbers': ionNumber } },
        {new: true},
        (error, success) => {
            if (error) {
                console.log("there was an error: ", error);
                res.json({message: 'there was an unknown error!'});
            } else {
                if(success!=null){
                    console.log("success: ", success);
                    res.json({message: 'success ion Cannon array updated'});
                }else{
                    console.log('error number not found!');
                    res.json({message: 'user number not found, ionCannon array not updated'});
                }
            }
        }
    );
}

module.exports = {
    lookUpUserNumber,
    createNewUserNumber,
    deleteUserNumber,
    addNewIonCannonNumber,
    deleteIonCannonNumber
}