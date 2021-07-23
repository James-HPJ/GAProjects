//create canvas1
const canvas1 = document.getElementById('my-canvas-1')
const ctx1 = canvas1.getContext('2d')

//create a variable to keep track of player 1 scores
let score1 = 0

//create a function to draw scoreboard1
function drawScore1() {
    ctx1.font = "20px Arial"
    ctx1.fillText("Player 1 score: " + score1, canvas1.width/4, 20)
}

//create canvas2
const canvas2 = document.getElementById('my-canvas-2')
const ctx2 = canvas2.getContext('2d')

//create a variable to keep track of player 2 scores
let score2 = 0;

//create a function to draw scoreboard2
function drawScore2() {
    ctx2.font = "20px Arial"
    ctx2.fillText("Player 2 score: " + score2, canvas2.width/4, 20)
}


//draw Pencil1 
function drawPencil1(){
    ctx1.beginPath()
    ctx1.moveTo(200,25)
    ctx1.lineTo(210,28)
    ctx1.lineTo(140,80)
    ctx1.lineTo(115,90)
    ctx1.lineTo(123,80)
    ctx1.lineTo(200,25)
    ctx1.stroke()
    ctx1.fillStyle = "#336BFF"
    ctx1.fill()
    ctx1.closePath()
}

//set variable of the endpoint for player 1 lead, to be manipulating with event keys
let endPtLead1x = 108
let endPtLead1y = 95

//set variable for change in coordinates after key event
let dx1 = -0.6
let dy1 = 0.4

//draw Lead1
function drawLead1(){
    ctx1.beginPath()
    ctx1.moveTo(115,90)
    ctx1.lineTo(endPtLead1x,endPtLead1y)
    ctx1.stroke()
    ctx1.closePath()
}

//draw pencil2
function drawPencil2(){
    ctx2.beginPath()
    ctx2.moveTo(200,25)
    ctx2.lineTo(210,28)
    ctx2.lineTo(140,80)
    ctx2.lineTo(115,90)
    ctx2.lineTo(123,80)
    ctx2.lineTo(200,25)
    ctx2.stroke()
    ctx2.fillStyle = "#E11F08"
    ctx2.fill()
    ctx2.closePath()
}

//set variable of the endpoint for player 2 lead, to be manipulating with event keys
let endPtLead2x = 108
let endPtLead2y = 95

//set variable for change in coordinates after key event
let dx2 = -0.6
let dy2 = 0.4

//draw Lead2
function drawLead2(){
    ctx2.beginPath()
    ctx2.moveTo(115,90)
    ctx2.lineTo(endPtLead2x, endPtLead2y)
    ctx2.stroke()
    ctx2.closePath()
}


//add event listener for player 1 keys
document.addEventListener("keydown", player1KeyDown, false)
document.addEventListener("keyup", player1KeyUp, false)

//add event listener for player 2 keys
document.addEventListener("keydown", player2KeyDown, false)
document.addEventListener("keyup", player2KeyUp, false)

// default state of keys to be false, until activated
let player1Keys = false
let player2Keys = false


function player1KeyDown(e) {

    console.log('plyer 1 down')

    
 
    if(e.key == "a" || e.key == "s") {
        player1Keys = true

        if(e.repeat){
            player1Keys = false
        }
    } 

}

function player1KeyUp(e) {
    if(e.key == "a" || e.key == "s") {
        player1KeysUp = false

    }
}

function player2KeyDown(e) {
    if(e.key == "k" || e.key == "l") {
        player2Keys = true
    }

    if(e.repeat){
        player2Keys = false
    }

}

function player2KeyUp(e) {
    if(e.key == "k" || e.key == "l") {
        player2Keys = false
    }
}

//add sounds for pencil action
const p1Sound = new Audio('sounds/pencil1.wav')

const p2Sound = new Audio('sounds/pencil2.wav')

const gameMusic = new Audio('sounds/pencilGame.mp3')

function draw() {

    drawPencil1()
    drawLead1()
    drawScore1()


    drawPencil2()
    drawLead2()
    drawScore2()


    if(endPtLead1y + dy1 > 120){
        console.log("ep1")
        ctx1.clearRect(0,0, canvas1.width, canvas1.height)
        score1 +=1
        endPtLead1x = 108
        endPtLead1y = 95
        dx1 /= 1.3
        dy1 /= 1.3
     }
        
    if(player1Keys) {
        
        p1Sound.play()
        p1Sound.currentTime = 0
        endPtLead1x += dx1
        endPtLead1y += dy1
        player1Keys = false
    } 

    if(score1 === 5){
        alert("Player 1 wins!")
        score1 = 0
        score2 = 0
        document.location.reload()
    }

    if(endPtLead2y + dy2 > 120){
        console.log("ep2")
        ctx2.clearRect(0,0, canvas1.width, canvas1.height)
        score2 +=1
        endPtLead2x = 108
        endPtLead2y = 95
        dx2 /= 1.3
        dy2 /= 1.3
     }


    if(player2Keys) {
    
        p2Sound.play()
        p2Sound.currentTime = 0
        endPtLead2x += dx2
        endPtLead2y += dy2
        player2Keys = false
    }
    
    if(score2 === 5){
        alert("Player 2 wins!")
        score1 = 0
        score2 = 0
        document.location.reload()
    }
   

requestAnimationFrame(draw)
}

document.getElementById('start-button').addEventListener('click', function() {
    draw()
    gameMusic.play()
    gameMusic.loop = true
})


