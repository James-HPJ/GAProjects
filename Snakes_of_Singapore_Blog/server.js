require('dotenv').config()
const express = require('express')
const mongoose = require('mongoose')
const methodOverride = require('method-override')
const session = require('express-session');
const passport = require("passport");

//to require for Google Oauth 2.0
const GoogleStrategy = require('passport-google-oauth20').Strategy

//the findOrCreate function is required to find/create google logins into the website
const findOrCreate = require('mongoose-findorcreate')

const User = require('./models/users')

const homepageController = require('./controllers/homepageController')
const seedingController = require('./controllers/seedingController')
const userController = require('./controllers/userController')
const membersController = require('./controllers/membersController')
const app = express()


app.use(express.static('public'))
app.use(express.urlencoded({ extended: true }))
app.use(methodOverride('_method'))

app.use(session({
  secret: process.env.SECRET,
  resave: false,
  saveUninitialized: false
}))

app.use(passport.initialize())
app.use(passport.session())

const mongoURI = `mongodb+srv://James_admin:${process.env.MONGOPW}@james-mongodb.mcnpc.mongodb.net/snakesDB`
const dbConnection = mongoose.connection


mongoose.connect(mongoURI, {useNewUrlParser: true, useUnifiedTopology: true})

dbConnection.on('connected', () => console.log(' Database is connected'))
dbConnection.on('error', (err) => console.log(err.message))
dbConnection.on('disconnected', () => console.log('Database is disconnected'))



passport.use(User.createStrategy())

passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(id, done) {
  User.findById(id, function(err, user) {
    done(err, user);
  });
});

//google login strategy
passport.use(new GoogleStrategy({
  clientID: process.env.CLIENT_ID,
  clientSecret: process.env.CLIENT_SECRET,
  callbackURL: 'https://snake-blog.herokuapp.com/user/auth/google/members',
  userProfileURL: 'https://www.googleapis.com/oauth2/v3/userinfo'
},
function(accessToken, refreshToken, profile, cb) {
  User.findOrCreate({ googleId: profile.id }, function (err, user) {
    return cb(err, user);
  });
}
));


app.use(homepageController);
app.use('/user', userController)
app.use('/members', membersController)
app.use(seedingController)





const server = app.listen(process.env.PORT || 3000)

process.on('SIGTERM', () => {
  console.log('My process is exiting')
  server.close(() => {
    dbConnection.close()
  })
})