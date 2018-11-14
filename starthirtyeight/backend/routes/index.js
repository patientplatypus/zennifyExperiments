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
  logos.lookUpUserNumber(req.body.userNumber, res);
})

router.post('/deleteIonCannonNumber', function(req,res,next){
  console.log('inside /deleteIonCannonNumber');
  logos.deleteIonCannonNumber(req.body.ionCannonNumber, req.body.userNumber, res);
})

router.post('/addIonCannonNumber', function(req,res,next){
  console.log('inside /addIonCannonNumber');
  logos.addNewIonCannonNumber(req.body.ionCannonNumber, req.body.userNumber, res);
})

router.post('/addUserNumber', function(req,res,next){
  console.log('inside /addUserNumber');
  console.log('value of req.body', req.body)
  var returnNum = logos.lookUpUserNumber(req.body.userNumber);
  if (returnNum==null){
    console.log('no number found - adding Number')
    logos.createNewUserNumber(req.body.userNumber, res);
  }else{
    res.json({message: returnNum})
  }
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
