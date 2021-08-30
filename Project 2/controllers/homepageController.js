const express = require("express");
const snakesModel = require("../models/snakes");
const controller = express.Router();

controller.get('/', async (req, res)=> {
    try {
        const snakes = await snakesModel
        .find()
        .sort({ dateFound: 'desc'})
        .limit(3)
        .exec()
    
        res.render('webpages/homepage.ejs',
        {
            snakes,
        })
    } catch(err){
        res.send(err.message)
    }
    

})

module.exports = controller