#!/bin/bash

# execute interval = 14,400s[4 hours] x 180i = 2,592,000s [1 month]
# execute interval = 900s[15 minutes] x 672i = 604,800s [1 week]
# execute interval = 300s x 288i = 86,400s [1 day]
# execute interval = 5s x 720i = 3,600s [1 hour]

interval=0
while (($interval < 180))
	do
		(
		echo $'\n\t' "================================================================================================="
		echo $'\t' "================================================================================================="
		echo $'\t' "$(date -R)" $'\t' "$(uname -rm)" $'\t' "$(cat /etc/issue)" $'\n\n\n' 

		top -b -n 1 | awk 'NR <3' 
		ps -eo user,pid,ppid,pcpu,pmem,vsize,rss,comm --sort -vsize | head 

		echo $'\n'
		
		free -lt 

		echo $'\n'

		mpstat -P ALL 1 3 | grep Average 

		echo $'\n'

		iostat -x 1 4 | grep "Device\|sd." | awk 'NR > 3' | sort -u 

		echo $'\n'

		dstat -n 1 3 | awk 'NR != 3'

		echo $'\n'

		echo "================================================================================================="
		) >> 1mo-perfmon-analysis.txt

		interval=$(($interval + 1)) 
		sleep 14400
	done
exit
$SHELL
