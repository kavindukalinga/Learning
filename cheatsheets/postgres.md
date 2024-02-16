# postgresql

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
