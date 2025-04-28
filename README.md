# Task1: mygrip.sh
This a min version of the `grep` command that have the basic funcnality.
It can search for words inside a text file and supports options to show line numbers and invert matches.

##Features
Case-insensitive search (default).

Options supported:

`-n`:Show line numbers.

`-v`: Invert match (show lines that do not match).

`--help`: To show how to use the command.

Combined options like `-vn` or `-nv` are supported.

Error handling for missing arguments.

## Exampels:
`./mygrep.sh hello testfile.txt`


![image](https://github.com/user-attachments/assets/76e3c03b-3572-4525-96fe-e3441d379b92)

`./mygrep.sh -n hello testfile.txt`


![image](https://github.com/user-attachments/assets/ad2ec86b-81d0-4ef5-abf8-6888f71ec692)

`./mygrep.sh -vn hello testfile.txt`


![image](https://github.com/user-attachments/assets/5293f493-45ec-482a-98cf-d79779535744)

`./mygrep.sh -v testfile.txt`


![image](https://github.com/user-attachments/assets/82c7f14b-9d3f-447c-86b3-ce830bde5b7b)

`./mygrep.sh --help`


![image](https://github.com/user-attachments/assets/40315075-20ec-4276-bd54-2608499809ed)





