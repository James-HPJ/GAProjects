require('dotenv').config()
const express = require('express')
const session = require("express-session")
const mongoose = require('mongoose')
const methodOverride = require('method-override')

const mongoURI = "mongodb://localhost:27017/snakesdb"
const dbConnection = mongoose.connection

mongoose.connect(mongoURI, {useNewUrlParser: true, useUnifiedTopology: true})

dbConnection.on("connected", () => console.log(" Database is connected"))
dbConnection.on("error", (err) => console.log(err.message))
dbConnection.on("disconnected", () => console.log("Database is disconnected"))


const app = express()

app.use(express.static("public"))
app.use(express.urlencoded({ extended: true }))
app.use(methodOverride("_method"))





const server = app.listen(3000)

process.on("SIGTERM", () => {
  console.log("My process is exiting")
  server.close(() => {
    dbConnection.close()
  })
})