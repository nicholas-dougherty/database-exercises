#### Early Interactions with
# Structured Query Language (SQL)
***
This directory is the remote repository for SQL assignments.
This is where work for the upcoming module will be branched. 
Initial date: January 6th, 2022. 
***

- "Bad programmers worry about the code. Good programmers worry about data structures and their relationships."
    - Linus Torvalds
***   
During these exercises, data was access via Codeup's MySQL server. 
MySQL is a Relational Database Management System (RDBMS). It stores data in tables, creating relationships among data in multiple tables. Similar to handling multiple spreadsheets and having the data from one sheet use data from another. Unlike spreadsheet programs like Excel or Numbers, relational databases like MySQL are able to manipulate millions of rows rapidly and effectively. 
Relation databases are the most common way to permanently store data, with MySQL as one of the most popular, and most common.
***
### Vocabulary Relevant to this Repository 

- RDBMS: The software that manages the data, i.e. handles it's storage and retrieval. Runs the database server
- Database: Sometimes used interchangably with a DBMS; The actual location of the data stored on disk; You won't interact with this directly, but rather, through the DBMS.
- Database Client: a program that can be used to connect to a database. Each database usually comes with an officially sanctioned command line client, and there are many different GUI database clients as well.
- Database Server: a computer that runs the DBMS and stores the data, typically either on-premises or in the cloud.
- DDL: Data definition language; commands that change the structure of the database or the DBMS itself, or change the structure of tables in the database. We will not be focusing on this part of SQL.
- DML: Data manipulation language; used to insert, update, delete, and retrieve information from databases. We will be focusing on the the retrieval part of this.
***
## Queries

We use the Structured Query Language (SQL) to interact with MySQL.     
SQL is made up of statements and commands sent to the server individually, with results returned to the client. We often think of these statements as asking questions of the server; as in "who are the users named 'jason'?", "how many clients does this seller have?", "what movies were sold between May 5 and October 20?", etc.
Because of this common conceptualization, these statements are generally called queries.
SQL commands fall into several different categories; most notably, DDL and DML. Our focus will be on the retrieval part of the data manipulation language.
***
### Work included here: 
- Tables
- Basic Statements
- Clauses
    - Where, Order by, Limit
- Functions
- Group By
- Relationships
    - Indexes, Joins, Subqueries
- Temporary Tables
- Case Statements
***
***
