#!/bin/bash
#set -e
##################################################################################################################
# Author 	: Erik Dubois
# Website   : https://www.erikdubois.be
# Website   : https://www.alci.online
# Website	: https://www.arcolinux.info
# Website	: https://www.arcolinux.com
# Website	: https://www.arcolinuxd.com
# Website	: https://www.arcolinuxb.com
# Website	: https://www.arcolinuxiso.com
# Website	: https://www.arcolinuxforum.com
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
#tput setaf 0 = black 
#tput setaf 1 = red 
#tput setaf 2 = green
#tput setaf 3 = yellow 
#tput setaf 4 = dark blue 
#tput setaf 5 = purple
#tput setaf 6 = cyan 
#tput setaf 7 = gray 
#tput setaf 8 = light blue
##################################################################################################################

# reset - commit your changes or stash them before you merge
# git reset --hard

# checking if I have the latest files from github
#echo "Checking for newer files online first"
#git pull

rm -rf root
mkdir root
rm -rf /tmp/input

directories=(arcolinux-system-config)

count=0

for name in "${directories[@]}"; do
	count=$[count+1]
	tput setaf 1;echo "$count ": Github " $name ";tput sgr0;
	
	git clone https://github.com/arcolinux/$name --depth=1  /tmp/input

	rm -rf /tmp/input/.git
	rm /tmp/input/git*
	rm /tmp/input/LICENSE
	rm /tmp/input/README.md
	rm /tmp/input/setup-our-git-credentials.sh

	cp -r /tmp/input/* root

	rm -rf /tmp/input

	tput setaf 2;
	echo "#################################################"
	echo "################  "$name" done"
	echo "#################################################"
	tput sgr0;
done

#for Garuda
#mv root/etc/pacman.d/hooks/archlinux-appstream-data.hook root/etc/pacman.d/hooks/archlinux-appstream-data-fix.hook

rm root/etc/pacman.d/gnupg/gpg.conf
rm root//etc/X11/xorg.conf.d/30-touchpad.conf
rm root/etc/pacman.d/hooks/arcolinux-system-config-logo.hook
rm root/etc/pacman.d/hooks/filesystem-logo.hook
rm root/etc/pacman.d/hooks/lsb-release.hook
rm root/etc/pacman.d/hooks/os-release.hook
rm root/usr/lib/os-release-arcolinux

rm root/usr/local/bin/arcolinux-lsb-release
rm root/usr/local/bin/arcolinux-os-release

#rm root/etc/pacman.d/hooks/archlinux-appstream-data.hook
#rm root/usr/local/bin/arcolinux-appstream-data-fix

# Below command will backup everything inside the project folder
git add --all .
#git add --all root

# Give a comment to the commit if you want
echo "####################################"
echo "Write your commit comment!"
echo "####################################"

read input

# Committing to the local repository with a message containing the time details and commit text

git commit -m "$input"

# Push the local files to github

if grep -q main .git/config; then
	echo "Using main"
		git push -u origin main
fi

if grep -q master .git/config; then
	echo "Using master"
		git push -u origin master
fi

echo "################################################################"
echo "###################    Git Push Done      ######################"
echo "################################################################"
