create database SaleOrderQuiz;
use SaleOrderQuiz;
create table Customer (
CustomerID  INT NOT null primary key auto_increment,
CustomerFirstName  VARCHAR(50) NOT null,
CustomerLastName  VARCHAR(50) NOT null,
CustomerAddress  VARCHAR(50) NOT null,
CustomerCity  VARCHAR(50) NOT null,
CustomerPostCode  CHAR(4) null,
CustomerPhoneNumber  CHAR(12) NULL
);

;
create Table Employee(
EmployeeID  TINYINT NOT null primary key auto_increment,
EmployeeFirstName  VARCHAR(50) NOT null,
EmployeeLastName  VARCHAR(50) NOT null,
EmployeeExtension  CHAR(4) NULL
);

create Table Sale(
SaleID  TINYINT NOT null primary key auto_increment,
CustomerID  INT NOT NULL, 
InventoryID  TINYINT NOT NULL, 
EmployeeID  TINYINT NOT NULL, 
SaleDate  DATE NOT null,
SaleQuantity  INT NOT null,
SaleUnitPrice  int NOT null,
FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
FOREIGN KEY (InventoryID) REFERENCES Inventory (InventoryID),
FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
);

INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerAddress, CustomerCity, CustomerPostCode, CustomerPhoneNumber) 
VALUES 
('John', 'Doe', '123 Maple Street', 'Springfield', '1234', '123456789012'),
('Jane', 'Smith', '456 Oak Avenue', 'Rivertown', '5678', '098765432109'),
('Michael', 'Johnson', '789 Pine Road', 'Lakeside', '9101', '112233445566');

INSERT INTO Inventory (InventoryName, InventoryDescription) 
VALUES 
('Laptop', 'A high-performance laptop suitable for gaming and professional work.'),
('Office Chair', 'Ergonomic office chair with adjustable height and lumbar support.'),
('Smartphone', 'Latest model smartphone with advanced camera features and 5G connectivity.');
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, EmployeeExtension) 
VALUES 
('Alice', 'Johnson', '1234'),
('Bob', 'Smith', '5678'),
('Charlie', 'Brown', NULL);

INSERT INTO Sale (CustomerID, InventoryID, EmployeeID, SaleDate, SaleQuantity, SaleUnitPrice) 
VALUES 
(1, 1, 1, '2024-01-15', 2, 1200), 
(2, 2, 2, '2024-01-16', 1, 300), 
(3, 3, 3, '2024-01-17', 5, 150);


select * from Customer;
select SaleQuantity * SaleUnitPrice as Multplication from Sale order by Multplication;
select sum(SaleQuantity * SaleUnitPrice) as Somme from Sale;
SELECT 
    Employee.EmployeeID , 
    CONCAT(Employee.EmployeeFirstName, ' ', Employee.EmployeeLastName) AS EmployeeName,
    sum(Sale.SaleQuantity * Sale.SaleUnitPrice) as Somme
FROM Employee join Sale on Sale.EmployeeID = Employee.EmployeeID 
group by  Employee.EmployeeID,EmployeeName
having Somme > 0;

alter table Customer
add column CustomerEmail varchar(150) unique;
describe Customer;
update Customer 
set CustomerEmail='cherkaoui@gmail.com' where CustomerID=1;
  update Customer 
set CustomerCity='New York' where CustomerID=2;
delete from Customer 
where CustomerCity='New York';
select * from Sale;
select * from Sale WHERE SaleDate >= CURDATE() - INTERVAL 30 DAY;
select * from Customer join Sale on Customer.CustomerID = Sale.CustomerID where SaleQuantity > 5;

create Table Inventory(
InventoryID  tinyint  NOT null primary key auto_increment,
InventoryName  VARCHAR(50) NOT null,
InventoryDescription  VARCHAR(255) null
);

select Inventory.InventoryName , 
sum(Sale.SaleQuantity * Sale.SaleUnitPrice) as  tota_vents
from Sale join Inventory on Inventory.InventoryID = Sale.InventoryID
group by Inventory.InventoryName;

