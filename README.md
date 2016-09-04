# Better Home
- - -

##[DEMO](https://github.com/jsteenb2/better_home/blob/master/demo.md)
##[DEPLOYED APP](https://boiling-eyrie-10872.herokuapp.com)

# Project Walkthrough

**Better Home** is a web application that recommends nearby neighborhoods to the user based on their priorities in life.

**Better Home** algorithmically determines which neighborhoods would suit them best. It bases this decision on the following criteria:

1. importance of housing cost;
2. importance of available means of public transportation;
3. importance of closeness to points of interest;
4. importance of walking as a viable means of getting to work;
5. importance of having a low crime rate.

The application takes user input through a survey and looks for neighborhoods around a point of interest. Our algorithm computes the scores and matches the user with the most compatible neighborhoods.

Each neighborhood has a panel which responds to a click event by revealing the neighborhood's name on Google Maps. A 'more details' button which redirects the user to the neighborhood's show page is likewise present.

The show page displays pertinent information such as a breakdown of its scores, average home cost, recent crime statistics, and the like.


## Technological Highlights
- - -

###I. Ruby on Rails

Ruby on Rails is a back-end framework for developing modern web applications. It follows the Model-View-Controller pattern (MVC) and adheres to the principles of Representational State Transfer (REST). This framework allowed the team to run API calls and serve curated information to the user. The framework serves as the backbone of the project and provides the necessary routing to guide user flow.

###II. APIs

####Geocoder

The survey form contains a search bar that allows the user to input a desired address, which is normally a place of work. The application then uses this input to query Google's Geocoder API. The API returns a response object containing information about the user's address.

####Zillow

Zillow takes a request containing State and City and returns a response containing the neighborhoods within that area. The response also provides information about each neighborhood, particularly its name and 'zestimate': Zillow's average housing cost estimate.

####Google Maps

Better Home passes the list of neighborhoods in a script and makes a marker for each one an initialized map object. The script also adds a listener for each marker and has an 'on-click' event that reveals the name of the neighborhood on the map. The map is the main feature of the results page.

####Factual

The Factual API provides Better Home with the points of interest surrounding a selected neighborhood. A gem is used to make a query to the API similar to a SQL query. The application then receives a response and is matched to the neighborhood in the show page.

####Yelp

The Yelp api synchronizes with the factual results and provides our user a very detailed view of the neighborhood's surroundings. Any high rated point of interest is provided to the end user.

####Socrata

Demographic information for each neighborhood was obtained using the Socrata API. The data is obtained, then the necessary mathematical manipulation was added.

###III. User Experience

Used Devise and Omniauth gems to set up user accounts, email confirmation, and login via facebook, twitter, or google.

###Optimzations

User experience was initially very bad as a number of API calls were being made each time a results page was initiated. A number of API were completely eliminated by cacheing some API calls.  We also eliminated a large chunk of API calls by writing our own haversine script to calculate distance between lat and lon coordinates.  This eliminated about 180 API calls!  With the constant speed of the haversine formula and the caching of part of our API calls we are able to give the user a very speedy response.

Rake tasks are included and scheduled to run every day at 02:00 to update the crime statistics and other demographic information obtained through **Socrata**.  Heroku's **Scheduler** add on.

**SendGrid** addon for Heroku was used in correlation with **delayed jobs** to send emails asynchronously.

## Prerequisites

You will need a modern web browser with ad-blockers turned off (we thank you and promise we are not going to fill your screen with obnoxious ads!).



## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* Heroku - Ruby on Rails, utilizing the SendGrid and delayed jobs to run the worker dynos
* Bootstrap
* JS
* Atom - ergaerga

## Authors

* [**Johnny Steenbergen**](https://github.com/jsteenb2)
* [**CJ Virtucio**](https://github.com/cjvirtucio87)
* [**Phil Johnson**](https://github.com/philipcolejohnson)
* [**Graham Turner**](https://github.com/tgturner)
* [**Adrian Mui**](https://github.com/adrianmui)
* [**Dylan Lynch**](https://github.com/lynchd2)


## Acknowledgments

* We tip our hats to Viking Code School for pushing us to develop the skills we need to be successful full stack developers.
