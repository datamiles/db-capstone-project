-- task 1 create view
create view LittleLemonDB.OrdersView as
select OrderID, Quantity, Total_Cost from Orders; 

select * from LittleLemonDB.OrdersView;

-- task 2 JOIN
select b.CustomerID, b.CustomerName as FullName, a.OrderID, a.total_cost, c.CuisineName, d.CourseName from LittleLemonDB.Orders a
inner join LittleLemonDB.Customer b 
on a.CustomerID = b.CustomerID
inner join LittleLemonDB.Menu c
on a.MenuID = c.MenuID 
inner join LittleLemonDB.MenuItems d
on c.MenuItemsID = d.MenuItemsID;

-- task 3 ANY
select CuisineName from LittleLemonDB.Menu where MenuID = ANY
(select MenuID from LittleLemonDB.Orders
where Quantity > 2);

-- SP Task 1
DELIMITER //
create procedure GetMaxQuantity()
BEGIN
	select max(quantity) from LittleLemonDB.Orders;
END //

DELIMITER ;

call GetMaxQuantity();

select * from Orders;
-- Sp Task 2
prepare GetOrderDetail from 'Select OrderID, Quantity, Total_Cost from Orders where CustomerID = ?';
set @id=1;
Execute GetOrderDetail using @id;

-- SP Task 3

drop procedure CancelOrder;

DELIMITER //

create procedure CancelOrder(IN oid INT)
BEGIN
	delete from LittleLemonDB.Orders where orderid = oid;
END //

call CancelOrder(4);

-- Bookings Task 1
select * from LittleLemonDB.Booking;

-- Task 2

drop procedure CheckBooking;
DELIMITER //

create procedure CheckBooking(IN checkIfBooked INT, OUT result varchar(50))
BEGIN
 SET @v := (select count(*) from LittleLemonDB.Booking);
 if @v > 0 THEN
	SET result = CONCAT("Table ", checkIfBooked, " is already booked");
 else SET result = "Table is available";
 END IF;
END //

call CheckBooking(99, @result);
select @result;