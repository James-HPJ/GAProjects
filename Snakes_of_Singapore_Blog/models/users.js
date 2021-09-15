const mongoose = require('mongoose');
const findOrCreate = require('mongoose-findorcreate');
const passportLocalMongoose = require("passport-local-mongoose");


const { Schema } = mongoose;

const userSchema = new Schema(
  {
    username: { type: String, unique: true },
    password: String, 
    googleId: String,
  },
  {
    timestamps: true
  }
);

userSchema.plugin(passportLocalMongoose)
userSchema.plugin(findOrCreate)

const User = mongoose.model("User", userSchema);

module.exports = User;