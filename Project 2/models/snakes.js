const mongoose = require('mongoose')

const {Schema} = mongoose

//Schema for point(location) on maps for nesting into main schema
const pointSchema = new Schema({
    type: {
      type: String,
      enum: 'Point',
      required: true
    },
    coordinates: {
      type: [Number],
      required: true
    }
  })

const snakeSchema = new Schema (
    {
        commonName: { type: String, required: true },
        scientificName: String,
        img: String,
        dateFound: { type: Date, default: new Date() },
        description: {type: String, required: true },
        location: {type: pointSchema, /*required: true*/},
        username: { type: String, required: true },        
    },

    {
        timestamps: true,
    }
)

const Snake = mongoose.model('Snake', snakeSchema)


module.exports = Snake
