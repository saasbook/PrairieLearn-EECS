# PrairieLearn Assessment Configuration

<a href="https://codeclimate.com/github/fshamji/PrairieLearn-EECS/maintainability"><img src="https://api.codeclimate.com/v1/badges/e2a1dec37bfa6669337a/maintainability" /></a>
[![Build Status](https://travis-ci.com/fshamji/PrairieLearn-EECS.svg?branch=main
)](https://travis-ci.com/fshamji/PrairieLearn-EECS)
<a href="https://codeclimate.com/github/fshamji/PrairieLearn-EECS"><img src="https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/test_coverage" /></a>
<a href="https://www.pivotaltracker.com/n/projects/2487654"><img src="https://github.com/fshamji/PrairieLearn-EECS/blob/main/pivotal_tracker_logo.png" /></a>
[![Bluejay Dashboard](https://img.shields.io/badge/Bluejay-Dashboard_9-blue.svg)](http://dashboard.bluejay.governify.io/dashboard/script/dashboardLoader.js?dashboardURL=https://reporter.bluejay.governify.io/api/v4/dashboards/tpa-CS169L-GH-fshamji_PrairieLearn-EECS/main)

#sp23

<a href="https://app.travis-ci.com/github/cs169/PrairieLearn-EECS"><img src= "https://api.travis-ci.com/cs169/PrairieLearn-EECS.svg?branch=credential"/></a>
<a href="https://codeclimate.com/github/cs169/PrairieLearn-EECS/maintainability"><img src="https://api.codeclimate.com/v1/badges/6a868e48c3002435fe99/maintainability" /></a>
<a href="https://codeclimate.com/github/cs169/PrairieLearn-EECS/test_coverage"><img src="https://api.codeclimate.com/v1/badges/6a868e48c3002435fe99/test_coverage" /></a>
![build](https://github.com/cs169/PrairieLearn-EECS/actions/workflows/main.yml/badge.svg)
---

## Description

PrairieLearn is an online problem driven learning system for creating homeworks and tests capable of adding variations and randomness to questions. We created the assessment configuration interface where instructors could easily synchronize their questions repositories in github and drag-and-drop the selected questions to a new assessment. This application is still a work in progress but we have a working version available through the link below. PrairieLearn Assessment Configuration is a new project started in Spring 2021 by a group of 5 developers in UC Berkeley's CS 169L.

For assessment configuration interface, go to https://prairielearn-eecs.herokuapp.com

For more information regarding PrairieLearn, go to https://prairielearn.readthedocs.io/en/latest

---

## Directory Structure

```bash
.
+-- app
|	+-- models <Container for ActiveRecord Table>
	|	+-- commit.rb
	|	+-- question.rb
	|	+-- user.rb
|	+-- controllers <Actions and Functionality>
	|	+-- login_controller.rb
	|	+-- questions_controller.rb
	|	+-- repo_controller.rb
	|	+-- session_controller.rb
	|	+-- user_controller.rb
|	+-- views <Front-End HTML>
	|	+-- content 
		|	+-- new.html.erb
	|	+-- login <Login and Home/Root Page>
		|	+-- home.html.erb
		|	+-- login.html.erb
	|	+-- questions <Create Assessment Page>
		|	+-- index.html.erb
	|	+-- repo <Choosing Repo Page>
		|	+-- new.html.erb
+-- config
	|	+-- credentials.yml.enc <Encrypted GitHub OAuth Secret>
	|	+-- routes.rb <Ruby Routes for Controllers and Views>
+-- db
	|	+-- migrate <Migration for Database>
+-- features <Cucumber Tests>
+-- spec <RSpec Tests>
	|	+-- controllers
	|	+-- models
+-- Gemfile <List of Required Gem Versions>
+-- README.md
```

---

## How to use the application

- Go to https://prairielearn-eecs.herokuapp.com
- Login to GitHub via 3rd party authentication
- Select a repository you would like to synchronize from the list and click 'Synchronize'; This might take a couple minutes so sit back and relax
- Configure your assessment via the column on the right with all its metadata
- Drag-and-drop questions from the left column to the middle column and set the points for each questions.
- Click 'Export' to download your JSON file
- Logout when you are done using the application

(Video explaining this will be added soon)

---

## Key Features

### Spring 2021:

- GitHub OAuth login to access private questions repositories
- Fetching questions files (path) via GitHub API calls and store them in PostgreSQL database
- Repository caching to limit numbers of GitHub API calls
- Configure assessment metadata including name, type, total credits, and access
- Select a synchronized question repository and fetch questions from the database to populate our questions selection
- Drag-and-drop questions from a list to a 'selected questions' column
- Allowed a single question to be selected multiple time and allow reordering of the questions
- Exporting all configurations and selected questions to a properly formatted JSON file

### Future improvements:

- GitHub API calls are still not optimized (synchronizing repository could take a few minutes)
- Repository caching is not optimized (when a new commit id is found, we drop all entries of questions from that selected repository and pull the new ones)
- Move JavaScript out of .erb files
- Consider using AWS and modify API calls to use 'git pull' to create a traversable file directory instead of making API calls per folder

---

## Steps to Deploy to Heroku:

- `git remote set-url heroku https://git.heroku.com/prairielearn-eecs.git`
- `git add .`
- `git commit -m '<Message>'`
- `git push heroku master`

## Steps to reset PostgreSQL on Heroku:

- Go to https://dashboard.heroku.com/apps/prairielearn-eecs
- Click 'Heroku Postgres' and go to settings
- Click 'Reset Database...'
- Then run `heroku run rake db:migrate`

---

## Design decision on synchronizing questions

The application is making a single API calls for every directory in a repository. The initial path of the API call is to a 'questions' directory of a repository as defined by PrairieLearn documentations. For every file or folder inside 'questions', if the entry is a folder/ directory, the application will make an API call to traverse down that directory until it reaches the end, marked by a .JSON file and the file path is stored in our database. This is inefficient since it is doing a Depth First Search but we are traversing all of the branches; concurrency is difficult to implement. For the future, this could be improved by making concurrent API calls or by using 'git  pull' to build a file directory within the database. After some research, PostgreSQL does not allow this, so try looking into AWS. For more information, email the contributors.

---

## Contributors

- David Oh (klutzx92@berkeley.edu)
- Faiz Shamji (fshamji@berkeley.edu)
- Haolin Zhu (haolinz@berkeley.edu)
- Sanwu Luo (sanwuluo35@berkeley.edu)
- Timotius Vincent (timotiusvincent@berkeley.edu)

---
