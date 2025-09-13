#  Relational Database Project - E-commerce  

##  Author  
- **Name:** Leonilde da Silva Mendes  
- **Email:** leonaldomendes293@gmail.com  

---

## Objective  
This project was developed as part of a Database Systems assignment.  
The objective is to **design and implement a complete relational database system in MySQL**, applying best practices of data modeling, normalization, and relationship design.  

---

##  Project Description  
The system models an **E-commerce Store**, covering the following main entities:  
- **Customers**  
- **Addresses**  
- **Product Lines**  
- **Products**  
- **Orders**  
- **Order Items**  
- **Payments**  

Key concepts applied:  
- **Primary Keys (PRIMARY KEY)**  
- **Foreign Keys (FOREIGN KEY)**  
- **Integrity Constraints** (`NOT NULL`, `UNIQUE`, `ON DELETE`)  
- **Relationships**:  
  - 1:1 (customer → address, optionally)  
  - 1:N (customer → orders)  
  - N:M (orders ↔ products through order_items)  

---

##  Deliverable  
- `database_ecommerce.sql`  
  Contains:  
  - `CREATE DATABASE` statement  
  - `CREATE TABLE` statements with constraints  
  - `INSERT INTO` sample data  


