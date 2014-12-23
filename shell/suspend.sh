#!/bin/bash
########################################
# rebind usb ports and suspend system (sudo/root needed)
########################################
USB_DIR="/sys/bus/pci/drivers/xhci_hcd"
IDS=$(\ls -1 $USB_DIR|grep ':')
echo "Rebinding all usb ports ..."
sudo echo -n "$IDS" > "$USB_DIR/unbind" && sudo echo -n "$IDS"> "$USB_DIR/bind" 
if [[ $? == "0" ]]; then
	echo -e "\nDone!"
	systemctl suspend
else
	echo -e "\nFAILED! Forgot sudo?"
	while true; do
		read -p "Continue to suspend system [y/n]?" yn
		case $yn in
			[Yy]* ) systemctl suspend; break;;
			[Nn]* ) exit;;
			* ) echo "Please answer y or n.";;
		esac
	done

fi
