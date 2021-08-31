const mongoose = require('mongoose');

const passportLocalMongoose = require("passport-local-mongoose");


const { Schema } = mongoose;

const userSchema = new Schema(
  {
    username: { type: String, unique: true, required: true },
    password: String, 
  },
  {
    timestamps: true
  }
);

userSchema.plugin(passportLocalMongoose)

const User = mongoose.model("User", userSchema);

module.exports = User;