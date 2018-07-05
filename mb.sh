if [ "`id -u`" != 0 ]; then
	whiptail --title "START ERROR" --msgbox "The software Must be run as root.  Exiting." 7 60
	exit
fi

if (whiptail --title "AUTO-KALI STSRT"  --yesno '   mm            m                  #             ""#      "   \n   ##   m   m  mm#mm   mmm          #   m   mmm     #    mmm   \n  #  #  #   #    #    #" "#         # m"   "   #    #      #   \n  #mm#  #   #    #    #   #   """   #"#    m"""#    #      #   \n #    # "mm"#    "mm  "#m#"         #  "m  "mm"#    "mm  mm#mm\n\n                       是否打开Auto-kali?' 15 68) then
	{
 	   for ((i = 0 ; i <= 100 ; i+=5)); do
	        sleep 0.1
 	        echo $i
	    done
	} | whiptail --gauge "开启进度" 6 60 0
	echo "请等待一会!"
	apt install -y python3-termcolor >> /dev/null
	#检测执行结果
	if [ $? -ne 0 ]; then
		apt install -y python3-termcolor >> /tmp/Auto-kali-APT.log
		#记录APT错误日志
    	if (whiptail --title "APT错误" --yes-button "查看log" --no-button "尝试启动"  --yesno "        请把log文件发到QQ:1945649519内\n               Log path:/tmp/Auto-kali-APT.log" 10 70) then
    			whiptail --title "Log List" --textbox "/tmp/Auto-kali-APT.log" 20 60
		else
				#记录启动错误日志
    			python3 "$lj/master.py"
				if [ $? -ne 0 ];then
					apt update > /tmp/Auto-Kali.log
					python3 master.py >> /tmp/Auto-kali.log
					if (whiptail --title "错误" --yes-button "查看log" --no-button "退出"  --yesno "        请把log文件发到QQ:1945649519内\n               Log path:/tmp/Auto-kali.log" 10 70) then
    					whiptail --title "Log List" --textbox "/tmp/Auto-log" 20 60
					else
    					exit
					fi
				fi
				#结束
		fi
		#结束
	else
		#运行
		python3 "$lj/master.py"
		#记录错误日志
		if [ $? -ne 0 ];then
			apt update > /tmp/Auto-Kali.log
			python3 "$lj/master.py" >> /tmp/Auto-kali.log
			if (whiptail --title "错误" --yes-button "查看log" --no-button "退出"  --yesno "        请把log文件发到QQ:1945649519内\n               Log path:/tmp/Auto-kali.log" 10 70) then
    			whiptail --title "Log List" --textbox "/tmp/Auto-kali.log" 20 60
			else
    			exit
			fi
			#结束
		fi
	fi
	#结束
	exit
else
    exit
fi