//Create Squares in the Grid(div in html) using loop
//for 20x20 square, will require 800 squares for grid(400X800)

for(let i=0; i<800; i++){
    const square = document.createElement('div')
    square.className = 'square'
    document.querySelector('#grid').append(square)
}

//Place squares in array so they have an index to reference to

let squares = Array.from(document.querySelectorAll('.square'))

//Set a constant for squares(i.e. 20 squares) in a row for 'catcher' movement

const row = 20

//set shape of catcher in an array, using reference to square array
const catcher = [ 799-(row/2), 799-(row/2)+1, 779-(row/2), 779-(row/2)-1, 779-(row/2)+1, 779-(row/2)+2]

//create a function to draw the catcher during game
function drawCatcher() {
    catcher.forEach(index => {
        squares[index].classList.add('catcher')
    })
}

// drawCatcher()

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

function drawBrick() {
    fallingBrick.forEach(index => {
        if(startPosition + index > (row-1)){
            startPosition = startPosition-(startPosition+index - (row-1))
            squares[startPosition + index].classList.add('brick')
        } else {
            squares[startPosition + index].classList.add('brick')
        }
    })
}

drawBrick()

