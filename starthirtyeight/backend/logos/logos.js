
var NumberSchema = require('../models/numberSchema');

const getUserData = (userNumber, res) => {
    console.log('inside lookUpUserNumber');
    NumberSchema.findOne({'userPhoneNumber': userNumber}, (err, userNumberFound)=>{
      if (err) return console.log('there was an error: ', err);
      console.log('found userNumber: ', userNumberFound);
      res.json({message: 'user data found', schema: userNumberFound})
    })
  }

function checkUserData(userNumber){
    console.log('inside checkUserData');
    return new Promise((resolve, _)=>{
        NumberSchema.findOne({'userPhoneNumber': userNumber}, (err, userNumberFound)=>{
            if (err){
                console.log('value of error in checkUserData', err);
                resolve("error");
            }else{
                console.log('value of userNumberFound: ', userNumberFound);
                if(typeof userNumberFound!='undefined' && userNumberFound!=null){
                    console.log('inside if 2 in checkUserData')
                    resolve("number found");
                }else{
                    console.log('inside if 3 in checkUserData')
                    resolve("number not found");
                }
            }
        })
    })
}

const addUserTargetNumber = (userNumber, listID, targetNumber, res) =>{
    console.log('value of listID: ', listID);
    console.log('value of userNumber: ', userNumber);
    console.log('value of targetNumber: ', targetNumber)

    const getCurrentTargets = () => {
        return new Promise(resolve=>{
            NumberSchema.findOne({'targetPhoneNumbers': {$elemMatch: {'_id': listID}}}, (err, userNumberFound)=>{
                userNumberFound.targetPhoneNumbers.forEach(target=>{
                    if (target._id==listID){
                        resolve(target.listNumbers)
                    }
                })
            })
        })
    }

    const findAndUpdate = (currentNumbers) => {
        NumberSchema.findOneAndUpdate(
            {'targetPhoneNumbers': {$elemMatch: {'_id': listID}}},
            {$push: {"targetPhoneNumbers.$.listNumbers": targetNumber}},
            (err, userFoundNumber)=>{
            if (err){
                console.log("there was an error in addUserTargetNumber: ", err);
                res.json({message: 'failed to added target number'})
            }else{
                if (currentNumbers.indexOf(targetNumber)==-1){
                    console.log("currentNumbers.indexOf(userNumber)")
                    console.log(currentNumbers.indexOf(targetNumber));
                    console.log('value of userFoundNumber: ', userFoundNumber)
                    NumberSchema.findOne({'userPhoneNumber': userNumber}, (err, userNumberFound) => {
                        if (err){res.json({message: "there was an error"})}
                        res.json({message: 'successfully added target number', schema: userNumberFound});
                    })
                }else{
                    res.json({message: "didnt add; number already in list"})
                }
            }
        })
    }

    asyncCall = async () => {
        var currentNumbers = await getCurrentTargets();
        console.log('value of currentNumbers: ', currentNumbers);
        findAndUpdate(currentNumbers);
    }

    asyncCall();

}
  
const addUserNumber = (userNumber, res) => {
    console.log('inside addUserNumber');
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
            { $push: { 'targetPhoneNumbers': {'listName': listName, 'listNumbers': [], 'recordingType': recordingType, 'startDate': Date.now(), 'endDate': Date.now(),'timesPerDay': 0} } },
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
    getUserData,
    addUserNumber,
    addUserList,
    checkUserData,
    addUserTargetNumber,
    deleteUserNumber,
    addNewIonCannonNumber,
    deleteIonCannonNumber, 
}