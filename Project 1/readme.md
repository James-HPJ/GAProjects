**Project Overview**

I was interested in creating 2 games based on the classic bishi bashi arcade game, using <canvas> for my pencil lead game and <div> for the brick catching game. Besides      learning on how to code using these 2 methods, I wanted an understanding of the pros and cons between the different methods. The common technologies that I have used are the usual HTML, CSS and JS methods.
  

**Pencil Game**
  
Methods:
I have used <canvas> to draw the elements and animation require for the game. Canvas is an easy way to visualize drawings (at least in my opinion), as it just uses the Y and X axis as coordinates to draw from point to point. Coding was fairly straight forward, however there is little room to use DOM to manupilate elements around. Hence it feels at some point I am 'hard coding' more than my usual projects.
  
Approach:
Approach was straight forward as well, just drawing the point and setting the distance the pencil lead travels everytime my keypress event happens. Score is updated once the pencil lead reaches a certain point on the Y axis, and the pencil lead is reset to the starting coordinates. 
  
To make the game dynamic, the ejection rate is slowed down by 30% each time a full ejection is completed. This gives an illusion that the losing player has a chance to catch up. Making the game harder as it progresses adds excitement and unpredictability to the game as a whole.
  
I have also learnt how to add sound/music to the gameplay, understanding how sound is embedded to the website and the challenges in recalling the sound objects repeatedly

Challenges faced:
The keypress mechanism for the game required to stop keydown from auto-firing(by default). Had to work around by using e.repeat(which on its on still had some lag) and turning the fire key condition to be false and also resetting this condition when the pencil lead moves by 1 unit. Playing repeated sounds also caused the game to crash and I had initially used cloning methods to rectify this but I find resetting the currenTime back to zero works best.
  
What I could have done better:
CSS could be done better, would had like to use bootstrap if not for a lack in time. The drawings on the canvas could had be done much better as well (when I compare to some other amazing canvas projects). 
  
**Brick Catching Game**
  
Methods:
I have used <div> containers and grid to create the animation and game elements. Much easier to manupilate elements around with DOM, and using classes and ID tags to group similar elements. Graphics have a 8-bit look to them so I reckon performance and rendering wise would not be as efficient as using canvas. Additionaly JS coding needed to create brick arrays and catcher elements. HTML coding is minimal, as HTML elements are basically created using DOM in JS. CSS had a little more work than the pencil game, but other than taking time to adjust position & display attributes the rest was straight forward as well.
  
Approach:
Had to visualise the <div> containers and grids mentally before drawing elements (although I learnt thereafter using MS excel to visualize could help). Setting boundaries of where the bricks and catchers could move till was essential as well. DOM was used to set these boundaries and selecting classes to overlap one another as a condition to enable gameplay.
  
To make the game dynamic, the bricks drop faster each time by 10%. I have also added additonal controls(keys) to move the catcher element faster by 2X, giving the player the choice to use a faster but more difficult to control element. Score is updated when each brick is caught and the score is dsiplay in an alert box once the game ends.
  
Challenges faced: 
Had to spend more time on coding to draw the elements, using arrays(to draw different bricks at random) and DOM(to set the boundaries). More tedious coding compared to canvas method, but if you have a firm grasps on JS and DOM it is fairly easy.
  
What i could have done better:
Make CSS more dynamic(when viewing on different resolutions or devices). Could have improve the coding for score keeping as well, perhaps adding another 'high score' element for the playyer to be reminded of the score to beat.
  
  
Link to the game codes: https://github.com/James-HPJ/GAProjects/tree/main/Project%201
Vectors used from: https://www.freepik.com & https://www.flaticon.com/
Favicon from: https://www.favicon.cc/
Sound & music from: https://mixkit.co/free-sound-effects/game/ & https://www.zapsplat.com/sound-effect-category/game-sounds/
Presentation for this Project(slides) : https://docs.google.com/presentation/d/1humbSja8zTdCk-l-Ut_0KLhF0CqUjUiifgp0iACq2K8/edit?usp=sharing


  

