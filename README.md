# Better Home



# Project Walkthrough

Better Home is a web application that allows the user to find a new place to live.

It takes user input regarding their priorities and algorithmically determines

which neighborhoods would suit them best. It bases this decision on the following 

factors:

(1) importance of housing cost;

(2) importance of available means of public transportation;

(3) importance of closeness to points of interest;

(4) importance of walking as a viable means of getting to work;

(5) importance of having a low crime rate.

The application takes user input through a survey, conducts a search of the 

neighborhoods closest to his location, computes the scores for each neighborhood

using the weights given by the user, then presents these neighborhoods in 

descending order. The user is then able to click on each neighborhood's panel,

which redirects them to its own web page. This web page displays more information

about the neighborhood: average cost, crime score, distance of commute to work, 

and nearby points of interest.


## Technological Highlights

I. Framework

Ruby on Rails is a back-end framework for developing modern web applications. It 

follows the Model-View-Controller pattern (MVC) and principles of Representational

State Transfer (REST). The framework serves as the backbone of the project and 

gives it the necessary routing to guide user flow.

II. Geocoder

The survey form contains a search bar that allows the user to input his full 

address. The application then uses this input in a query to Google's Geocoder API.

The API returns a response object containing information about the user's address 

such as its coordinates.

III. Zillow

Zillow takes a request containing State and City and returns a response

containing the neighborhoods within that area. The response also has information

about each neighborhood, particularly its name and 'zestimate', which is

Zillow's estimated average housing cost for it.

IV. Google Maps

With a little bit of javascript, any web application is able to query the Google

Maps API for a visual represantion of an array of locations. Better Home

passes its list of neighborhoods in a script and makes a marker for each one

an initialized map object. The script also adds a listener for each marker

and has an 'on-click' event that reveals the name of the neighborhood on the

map.

V. Factual

The Factual API allows the application to discover the points of interest

surrounding a selected neighborhood. A gem is used to make a query to

the API similar to a SQL query. The application then receives a response




### Prerequisities

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you have to get a development env running

Stay what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* Dropwizard - Bla bla bla
* Maven - Maybe
* Atom - ergaerga

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc

