A Simple Bash Script that takes /16 ip range as input and split it to /24 ranges for faster results and see result while scan is running 

To Use this First install parallel first 

sudo apt install parallel 

Paste This Script To /usr/local/bin

Example Usage :- nmapCIDR.sh 10.10.0.0/16 | tee -a ip.txt

Hope this Script Helps :)
