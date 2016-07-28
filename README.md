# Bookmark Manager

## User Stories

```
As a User
So that I can see websites I visit regularly
I want to see a list of links on the homepage

As a User
So that I can view my recent bookmarks
I want to see a list in descending chronological order

As a User
So that I can add a bookmark
I want to be able to add a title and address to the manager

As a User
So that I can group my bookmarks
I want to be able to add tags to my links

As a User
So that I can see my grouped bookmarks
I want to be able to filter links by tag
```

## Rough Domain Model
|   Objects 	|  Messages 	  |
|---        	|---	          |
|     User   	|            	  |
|     Links  	| view_all   	  |
|     Links  	| sort_by   	  |
|     Links  	| add_link   	  |
|     Tags  	| add_tag    	  |
|     Tags  	| filter_by_tag |


What is CRUD?

CRUD is an acronym for create, read, update and delete. CRUD is the four basic functions of persistent storage. It is a way to interact with databases.

What is SQL?

SQL is a structured query language. It lets you access and manipulate databases. It is used by relational databases.

| Operation|SQL|
|----------|---|
|Create | INSERT|
|Read | SELECT|
|Update | UPDATE|
|Delete | DELETE|
