# Test

code /home/kkalinga/Documents/Learning/test1


//CHECK POSTGRES IS WORKING OR NOT
sudo systemctl status postgresql

//THIS WILL ACCEPT PORTS
sudo pg_isready
sudo su postgres

//NAVIGATE TO SQL TERMINAL / BASH
psql

//CREATE A NEW USER WITH PASSWORD
CREATE USER shayon WITH PASSWORD 'shayon';


FATAL: password authentication failed for user "postgres" (postgresql 11 with pgAdmin 4)
https://stackoverflow.com/questions/55038942/fatal-password-authentication-failed-for-user-postgres-postgresql-11-with-pg


sudo snap remove whatsapp-for-linux
