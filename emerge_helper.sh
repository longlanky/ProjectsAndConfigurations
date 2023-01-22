sync () { emerge --sync }
update () { emerge -avDuN @world }
depclean () { emerge --depclean && emerge -avDuN @world }
backtrack () { emerge --backtrack=0 -avp }
portageupdate () { emerge --ask --oneshot portage }
buildnewkernel () {
    clear
    CURRENTKERNEL=$(ls /usr/src/linux -l | grep -o 'linux-[0-9]*.[0-9]*.[0-9]*-gentoo')
    KERNELDIRECTORY="/usr/src/$CURRENTKERNEL"
    eselect kernel list
    echo "Select kernel number:"
    read -r SELKERN
    eselect kernel set $SELKERN
    cp "$KERNELDIRECTORY/.config" "/usr/src/linux/"
    cd /usr/src/linux
    make oldconfig
    make menuconfig
    make modules_prepare
    emerge acpi_call
    make -j8
    make modules_install
    make install
}
pause () {
    printf "%s " "Press enter to continue"
    read ans
}

MainMenu () {
SELECT=$(whiptail --title "Emerge Assistant" --menu "Please select an option" 25 78 16 \
"Sync" "emerge --sync" \
"Update" "emerge -avDuN @world" \
"Depclean" "emerge --depclean && emerge -avDuN @world" \
"Backtrack" "emerge --backtrack=0 -avp" \
"Update portage" "emerge --ask --oneshot portage" \
"Build new kernel" "Compile kernel, emerge modules & install" \
"Reboot" "Reboot" 3>&1 1>&2 2>&3)

case "$SELECT" in
  "Sync")
    sync ; pause ; MainMenu
    ;;

  "Update")
    update ; pause ; MainMenu
    ;;

  "Depclean")
    depclean ; pause ; MainMenu
    ;;

  "Backtrack")
    backtrack ; pause ; MainMenu
    ;;

  "Update portage")
    portageupdate ; pause ; MainMenu
    ;;

  "Build new kernel")
    buildnewkernel ; pause ; MainMenu
    ;;

    "Reboot")
    reboot
    ;;
esac
}
MainMenu