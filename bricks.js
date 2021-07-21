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

//set a variable speed for the game, so you can increase it on every catch
let speed = 100

//set a variable for the start button to begin the game
const startButton = document.querySelector('#start-button')

//set a variable for the timer which will be used for setInterval
let timer = ''

//set a variable to keep track of scores in #score div
let scoreBoard = document.querySelector('#score')
let score = 0

//set shape of catcher in an array, using reference to square array
const catcher = [ 1599-(row/2), 1599-(row/2)+1, 1559-(row/2), 1559-(row/2)-1, 1559-(row/2)+1, 1559-(row/2)+2]
let catcherPosition = 0
//create a function to draw the catcher during game
function drawCatcher() {
    catcher.forEach(index => {
        squares[index + catcherPosition].classList.add('catcher')
    })
}


//create a function to undraw catcher
function undrawCatcher() {
    catcher.forEach(index => {
        squares[index + catcherPosition].classList.remove('catcher')
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


//create function to undraw bricks 
function undrawBrick() {
    fallingBrick.forEach(index => {
        if(startPosition + index > (row-1)){
            startPosition = startPosition-(startPosition+index - (row-1))
            squares[startPosition + index + moveDown].classList.remove('brick')
        } else {
            squares[startPosition + index + moveDown].classList.remove('brick')
        }
    })
}

//create function to control the catcher's left & right movements, 
// left and right arrows move positions by 1 div, while 'a' and 's' move by 2 divs
function controlCatcher(e) {
    if(e.keyCode === 37) {
        moveLeft(1)
    } else if(e.keyCode === 39) {
        moveRight(1)
    } else if(e.keyCode === 65) {
        moveLeft(2)
    } else if(e.keyCode === 83) {
        moveRight(2)
    }
}

//add listener for keys
document.addEventListener('keydown', controlCatcher)

//function for moving left
function moveLeft(leftSpeed) {
    undrawCatcher()
    const atLeftEnd = catcher.some(index => (index + catcherPosition) % row === 0)
    if(!atLeftEnd) {
        catcherPosition -= leftSpeed
    }
    drawCatcher()
}

//function for moving right
function moveRight(rightSpeed) {
    undrawCatcher()
    const atRightEnd = catcher.some(index => (index + catcherPosition) % row === row -1)
    if(!atRightEnd) {
        catcherPosition += rightSpeed
    }
    drawCatcher()
}

//create a function when the brick touches the catcher
function catchBrick() {
    if(fallingBrick.some(index => squares[startPosition + index + moveDown].classList.contains('catcher') )) {
        undrawBrick()
        score += 50
        scoreBoard.innerHTML = score
        startPosition = Math.floor(Math.random()*row)
        moveDown = 0
        fallingBrick = bricks[Math.floor(Math.random()*bricks.length)]
        clearInterval(timer)
        speed /= 1.1
        timer = setInterval(descendingBricks, speed)
        drawBrick()
    }
}

//function for ending game once brick touches the bottom of the grid
function gameOver() {
    const endPoint = fallingBrick.some(index => (startPosition + index + moveDown) > 1560)
    if(endPoint) {
        console.log('over');
      alert('GAME OVER! You have a score of ' + score + '!')
      clearInterval()
      window.location.reload()
    }
  }

//function for the actual gameplay
function descendingBricks() {
    undrawBrick()
    moveDown += 40
    drawBrick()
    catchBrick()
    gameOver()
}


//listner to start or restart the game with start button
startButton.addEventListener('click', function() {
    if(timer) {
        undrawBrick()
        clearInterval(timer)
        timer = null
    } else {
        drawCatcher()
        startPosition = Math.floor(Math.random()*row)
        moveDown = 0
        fallingBrick = bricks[Math.floor(Math.random()*bricks.length)]
        drawBrick()
        timer = setInterval(descendingBricks, speed)
    }
})

