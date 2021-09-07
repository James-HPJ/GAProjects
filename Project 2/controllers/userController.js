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
                res.redirect('/members/?login=success')
            })
        }
    })
})

controller.get('/login', (req, res) => {
    const login = req.query.login
    res.render('users/login.ejs', {
        login
    })
})

controller.post('/login', passport.authenticate('local', { successRedirect: '/members/?login=success',
failureRedirect: '/user/login/?login=fail',
})
)

controller.get('/logout', (req, res) => {
    req.logout()
    res.redirect('/')
})



module.exports = controller