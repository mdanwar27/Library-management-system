📚 Library Management System

This Library Management System is designed to manage and track books, authors, publishers, library branches, borrowers, and book loans. It includes structured data in .csv format, a MySQL Workbench ER Diagram (.mwb), and a SQL script for creating the database schema.

📦 File Descriptions

| File Name              | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| authors.csv            | Contains details of book authors (Author ID, Name, etc.)                   |
| books.csv              | Book metadata including title, ISBN, publisher, and author IDs             |
| publisher.csv          | Information about book publishers                                           |
| library branch.csv     | Details of library branches (Branch ID, Name, Address)                      |
| book copies.csv        | Records the number of copies of each book in each branch                        |
| borrower.csv           | Information about borrowers (Card number, Name, Address, Phone)             |
| book loans.csv         | Tracks book lending details, including due dates and return dates            |
| Library Management.sql | SQL script to create all tables and relationships in the MySQL database     |
| ERR Diagram.mwb        | MySQL Workbench ER Diagram representing the schema visually                 |

🛠️ Technologies Used

MySQL for database management

MySQL Workbench for ER diagram modeling

CSV Files for data import/export

SQL for schema creation and database operations

🚀 How to Use

Import the ERR Diagram.mwb in MySQL Workbench to visualize the schema.

Execute Library Management.sql in your MySQL environment to create the schema.

Use the .csv files to populate tables using tools like MySQL Workbench or through custom scripts.

🧩 Relationships (ER Diagram Overview)

The ER diagram outlines key relationships:

Books are written by Authors and published by Publishers.

Each Library Branch holds multiple copies of each Book.

Borrowers can loan Books, and each loan has a due date and return date.

