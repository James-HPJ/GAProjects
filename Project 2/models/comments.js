const mongoose = require('mongoose')

const {Schema} = mongoose

const commentSchema = new Schema (
    {
      snakeId: {
        type: String,
        required: true,
    },

    username: {
        type: String,
        // required: true,
    },

    comment: {
        type: String,
        // required: true,
    },
    },

    {
      timestamps: true,
    }
)

const Comment = mongoose.model('Comment', commentSchema)

module.exports = Comment