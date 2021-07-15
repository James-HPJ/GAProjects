//Create Squares in the Grid(div in html) using loop
//for 20x20 square, will require 800 squares for grid(400X800)

for(let i=0; i<800; i++){
    const square = document.createElement('div')
    square.className = 'square'
    document.querySelector('#grid').append(square)
}

//Place squares in array so they have an index to reference to

let squares = Array.from(document.querySelectorAll('.square'))

//Set a constant for squares in a row for 'catcher' movement

const row = 20

const catcher = [ 799-(row/2), 799-(row/2)+1, 779-(row/2), 779-(row/2)-1, 779-(row/2)+1, 779-(row/2)+2]

function drawCatcher() {
    catcher.forEach(index => {
        squares[index].classList.add('catcher')
    })
}

drawCatcher()