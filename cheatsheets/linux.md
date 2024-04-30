# </ Linux >

## Content

- [\</ Linux \>](#-linux-)
  - [Content](#content)
  - [Add user](#add-user)
  - [See all the processes running](#see-all-the-processes-running)
  - [Open a file](#open-a-file)
  - [Open a Directory](#open-a-directory)
  - [Create a File or Directroy](#create-a-file-or-directroy)
  - [List](#list)
  - [Delete a file or Directory](#delete-a-file-or-directory)
  - [Create and edit text](#create-and-edit-text)
  - [Save a text without pacakages](#save-a-text-without-pacakages)
  - [Read text](#read-text)
  - [kill an app (forcefully)](#kill-an-app-forcefully)

## Add user

```bash
sudo adduser bob
sudo usermod -aG sudo bob
sudo login bob
sudo -i
```

## See all the processes running

```bash
ps -eaf | head
```

## Open a file

```bash
xdg-open 'FileName.png'
```

## Open a Directory

```bash
open .
```

## Create a File or Directroy

```bash
mkdri Directroy-Name
touch file1.txt file2.py file3.html
```

## List

```bash
ls
ls -a # Show Hidden files
ls -l # more details
```

## Delete a file or Directory

```bash
rm file1.txt
rm -rf Directory1    # -r recursive    -f force
```

## Create and edit text

```bash
nano filename.text  # Ctrl+X - save and exit
vim filename.text  # i - insert, #Esc :wq - save and exit
```

## Save a text without pacakages

```bash
cat > test4.txt
---content---
---content---
^C
cat test4.txt
>>> --content---
```

## Read text

```bash
cat a.txt
more a.txt
less a.txt
```

## kill an app (forcefully)

```bash
pkill application_name
killall application_name
```
