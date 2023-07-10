-- Create Salesperson table
CREATE TABLE salesperson (
  salesperson_id SERIAL PRIMARY KEY,
  s_name VARCHAR(100)
);

-- Create Customer table
CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  c_name VARCHAR(100)
);

-- Create Car table
CREATE TABLE car (
  car_id SERIAL PRIMARY KEY,
  make VARCHAR(100),
  model VARCHAR(100),
  c_type VARCHAR(10),
  car_serial INTEGER
);

-- Create Invoice table
CREATE TABLE invoice (
  invoice_id SERIAL PRIMARY KEY,
  car_id INT,
  salesperson_id INT,
  customer_id INT,
  FOREIGN KEY (car_id) REFERENCES car (car_id),
  FOREIGN KEY (salesperson_id) REFERENCES salesperson (salesperson_id),
  foreign key (customer_id) references customer (customer_id)
);

-- Create ServiceTicket table
CREATE TABLE service_ticket (
  service_ticket_id SERIAL PRIMARY KEY,
  description VARCHAR(1000),
  car_id INT,
  customer_id INT,
  FOREIGN KEY (car_id) REFERENCES car (car_id),
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

-- Create service ticket history table
create table service_ticket_history(
	service_history_id SERIAL primary key,
	car_serial INT,
	service_ticket_id INT,
	foreign key (service_ticket_id) references service_ticket(service_ticket_id)
);

-- Create Mechanic table
CREATE TABLE mechanic (
  mechanic_id SERIAL PRIMARY KEY,
  m_name VARCHAR(100)
);

-- Create Service table
CREATE TABLE service (
  service_id serial PRIMARY KEY,
  parts_needed VARCHAR(500),
  mechanic_id INT,
  service_ticket_id INT,
  FOREIGN KEY (mechanic_id) REFERENCES mechanic (mechanic_id),
  FOREIGN KEY (service_ticket_id) REFERENCES service_ticket (service_ticket_id)
);

-- Insert sample data into Salesperson table
INSERT INTO salesperson (salesperson_id, s_name)
VALUES (1, 'John Doe'),
       (2, 'Jane Smith');

-- Insert sample data into Customer table
INSERT INTO customer (customer_id, c_name)
VALUES (1, 'Mike Johnson'),
       (2, 'Sarah Anderson');

-- Insert sample data into Car table
INSERT INTO car (car_id, make, model, car_serial, c_type)
VALUES (1, 'Toyota', 'Camry', 123456789, 'New'),
       (2, 'Honda', 'Civic', 987654321, 'Used');

-- Insert sample data into Invoice table
INSERT INTO invoice  (invoice_id, salesperson_id, car_id, customer_id)
VALUES (1001, 1, 1, 1),
       (1002, 2, 2, 2);

-- Insert sample data into ServiceTicket table
INSERT INTO service_ticket (service_ticket_id, description, car_id, customer_id)
VALUES (2001, 'Oil change', 1, 1),
       (2002, 'Tire rotation', 2, 2),
       (2003, 'Tune up', 1, 1);
      
-- Insert sample date into ServiceTicketHistory table
insert into service_ticket_history (service_history_id, service_ticket_id, car_serial)
values (3001, 2001, 123456789),
	   (3002, 2002, 987654321),
	   (3003, 2003, 987654321);

-- Insert sample data into Mechanic table
INSERT INTO mechanic (mechanic_id, m_name)
VALUES (1, 'Tom Smith'),
       (2, 'Emily Brown');

-- Insert sample data into Service table
INSERT INTO service (service_id, parts_needed, mechanic_id, service_ticket_id)
VALUES (4001, 'Oil Filter', 1, 2001),
       (4002, 'Hub Cap', 2, 2002);
       
--Create a function to insert data into one of the tables
create or replace function add_car (_car_id INT, _make VARCHAR, _model VARCHAR, _car_serial INT, _c_type VARCHAR)
returns void
as $MAIN$
begin
	insert into car(car_id, make, model, car_serial, c_type)
	values(_car_id, _make, _model, _car_serial, _c_type);
end;
$MAIN$
language plpgsql;

select add_car(3, 'Kia', 'Rondo', 543216789, 'Used');

--And another function 
create or replace function add_service (_service_id INT, _parts_needed VARCHAR, _mechanic_id INT, _service_ticket_id INT)
returns void
as $MAIN$
begin
	insert into service(service_id, parts_needed, mechanic_id, service_ticket_id)
	values(_service_id, _parts_needed, _mechanic_id, _service_ticket_id);
end;
$MAIN$
language plpgsql;

select add_service(4003, 'None', 1, 2003);






