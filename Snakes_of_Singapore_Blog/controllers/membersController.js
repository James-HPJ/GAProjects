const express = require("express");
const controller = express.Router();

const snakesModel = require("../models/snakes");
const comments = require("../models/comments")

const multer = require("multer");

const diskStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./public/images/");
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}_${file.originalname}`);
  }
})

const uploadMiddleware = multer({ storage: diskStorage });

controller.use(uploadMiddleware.single("img"));


//index route
controller.get('/', async (req, res)=> {

    try {
        const snakes = await snakesModel
        .find()
        .sort({ dateFound: 'desc'})
        .exec()

        const login = req.query.login

        const destroy = req.query.delete 

        const user = req.user.username

        if( req.isAuthenticated() ){
            res.render('webpages/members.ejs',
            {
                snakes,
                login,
                user,
                destroy
            })
        }
       } catch(error){
        res.send(error.message)
    }
})

//new route
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


//create route - for new snakes
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

//create route - for new comments
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

//edit route
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

//update route
controller.put('/:id', async (req, res)=> {
    try {

        const selectedSnake = await snakesModel.findById(req.params.id)

        if(req.user.username === selectedSnake.username ){

            const snakeInputs = {
                commonName: req.body.commonName,
                scientificName: req.body.commonName,
                dateFound: new Date(req.body.dateFound),
                description: req.body.description,
                location: {
                    type: 'Point',
                    coordinates:[ req.body.longitude, req.body.latitude]
                },
            }

            if(req.file) {
                const image = req.file.filename
                snakeInputs.img = `images/${image}`
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

//destroy route
controller.delete("/:id", async (req, res) => {
    
    const selectedSnake = await snakesModel.findById(req.params.id)

    if(req.user.username === selectedSnake.username ){

    await snakesModel.deleteOne({
      _id: req.params.id
    });
  
    res.redirect(`/members/?delete=success`);
     } else {
        res.redirect(`/members?delete=fail`)
    }
});
  

module.exports = controller