# README

## Objective
This app is a rails API app that allows you to fetch commits from github. 
It uses the public Github API and if that fails it falls back to using the git CLI (checking out the project and running `git log`). 

## Setup
* Checkout the project - `git clone https://github.com/IvoPereira89/commit_list.git`
* Go into the directory - `cd commit_list`
* Run `bundle install`


## Run it
From inside the project directory: 

* Run `rails s`
The app should now be available on port `3000`

* Example: 
  * curl -X GET 'http://localhost:3000/commits?url=https://github.com/google-research/google-research

* You can also pass the page number and page size (page size default = 25)
  * curl -X GET 'http://localhost:3000/commits?url=https://github.com/google-research/google-research&page=2&page_size=10'

## Run tests

From inside the project directory: 
* Run `rpsec spec/` - this will run all tests

If you need to run a specific test file do 
* Run `rpsec {FILE_PATH}`
