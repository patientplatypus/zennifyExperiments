var express = require('express');
var router = express.Router();

var logos = require('../logos/logos');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/addUserList', function(req,res,next){
  console.log('/addUserList')
  logos.addUserList(req.body.userNumber, req.body.listName, req.body.recordingType, res);
  // res.json({message: "return from /addUserList"})
})

router.post('/getUserData', function(req, res, next){
  console.log('inside /getUserData');
  logos.getUserData(req.body.userNumber, res);
})

router.post('/deleteIonCannonNumber', function(req,res,next){
  console.log('inside /deleteIonCannonNumber');
  logos.deleteIonCannonNumber(req.body.ionCannonNumber, req.body.userNumber, res);
})

router.post('/updateCallTimes', function(req, res, next){
  console.log('inside /updateCallTimes');
  logos.updateCallTimes(req.body.startDate, req.body.endDate, req.body.callTimes, req.body.listID, req.body.userID, res);
})

router.post('/addIonCannonNumber', function(req,res,next){
  console.log('inside /addIonCannonNumber');
  logos.addNewIonCannonNumber(req.body.ionCannonNumber, req.body.userNumber, res);
})

router.post('/addUserTargetNumber', function(req,res,next){
  console.log('inside /addUserTargetNumber');
  console.log('value of userName: ', req.body.userNumber);
  console.log('value of listID: ', req.body.listID);
  console.log('value of targetNumber: ', req.body.targetNumber);
  logos.addUserTargetNumber(req.body.userNumber, req.body.listID, req.body.targetNumber, res);
});

router.post('/deleteUserTargetNumber', function(req,res,next){
  console.log('inside /deleteUserTargetNumber');
  logos.deleteUserTargetNumber(req.body.userNumber, req.body.listID, req.body.targetNumber, res);
});

router.post('/addUserNumber', function(req,res,next){
  console.log('inside /addUserNumber');
  console.log('value of req.body', req.body)

  function setUserNumber(returnNum){
    console.log('inside setUserNumber')
    console.log('value of returnNum: ', returnNum);
    if(returnNum=='number not found'){
      console.log('no number found - adding Number');
      console.log('value of returnNum : ', returnNum);
      logos.addUserNumber(req.body.userNumber, res);
    }else{
      res.json({message: 'user number already exists'})
    }
  }
     
  asyncCall = async () => {
    console.log('beginning of asyncCall')
    setUserNumber(await logos.checkUserData(req.body.userNumber));
  }
  asyncCall();
})

router.post('/deleteUserNumber', function(req,res,next){
  console.log('inside /deleteUserNumber');
  logos.deleteUserNumber(req.body.userNumber, res);
})

router.get('/spinget', function(req,res, next){
  console.log('inside /spinget');
  res.json({message: 'return from /spinget'})
})

router.get('/testget', function(req,res, next){
  console.log('inside /testget');
  res.json({message: 'return from /testget'})
})

module.exports = router;
