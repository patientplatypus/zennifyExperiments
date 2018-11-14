
var NumberSchema = require('../models/numberSchema');

const lookUpUserNumber = (userNumber, res) => {
    console.log('inside lookUpUserNumber');
    var returnNum = null;
    NumberSchema.findOne({'userPhoneNumber': userNumber}, (err, userNumberFound)=>{
      if (err) return console.log('there was an error: ', err);
      console.log('found userNumber: ', userNumberFound);
      res.json({message: 'user data found', schema: userNumberFound})
    })
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

const addUserList = (userNumber, listName, recordingType, res) => {
    console.log('inside addUserList()');
    console.log('test print');

    const updateUserListFunc = () => {
        NumberSchema.findOneAndUpdate(
            { 'userPhoneNumber': userNumber }, 
            { $push: { 'targetPhoneNumbers': {'listName': listName, 'listNumbers': [], 'recordingType': recordingType, 'numberDays': 0, 'timesPerDay': 0} } },
            {new: true, upsert: true},
            (error, success) => {
                if (error) {
                    console.log("there was an error: ", error);
                    res.json({message: 'there was an unknown error!'});
                } else {
                    if(success!=null){
                        console.log("success: ", success);
                        res.json({message: 'addUserList successful', schema: success});
                    }else{
                        console.log('error number not found!');
                        res.json({message: 'user number not found, addUserList not updated'});
                    }
                }
            }
        );
    }

    NumberSchema.findOne({'userPhoneNumber': userNumber}, 
    (error, success)=>{
        if (error){
            console.log('value of error: ', error);
        }else{
            const successLoop = (success) => {
                return new Promise((resolve, reject)=>{
                    if(success.targetPhoneNumbers.length===0){
                        return resolve(true);
                    }else{
                        success['targetPhoneNumbers'].forEach((targets, index)=>{
                            console.log('value of targets')
                            console.log(targets);
                            if (targets.listName===listName){
                                res.json({status: 400, message: 'listName already exists'});
                                resolve(false)
                            }
                            if(index === success['targetPhoneNumbers'].length-1){
                                resolve(true);
                            }
                        });
                    }
                });
            }
            
            asyncCall = async()=>{
                console.log('inside asyncCall()');
                console.log('value of success');
                console.log(success);
                var successBool = await successLoop(success);
                if (successBool){
                    updateUserListFunc();
                }
            }
            asyncCall();
        }
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
    deleteIonCannonNumber, 
    addUserList
}