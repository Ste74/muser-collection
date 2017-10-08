#!/bin/bash

#set variable

DE=mate
DIRECTORY=/home/$USER/Github/muser-collection/
ABSPATH=/usr/share/backgrounds/muser-collection-$DE/

clear
echo "#################################"
echo "This script makes all pictures in selected custom directory"
echo "available as your system-wide $DE wallpapers." 
echo "It reads/lists all pictures in selected directory and creates muser-collection-$DE.xml file in ~/.local/share/mate-background-properties/."
echo "USAGE: Make this script executable (chmod +x backgrounds.sh) and execute it (./backgrounds.sh or ./backgrounds.sh )." 
echo "#################################"
echo
# if doesn't exists creating directory ~/.local/share/mate-background-properties
mkdir -p ~/.local/share/mate-background-properties

echo
if [ ! -d $DIRECTORY ]
then
    echo "Directory $DIRECTORY doesnot exists"
    echo "You have to start the Script again."	
    exit
fi

echo "You selected $DIRECTORY:"
ls $DIRECTORY > lspictures.txt
cat lspictures.txt
echo

#check if mybackground.xml already exist

if [ -e muser-collection-$DE.xml ]
then
    rm muser-collection-$DE.xml
fi

# creating the head of mybackgrounds.xml
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE wallpapers SYSTEM \"mate-wp-list.dtd\">
<wallpapers>" > muser-collection-$DE.xml

# looking for all pictures in DIRECTORY
echo "OK. Now we are creating muser-collection-$DE.xml"

# This script is looking for .png and .jpg files only, but you can add here another file types. The "<options>stretched</options>" should work best for unknow sized files.
for i in $DIRECTORY*.jpg $DIRECTORY*.png; do
echo "<wallpaper>
<name>$i</name>
<filename>$i</filename>
  <options>stretched</options>
    <pcolor>#ffffff</pcolor>
    <scolor>#000000</scolor>
    <shade_type>solid</shade_type>
  </wallpaper>" >> muser-collection-$DE.xml
done

# creating the bottom of mybackgrounds.xml
echo "</wallpapers>" >> muser-collection-$DE.xml

# Change <name>/path_to/picture</name> to <name>picture</name> and move mybackgrounds.xml  to ~/.local/share/mate-background-properties/.
# if you like to copy mybackgrounds.xml to ~/.local/mybackgrounds.xml as well
sed "s|${DIRECTORY}|${ABSPATH}|g" muser-collection-$DE.xml > ~/.local/share/mate-background-properties/muser-collection-$DE.xml

#Move again in Original path and clean all
mv ~/.local/share/mate-background-properties/muser-collection-$DE.xml ${DIRECTORY}muser-collection-$DE.xml
rm lspictures.txt
echo
echo "#################################"
echo "DONE xml file created"
echo "#################################"
echo
exit 0
