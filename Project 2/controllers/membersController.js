const express = require("express");
const snakesModel = require("../models/snakes");
const comments = require("../models/comments")
const controller = express.Router();


const multer = require("multer");

// it allows you to choose different storages (disk or memory). Disk is basically on your local harddrive.
// It provides you a couple of functions, one is for choosing the destination, where you want to upload, the other one for defining the filename for the uploaded file
const diskStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./public/images/");
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}_${file.originalname}`);
  }
})

// after you setup multer to choose your disk storage, you can initialize a middleware to use for your routes
const uploadMiddleware = multer({ storage: diskStorage });

// in our case we are using multer in our all routes, this will automatically upload any file where the input name is featuredImage
controller.use(uploadMiddleware.single("img"));

controller.get('/', async (req, res)=> {

    try {
        const snakes = await snakesModel
        .find()
        .sort({ dateFound: 'desc'})
        .exec()

        const login = req.query.login

        const user = req.user.username

        if( req.isAuthenticated() ){
            res.render('webpages/members.ejs',
            {
                snakes,
                login,
                user
            })
        }
       } catch(error){
        res.send(error.message)
    }
})

controller.get('/new', async (req, res)=> {
    if( req.isAuthenticated() ){
        res.render('webpages/membersNew.ejs')
    }
})

controller.get('/:id', async (req, res)=> {
    try {
        const snakes = await snakesModel.find()

        const selectedSnake = await snakesModel.findById(req.params.id)

        const commentsForSnake = await comments.find({ snakeId:req.params.id}).sort({ dateFound: 'ascending'}).exec()

        const edit = req.query.edit

        if( req.isAuthenticated() ){
            res.render('webpages/membersShow.ejs',
            {
                snakes,
                selectedSnake,
                commentsForSnake,
                edit
            })
        }

    } catch (error) {
        res.send(error.message)
    }
})



controller.post('/', async (req, res)=> {
    try {
    
        const snakeInputs = {
            commonName: req.body.commonName,
            scientificName: req.body.scientificName,
            img: `images/${req.file.filename}`,
            dateFound: new Date(req.body.dateFound),
            description: req.body.description,
            location: {
                type: 'Point',
                coordinates:[ req.body.longitude, req.body.latitude]
            },
            username: req.user.username
        }

        await snakesModel.create(snakeInputs)

        res.redirect('/members')
    } catch (error) {
        res.send(error.message)
    }

})

controller.post('/:id', async (req, res)=> {
    try {
        const commentInputs = {
            snakeId: req.params.id,
            username: req.user.username,
            comment: req.body.comment
        }

        await comments.create(commentInputs)

        res.redirect(`/members/${req.params.id}`)
        
    } catch (error) {
        res.send(error.message)
    }
})

controller.get('/:id/edit', async( req, res)=> {
    try {
        const selectedSnake = await snakesModel.findById(req.params.id)

        if( req.isAuthenticated() ){
            res.render('webpages/membersEdit.ejs',
            {
                selectedSnake,
            })
        }

    } catch (error) {
        res.send(error.message)
    }
})

controller.put('/:id', async (req, res)=> {
    try {

        const selectedSnake = await snakesModel.findById(req.params.id)

        if(req.user.username === selectedSnake.username ){

            const snakeInputs = {
                commonName: req.body.commonName,
                scientificName: req.body.commonName,
                img: `images/${req.file.filename}`,
                dateFound: new Date(req.body.dateFound),
                description: req.body.description,
                location: {
                    type: 'Point',
                    coordinates:[ req.body.longitude, req.body.latitude]
                },
            }
    
            await snakesModel.updateOne({
                _id: req.params.id,
              }, snakeInputs);
    
            res.redirect(`/members/${req.params.id}?edit=success`)
        } else {
            res.redirect(`/members/${req.params.id}?edit=fail`)
        }

    } catch (error) {
        res.send(error.message)
    }

})

module.exports = controller