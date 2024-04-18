# SQL

## postgresql

```bash
(base) kkalinga@ISA-KKALINGA:~$ k get pods
NAME                           READY   STATUS    RESTARTS   AGE
hogwartzapp-57b65fb678-2m6km   1/1     Running   0          11m
hogwartzapp-57b65fb678-6t8qg   1/1     Running   0          11m
hogwartzapp-57b65fb678-8g5vh   1/1     Running   0          11m
pgdb2-bd85cbdc-jzm8s           1/1     Running   0          2m42s
(base) kkalinga@ISA-KKALINGA:~$ k exec -it pgdb2-bd85cbdc-jzm8s bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.

root@pgdb2-bd85cbdc-jzm8s:/# psql -n postgres -U postgres
psql (12.17 (Debian 12.17-1.pgdg120+1))
Type "help" for help.

postgres=# \dt
Did not find any relations.
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 students  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

postgres=# \c students
You are now connected to database "students" as user "postgres".

students=# \dt
          List of relations
 Schema |   Name   | Type  |  Owner
--------+----------+-------+----------
 public | students | table | postgres
(1 row)

students=# select * from students;
 id |  fname  | lname | pet
----+---------+-------+-----
  1 | Kavindu |       | owl
  2 | harry   |       | owl
(2 rows)
```

## MySQL

```bash
(base) kkalinga@ISA-KKALINGA:~$ k exec -it keep-database-86dd6b6775-nw8fv -n keep bash
bash-4.4# mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 460
Server version: 8.3.0 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| keep               |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.00 sec)

mysql> USE keep;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW TABLES;
+--------------------------+
| Tables_in_keep           |
+--------------------------+
| alert                    |
| alertdeduplicationfilter |
| alertenrichment          |
| alertraw                 |
| alerttogroup             |
| group                    |
| mappingrule              |
| preset                   |
| provider                 |
| rule                     |
| tenant                   |
| tenantapikey             |
| tenantinstallation       |
| user                     |
| workflow                 |
| workflowexecution        |
| workflowexecutionlog     |
| workflowtoalertexecution |
+--------------------------+
18 rows in set (0.00 sec)

mysql> SELECT * FROM user;
+----+-----------+----------+------------------------------------------------------------------+-------+--------------+---------------------+
| id | tenant_id | username | password_hash                                                    | role  | last_sign_in | created_at          |
+----+-----------+----------+------------------------------------------------------------------+-------+--------------+---------------------+
|  1 | keep      | keep     | 6ca7ea2feefc88ecb5ed6356ed963f47dc9137f82526fdd25d618ea626d0803f | admin | NULL         | 2024-02-29 07:48:23 |
+----+-----------+----------+------------------------------------------------------------------+-------+--------------+---------------------+
1 row in set (0.00 sec)

```
