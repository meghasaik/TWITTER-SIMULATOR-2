
					TWITTER SIMULATOR-2
					MEGHA SAI KAVIKONDALA
					UFID: 4754-3974
Functionalities:
This is the Twitter Simulator 2 where using the phoenix framework an UI front end has been created and implemented showing the functionalities of the Simulator
which have been implemented. 
The part 1 of our simulation had registeration, delete, login, logout of the users and subscribing to users, sending tweets having mentions and hashtags and 
getting those tweets. The retweeting part and some of the hashtags part were not working.
In part 2, we have used the same server and backend that acts as an API to the Phoenix channels.
This Server can handle the following currently:
1) Login of a user
2) Registeration of a user
3) Subscribing to other users
4) Logout of a user
5) Tweeting to user
The various other functionalities such as mentions search, hashtag search and tweet search along with the retweeting could not be implemented.

In this part only the individual client part was implemented but not the Running Simulator.

Client part-
The server is accessed by running localhost:4000 in the browser. The websocket is created thus leading to a new user each and every time.
The new user can register himself, login himself, subscribe to other users who have logged in as well as registered. The user can even send
tweets to users who are subscribers to the users.

Run Individual Clients:


		1) Go to assets -> js ->app.js
		2) At the bottom, put import socket from "./socket".
		3) From terminal, run the command : mix phx.server. Once the files have compiled, go to next step.
		4) Open a browser and run localhost:4000. Multiple clients can be run by using multiple webpages.
		5) Once the webpage opens:
		6) Perform the operations specified.
		7) Register the user by giving the username.
		8) Login the user by giving the username.
		9) Subscribe the user to other user clients by giving their username, provided that they must be already registered and loggedin.
		10) Now send a tweet through the subscribed user for tweeting.
		11) Through the logout button provided, the user will be logged out.
		12) You can clear the screen by clicking the clear screen button.

The link of the video is: https://youtu.be/w3c0p6N0sJw












































	
