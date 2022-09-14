#!/bin/bash
#Ver: 1.0
#Dev: AlonD
#Description: Simple Discord Bots Files Backup Linux Bash Script for crontab.

botsfolderpath=$(ls /home/discordbots/)
fpwd="/home/discordbots/"
for bot in $botsfolderpath;
do
		mkdir -p /home/BotsBackups/${bot}_Backup/
        cp -r $fpwd/$bot/*.* /home/BotsBackups/${bot}_Backup/
        currDate=`date +'%d-%m-%Y_%H-%M'`
        echo ${bot}_Backup_${currDate}.zip .${bot}_Backup
        cd /home/BotsBackups
        tar -cvf ${bot}_Backup_${currDate}.zip ${bot}_Backup
        rm -rf /home/BotsBackups/${bot}_Backup
done

disabledbotfolder=$(ls /home/discordbots/DisabledBotsFolder/)
fpwd2="/home/discordbots/DisabledBotsFolder/"
for bot in $disabledbotfolder;
do
		mkdir -p /home/BotsBackups/Disabled/${bot}_Backup/
        cp -r $fpwd2/$bot/*.* /home/BotsBackups/Disabled/${bot}_Backup/
        currDate=`date +'%d-%m-%Y_%H-%M'`
        echo ${bot}_Backup_${currDate}.zip .${bot}_Backup
        cd /home/BotsBackups/Disabled/
        tar -cvf ${bot}_Backup_${currDate}.zip ${bot}_Backup
        rm -rf /home/BotsBackups/Disabled/${bot}_Backup
        mv *.* /home/BotsBackups/
        rmdir /home/BotsBackups/Disabled
done

cd /home/BotsBackups/
rm -rf DisabledBotsFolder_Backup*.zip
mkdir /DiscordBotsBackups
mv /home/BotsBackups/* /DiscordBotsBackups

cd /
zip -0 -r /DiscordBotsBackups/All_Bots_Backup_${currDate}.zip /DiscordBotsBackups/*
mkdir /home/BotBackupsUpload
mv /DiscordBotsBackups/All_Bots_Backup_${currDate}.zip /home/BotBackupsUpload
rm -rf /home/BotsBackups/*

ip="Put-Your-IP"
port="Insert-PORT"
fuser="USER"
fpasswd="YOUR-PASSWORD"
ftpdir="YOUR-FTP-DIRECTORY"
ftp-upload -h $ip:$port -u $fuser --password $fpasswd -d $ftpdir /home/BotBackupsUpload/All_Bots_Backup_${currDate}.zip
rm -rf /home/BotBackupsUpload/*
rm -rf /DiscordBotsBackups/*.*
rmdir /home/BotBackupsUpload
rmdir /home/BotsBackups
rmdir /DiscordBotsBackups
exit 0
