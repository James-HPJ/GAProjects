const express = require("express");
const snakesModel = require("../models/snakes");
const controller = express.Router();

controller.get('/', (req, res)=> {

    // const snakes = await snakesModel
    // .find()
    // .sort({ dateFound: 'desc'})
    // .limit(6)
    // .exec()

    res.render('webpages/homepage.ejs') 
    // {
    //     snakes,
    // })

})

module.exports = controller