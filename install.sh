#!/bin/bash

export OSUDIR="$HOME/osu"
export INSTALLERNAME="osu!install.exe"
read -p "Install osu-wine-startup? [Y/n] " choice
case "$choice" in
	y|Y ) echo "Installing...";;
	n|N ) exit;;
	* ) exit;;
esac

# wine detecting is broken

export WINEOUT=$(dpkg-query -l wine)
if [[ $WINEOUT == *"no packages found"* ]]; then
	echo "Wine not found. Attempting to install stable..."
	sudo apt -y install wine-stable
fi

sudo apt install -y winetricks wine32 wine-stable unzip

mkdir -p "$OSUDIR/drive_c/osu"
sudo cp osu /usr/local/bin/osu
touch $HOME/.config/osu.sh
read -p "Do you want to edit your config now? [Y/n] " choice
case "$choice" in
	y|Y ) nano $HOME/.config/osu.sh;;
	n|N ) ;;
	* ) ;;
esac

read -p "Do you want to install osu from scratch? [Y/n] " choice
case "$choice" in
	y|Y ) ;;
	n|N ) echo "Finished."; exit;;
	* ) ;;
esac
echo "Downloading osu..."
mkdir -p "$OSUDIR/install/"
cd "$OSUDIR/install/"
wget https://m1.ppy.sh/r/osu\!install.exe
mv $INSTALLERNAME "$OSUDIR/drive_c/osu/osu!.exe"

export WINEPREFIX="$OSUDIR"
export WINEARCH=win32
winetricks dotnet40
winetricks corefonts
winetricks gdiplus
wget https://github.com/discordapp/discord-rpc/releases/download/v3.4.0/discord-rpc-win.zip
unzip discord-rpc-win.zip
cp discord-rpc/win32-dynamic/bin/discord-rpc.dll $OSUDIR/drive_c/osu/
echo "Finished."
