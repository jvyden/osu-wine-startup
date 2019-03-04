#!/bin/bash

export OSUDIR="$HOME/osu"
export INSTALLERNAME="osu!install.exe"
export LANG=ja_JP.UTF-8
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
echo "Installing dotnet 4.0..."
winetricks dotnet40
echo "Installing fonts..."
winetricks corefonts
winetricks cjkfonts
echo "Installing GDI+..."
winetricks gdiplus
wget https://github.com/Marc3842h/rpc-wine/releases/download/1.0.0/rpc-wine.tar.gz
tar -xzf rpc-wine.tar.gz
rm rpc-wine.tar.gz
cp -r bin* ../

touch "$OSUDIR/drive_c/osu/discord-rpc.dll"
echo "Finished."
