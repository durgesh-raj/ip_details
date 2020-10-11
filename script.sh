> output.txt
printf "Parsing the input file for carriage return... \n"
tr -d '\r' < input.csv > input3.csv
printf "Output \n"
while IFS=, read -u10 c1 c2;
do
        if [ -z "$c2" ]; then
                c2=3;
        fi
        echo "Fetching $c1 details..."
        timeout 5 ssh -q -i devopskey.pem $c1 -l ubuntu exit
        if [ $? != "0" ];
        then
                echo "IP : $c1" >> output.txt
                echo "Server Unreachable: SSH Connection failed" >> output.txt
                printf "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _\n\n" >> output.txt
        else
                c3=$(( $c2 + 1 ))
                RAM=`ssh -n -i devopskey.pem $c1 -l ubuntu free -h |sed -n 2p | awk '{ print $3 }';`
                Total_RAM=`ssh -n -i devopskey.pem $c1 -l ubuntu free -h |sed -n 2p | awk '{ print $2 }';`
                proc=`ssh -n -i devopskey.pem $c1 -l ubuntu ps -eo pid,cmd,%mem, --sort=-%mem | head -n $c3;`
                echo "IP : $c1" >> output.txt
                echo "Ram Usages: $RAM out of $Total_RAM"  >> output.txt
                echo "$c2 processes :" >> output.txt
                echo "$proc" >> output.txt
                printf "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _\n\n" >> output.txt
        fi
done 10< input3.csv
printf "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _\n\n"
cat output.txt
