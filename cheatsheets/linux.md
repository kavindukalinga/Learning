# </ Linux >

```bash
# Add user
sudo adduser bob
sudo usermod -aG sudo bob
sudo login bob
sudo -i

# See all the processes running
ps -eaf | head

# Open a file:
xdg-open 'FileName.png'

# Open a Directory
open .

# Create a File or Directroy
mkdri Directroy-Name
touch file1.txt file2.py file3.html

# List
ls
ls -a # Show Hidden files
ls -l # more details

# Delete a file or Directory
rm file1.txt
rm -rf Directory1    # -r recursive    -f force

# Create and edit text:
nano filename.text	# Ctrl+X - save and exit
vim filename.text	# i - insert, #Esc :wq - save and exit

# Save a text without pacakages
cat > test4.txt
---content---
---content---
^C
cat test4.txt
>>> --content---

# Read text:
cat a.txt
more a.txt
less a.txt

# kill an app (forcefully)
pkill application_name
killall application_name


```
