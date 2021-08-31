const express = require("express");
const passport = require("passport");

const User = require('../models/users');

const controller = express.Router();



controller.get('/signup', (req, res) => {
    res.render('users/signup.ejs')
})

controller.post('/signup', (req, res) =>{

     User.register(new User({username: req.body.username}), req.body.password, (err, user)=> {
        if (err){
            console.log(err.message)
            res.redirect('/user/signup')
        } else {
            passport.authenticate('local')(req, res, ()=> {
                res.redirect('/members')
            })
        }
    })
})

controller.get('/login', (req, res) => {
    res.render('users/login.ejs')
})

controller.post('/login', (req, res) =>{
    const user = new User({
        username: req.body.username,
        password: req.body.password
    })

    req.login(user, (err)=> {
        if(err){
            console.log(err.message)
        } else {
            passport.authenticate('local')(req, res, ()=> {
                res.redirect('/members')
            })
        }
    })
})

controller.get('/logout', (req, res) => {
    req.logout()
    res.redirect('/')
})



module.exports = controller