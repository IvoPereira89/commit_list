# README

## Objective
This app is a rails API app that allows you to fetch commits from github. 
It uses the public Github API and if that fails it falls back to using the git CLI (checking out the project and running `git log`). 

## Setup
* Checkout the project
* Run `bundle install`


## Run it
* Run `rails s`
The app should now be available on port `3000`

* Example: 
  * curl -X GET 'http://localhost:3000/commits?url=https://github.com/google-research/google-research

* You can also pass the page number and page size (page size default = 25)
  * curl -X GET 'http://localhost:3000/commits?url=https://github.com/google-research/google-research&page=2&page_size=10'
