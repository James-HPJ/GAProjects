const express = require("express");
const snakesModel = require("../models/snakes");
const controller = express.Router();


controller.get('/', async (req, res)=> {

    try {
        const snakes = await snakesModel
        .find()
        .sort({ dateFound: 'desc'})
        .exec()

        if( req.isAuthenticated() ){
            res.render('webpages/members.ejs',
            {
                snakes,
            })
        }
       } catch(err){
        res.send(err.message)
    }
})


module.exports = controller