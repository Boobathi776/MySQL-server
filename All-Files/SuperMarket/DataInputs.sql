use ShoppingDB;

--data for Customers
insert into Customer(Name,Email,DeliveryAddress) values
('Guhan','guhan47@gmail.com','15, Natrajan Street, Sivagangai, Chennai - 28'),
('Meena','meena23@gmail.com','42, Valluvar Salai, Thiruvanmiyur, Chennai - 41'),
('Aravind','aravind.muthu@gmail.com','7, Kamarajar Road, Madurai - 16'),
('Revathi','revathi.s@gmail.com','88, Sivan Koil Street, Salem - 4'),
('Karthik','karthikvel@gmail.com','101, Gandhi Nagar, Coimbatore - 32'),
('Bhuvana','bhuvana.r@gmail.com','56, VOC Street, Erode - 11'),
('Murugan','murugan94@gmail.com','27, Anna Nagar, Trichy - 18'),
('Yamini','yamini.j@gmail.com','64, Nehru Street, Thanjavur - 6'),
('Senthil','senthilr@gmail.com','35, Raja Street, Dindigul - 20'),
('Divya','divyadevi@gmail.com','5, Muthuramalingam Nagar, Tirunelveli - 2');

--data for category table
insert into Category(Name) values
('Fruits and Vegetables'),
('Dairy Products'),
('Meat and Seafood'),
('Bakery and Breads'),
('Grains and Cereals'),
('Spices and Masalas'),
('Personal Care'),
('Household and Cleaning Supplies'),
('Beverages'),
('Packaged and Canned Food'),
('Baby Products'),
('Pet Supplies'),
('Stationery and Office Supplies'),
('Organic and Health Foods'),
('Pharmacy'),
('Automotive and Miscellaneous');

insert into Inventory values
(2, 'Milk (1 ltr)', 50, 20),
(2, 'Curd (500 ml)', 30, 25),
(2, 'Paneer (200 gm)', 90, 10),
(1, 'Tomato (1 kg)', 28, 40),
(1, 'Onion (1 kg)', 30, 35),
(1, 'Potato (1 kg)', 25, 50),
(5, 'Rice Ponni (5 kg)', 320, 15),
(5, 'Toor Dal (1 kg)', 110, 18),
(6, 'Turmeric Powder (100 gm)', 25, 30),
(6, 'Chilli Powder (200 gm)', 45, 20),
(4, 'White Bread (400 gm)', 38, 22),
(4, 'Eggless Cake (250 gm)', 120, 10),
(9, 'Orange Juice (1 ltr)', 75, 15),
(9, 'Tea (250 gm)', 95, 20),
(10, 'Maggie Noodles (Pack of 6)', 72, 25),
(10, 'Tomato Ketchup (500 ml)', 60, 18),
(7, 'Lifebuoy Soap (100 gm)', 25, 30),
(7, 'Colgate Toothpaste (100 gm)', 45, 22),
(8, 'Surf Excel Detergent (1 kg)', 125, 15),
(8, 'Harpic Toilet Cleaner (500 ml)', 78, 12);

--CustomerID ,productID , Quantity
spStoreOrderDetails 1,1,2;