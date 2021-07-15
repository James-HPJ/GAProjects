//Create Squares in the Grid(div in html) using loop
//for 20x20 square, will require 800 squares for grid(400X800)

for(let i=0; i<1600; i++){
    const square = document.createElement('div')
    square.className = 'square'
    document.querySelector('#grid').append(square)
}

//Place squares in array so they have an index to reference to

let squares = Array.from(document.querySelectorAll('.square'))

//Set a constant for squares(i.e. 20 squares) in a row for 'catcher' movement

const row = 40

//set shape of catcher in an array, using reference to square array
const catcher = [ 1599-(row/2), 1599-(row/2)+1, 1559-(row/2), 1559-(row/2)-1, 1559-(row/2)+1, 1559-(row/2)+2]

//create a function to draw the catcher during game
function drawCatcher() {
    catcher.forEach(index => {
        squares[index].classList.add('catcher')
    })
}

// drawCatcher()

//create a function to undraw catcher
function undrawCatcher() {
    catcher.forEach(index => {
        squares[index].classList.remove('catcher')
    })
}

//set shape of bricks

const LBrick    = [0,1,2,3]
const MBrick    = [0,1,2]
const SBrick    = [0,1]
const XSBrick   = [0]

const bricks = [LBrick, MBrick, SBrick, XSBrick]

//randomise the appearance of bricks
let fallingBrick = bricks[Math.floor(Math.random()*bricks.length)]

//randomise starting position of bricks

let startPosition = Math.floor(Math.random()*row)

let moveDown = 0
//create function to draw bricks at starting position
function drawBrick() {
    fallingBrick.forEach(index => {
        if(startPosition + index > (row-1)){
            startPosition = startPosition-(startPosition+index - (row-1))
            squares[startPosition + index + moveDown].classList.add('brick')
        } else {
            squares[startPosition + index + moveDown].classList.add('brick')
        }
    })
}

// drawBrick()

// create function to undraw bricks 
function undrawBrick() {
    fallingBrick.forEach(index => {
        if(startPosition + index > (row-1)){
            startPosition = startPosition-(startPosition+index - (row-1))
            squares[startPosition + index].classList.remove('brick')
        } else {
            squares[startPosition + index + moveDown].classList.remove('brick')
        }
    })
}

function descendingBricks() {
    drawCatcher()
    undrawBrick()
    moveDown += 40
    drawBrick()
}

setInterval(descendingBricks, 1000)

