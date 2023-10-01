read -p "Enter Build Name: " filename
unzip $filename

echo "Decompressing system.new.dat.br"
brotli --decompress system.new.dat.br -o system.new.dat
if [ $? != 0 ]
then
echo "Stoped at decompressing system.new.dat.br"
exit 1
fi

echo "Extracting system.new.dat"
python3 sdat2img.py system.transfer.list system.new.dat system.img
if [ $? != 0 ]
then
echo "Stoped at Extracting system.new.dat"
exit 1
fi

echo "Removing system.new.dat"
rm system.new.dat
if [ $? != 0 ]
then
echo "Removing system.new.dat"
exit 1
fi

echo "Decompressing vendor.new.dat.br"
brotli --decompress vendor.new.dat.br -o vendor.new.dat
if [ $? != 0 ]
then
echo "Stoped at decompressing vendor.new.dat.br"
exit 1
fi

echo "Extracting vendor.new.dat"
python3 sdat2img.py vendor.transfer.list vendor.new.dat vendor.img
if [ $? != 0 ]
then
echo "Stoped at Extracting vendor.new.dat"
exit 1
fi

echo "Removing vendor.new.dat"
rm vendor.new.dat
if [ $? != 0 ]
then
echo "Removing vendor.new.dat"
exit 1
fi

mkdir "system"
mkdir "vendor"

sudo mount -r system.img system
sudo mount -r vendor.img vendor

read -p "Press Enter to Unmount"

sudo umount "system"
sudo umount "vendor"