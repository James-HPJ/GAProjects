const express = require("express");
const snakesModel = require("../models/snakes");
const controller = express.Router();

controller.get('/', async (req, res)=> {

    const snakes = await snakesModel
    .find()
    .sort({ dateFound: 'desc'})
    .limit(3)
    .exec()

    res.render('webpages/homepage.ejs',
    {
        snakes,
    })

})

module.exports = controller