const mongoose = require('mongoose')

const {Schema} = mongoose

//Schema for point(location) on maps for nesting into main schema
const pointSchema = new Schema({
    type: {
      type: String,
      default: 'Point',
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
        location: {type: pointSchema, index: '2dsphere'},
    },

    {
        timestamps: true,
    }
)

const Snake = mongoose.model('Snake', snakeSchema)

module.exports = Snake