create database library;
use library;
create table tbl_publisher (
publisher_PublisherName varchar(100) not null primary key,
publisher_PublisherAddress varchar(255),
publisher_PublisherPhone varchar(15)
);
select * from tbl_publisher;



create table tbl_borrower(
borrower_CardNo int auto_increment primary key,
borrower_BorrowerName varchar(255) not null,
borrower_BorrowerAddress varchar(255), 
borrower_BorrowerPhone varchar(50)
) auto_increment = 100;

select * from tbl_borrower;


create table tbl_book(
book_BookId int auto_increment primary key ,
book_Title varchar(100),
book_PublisherName varchar(100),
foreign key (book_PublisherName)
references tbl_publisher(publisher_PublisherName) 
on delete cascade
on update cascade
);

select *from tbl_book;

create table tbl_book_authors(
book_authors_AuhtorID tinyint primary key auto_increment,
book_authors_BookID int ,
book_authors_AuthorName varchar(100),
foreign key (book_authors_BookID) 
references tbl_book(book_BookId)
on delete cascade
on update cascade
);

select * from tbl_book_authors;


create table tbl_library_branch(
library_branch_BranchID int primary key auto_increment, 
library_branch_BranchName varchar(100),
library_branch_BranchAddress varchar(100)
);

select * from tbl_library_branch;

create table tbl_book_copies(
book_copies_CopiesID int primary key auto_increment ,
book_copies_BookID int,
book_copies_BranchID int,
book_copies_No_Of_Copies int,
foreign key(book_copies_BookID) references tbl_book(book_BookId) 
on delete cascade on update cascade,
foreign key(book_copies_BranchID) references tbl_library_branch(library_branch_BranchID)
on delete cascade on update cascade
);

select * from tbl_book_copies;

create table tbl_book_loans(
book_loans_LoanID int primary key auto_increment,
book_loans_BookID int,
book_loans_BranchID int,
book_loans_CardNo int,
book_loans_DateOut date,
book_loans_DueDate date,
foreign key (book_loans_BookID) references tbl_book(book_BookId) on delete cascade on update cascade,
foreign KEY(book_loans_BranchID) references tbl_library_branch(library_branch_BranchID) on delete cascade on update cascade,
foreign key(book_loans_CardNo) references tbl_borrower(borrower_CardNo) on delete cascade on update cascade
);

select * from tbl_book_loans;

use library;

-- 1. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

select * from tbl_book_copies;
select * from tbl_book;
select * from tbl_library_branch;

select book_Title,library_branch_BranchName,book_copies_No_Of_Copies from 
(select b.book_BookId,b.book_Title,bc.book_copies_BranchID,bc.book_copies_No_Of_Copies from tbl_book as b
left join tbl_book_copies as bc
on b.book_BookId = bc.book_copies_BookID
where b.book_Title = 'The Lost Tribe') as new_table
left join tbl_library_branch as lb
on new_table.book_copies_BranchID = lb.library_branch_BranchID
where library_branch_BranchName = 'Sharpstown';

-- 2. How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select * from tbl_library_branch;
select * from tbl_book_copies;
select * from tbl_book;

select b.book_Title,bc.book_copies_BranchID,bc.book_copies_No_Of_Copies from tbl_book as b
left join tbl_book_copies as bc
on b.book_BookId = bc.book_copies_BookID
where b.book_Title = 'The Lost Tribe';

-- 3. Retrieve the names of all borrowers who do not have any books checked out.

select * from tbl_borrower;
select * from tbl_book_loans;

select b.borrower_BorrowerName from tbl_borrower as b
left join tbl_book_loans as bl
on b.borrower_CardNo = bl.book_loans_CardNo
where bl.book_loans_CardNo is null;

-- 4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address. 

select * from tbl_library_branch;
select * from tbl_book_loans;
select * from tbl_book;
select * from tbl_borrower;

select borrower_BorrowerName,borrower_BorrowerAddress,book_Title from 
(select * from 
(select * from tbl_library_branch as lb
left join tbl_book_loans as bl
on lb.library_branch_BranchID = bl.book_loans_BranchID) t1
right join tbl_book as b
on t1.book_loans_BookID = b.book_BookId) as t2
right join tbl_borrower as bo
on t2.book_loans_CardNo = bo.borrower_CardNo
where library_branch_BranchName = 'Sharpstown' and book_loans_DueDate = '2/3/18' ;

-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
select * from tbl_book_loans;

select library_branch_BranchName,count(library_branch_BranchName) as count_of_books_loaned from 
(select Branch.library_branch_BranchName,
Loan.book_loans_BranchID,
Loan.book_loans_BookID from tbl_library_branch as Branch
join tbl_book_loans as Loan
on Branch.library_branch_BranchID = Loan.book_loans_BranchID) as new_table
group by library_branch_BranchName;

-- 6. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.

select * from tbl_borrower;
select * from tbl_book_loans;

select borrower_BorrowerName,borrower_BorrowerAddress,count(new_table.borrower_BorrowerName) as no_of_books_CheckedOut from
(select Borrower.borrower_CardNo,Borrower.borrower_BorrowerName,Borrower.borrower_BorrowerAddress,
Loan.book_loans_BookID,Loan.book_loans_DateOut from tbl_borrower as Borrower
left join tbl_book_loans as Loan
on Borrower.borrower_CardNo = Loan.book_loans_CardNo) as new_table
group by borrower_BorrowerName,borrower_BorrowerAddress
having no_of_books_CheckedOut > 5;



-- 7. For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

select * from tbl_book_authors;
select * from tbl_book;
select * from tbl_book_copies;
select * from tbl_library_branch;

select book_Title,book_copies_BranchID,book_copies_No_Of_Copies from 
(select Book.book_BookId,Book.book_Title,Author.book_authors_AuthorName,Author.book_authors_AuhtorID from tbl_book as Book
left join tbl_book_authors as Author
on Book.book_BookId = Author.book_authors_BookID 
where Author.book_authors_AuthorName = 'Stephen King') as new_table
left join tbl_book_copies as c
on new_table.book_BookId = c.book_copies_BookID 
where book_copies_BranchID = 2;