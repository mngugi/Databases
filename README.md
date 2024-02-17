Welcome to the Databases wiki!

# Databases

### Install MySQL 8.0 on Fedora


**1: Add MySQL 8.0 community repository**
To install MySQL 8.0 on Fedora, you need to add MySQL 8.0 community repository.
`sudo dnf -y install https://dev.mysql.com/get/mysql80-community-release-fc38-1.noarch.rpm`
This will write a repository file to `/etc/yum.repos.d/mysql-community.repo`
` cat /etc/yum.repos.d/mysql-community.repo`


---

**2: Install MySQL Server 8.0 on Fedora**
Once you have added the repository and confirm to be enabled, proceed to install MySQL 8.0 onto your Fedora by running:
`sudo dnf install mysql-community-server`
After installation, the package info can be seen from:
`rpm -qi mysql-community-server`

---

**3: Configure MySQL server on Fedora**
After installation of MySQL 8.0 on Fedora, you need to do initial configuration to secure it.

1. Start and enable mysqld service:
```sql
sudo systemctl start mysqld.service
sudo systemctl enable mysqld.service
```
2. Copy the generated random password for the root user
`sudo grep 'A temporary password' /var/log/mysqld.log |tail -1`
Take note the printed password:

`A temporary password is generated for root@localhost: 1ph/axo>vJe;`
3. Start MySQL Secure Installation to change the root password, Disallow root login remotely, remove anonymous users and remove test database.

```sql
`$ sudo mysql_secure_installation`
Securing the MySQL server deployment.
Enter password for user root:
```
Authenticate with your generated temporary password. Then configure your MySQL 8.0 installation like below:

```sql
Change the password for root ? ((Press y|Y for Yes, any other key for No) : Yes

New password: 
Re-enter new password: 

Estimated strength of the password: 100 
Do you wish to continue with the password provided?: Yes

Remove anonymous users?: Yes
Success.

Disallow root login remotely? : Yes
Success.

Remove test database and access to it? : Yes
 - Dropping test database...
Success.
 - Removing privileges on test database...
Success.

Reload privilege tables now? (Press y|Y for Yes) : Yes
Success.

All done!

```
4. Connect to MySQL Database as root user and create a test database.

```sql
$ sudo mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.33

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SELECT version();
+-----------+
| version() |
+-----------+
| 8.0.33    |
+-----------+
1 row in set (0.00 sec)
```

```sql
Create a test database and user

mysql> CREATE DATABASE test_db;
Query OK, 1 row affected (0.09 sec)

mysql> CREATE USER 'test_user'@'localhost' IDENTIFIED BY "Strong34S;#";
Query OK, 0 rows affected (0.04 sec)

mysql> GRANT ALL PRIVILEGES ON test_db.* TO 'test_user'@'localhost';
Query OK, 0 rows affected (0.02 sec)

mysql> FLUSH PRIVILEGES;

Query OK, 0 rows affected (0.02 sec)
This test database and user can be dropped by running:

mysql> DROP DATABASE test_db;
Query OK, 0 rows affected (0.14 sec)

mysql> DROP USER 'test_user'@'localhost';
Query OK, 0 rows affected (0.11 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.01 sec)

mysql> QUIT
Bye

```
---

### How to Load a database on MySQL:

**To load a database into MySQL, follow these steps:**

1.Create a Database: Open MySQL command-line interface (CLI) and create a new database named `"Employees"` using the following command:


`mysql> CREATE DATABASE Employees;`
Source the SQL File: Use the source command followed by the path to the SQL file you want to import into the "Employees" database. For example, if your SQL file is located at /home/xxxxxxx/Downloads/employees/employees.sql, execute the following command:


`mysql> SOURCE /home/xxxxxxx/Downloads/employees/employees.sql;`
Ensure that you replace `/home/xxxxxxx/Downloads/employees/employees.sql` with the actual path to your SQL file.

2.Verify Database Creation: Confirm that the database was created successfully by executing the following command:


`mysql> SHOW DATABASES;`
This command lists all the databases on the MySQL server. You should see `"Employees"` listed among them.

3.Verify Table Creation: To check if the tables were successfully created within the `"Employees"` database, execute the following command:

`mysql> USE Employees;`
`mysql> SHOW TABLES;`
The USE Employees; command selects the "Employees" database for further operations, and `SHOW TABLES;` lists all the tables in that database.

These steps should effectively load the database into `MySQL` and verify its creation along with the presence of tables within it. Adjust the file path and database name as necessary for your specific setup.



---



**4: Configure Firewall for remote connections**
To allow for remote connections, allow port 3306 on the firewall

```sql
sudo firewall-cmd --add-service=mysql --permanent
sudo firewall-cmd --reload
You can also limit access from trusted networks

sudo firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" \
service name="mysql" source address="10.1.1.0/24" accept'

```
