# Bulletin board
### Hexlet tests and linter status:
[![Actions Status](https://github.com/PIechik/rails-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/PIechik/rails-project-lvl3/actions)
[![Test and lint](https://github.com/PIechik/rails-project-lvl3/actions/workflows/test-lint.yml/badge.svg)](https://github.com/PIechik/rails-project-lvl3/actions/workflows/test-lint.yml)

### Description
In this bulletin board users can sign in via github and then create new bulletins. Bulletins can be updated, deleted or archived later. Before publishing bulletin to the main page it needs to be send to moderation and be approved by admin. Admin can approve, reject and archive bulletins on the admin panel. Also admin has pages for managing users and categories. Index pages have search forms and pagination.

### Demo
[Heroku](https://bulletin-board-hexlet.herokuapp.com/)

### System requirements
- Ruby
- Node.js
- Yarn
- SQLite3
- Heroku CLI

### Instalation
'''
make install
make migrate
make seed
make start
'''
To run tests and linting
'''
make test
make lint
'''