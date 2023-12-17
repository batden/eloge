#!/bin/bash

# This script helps you cleanly and safely uninstall Enlightenment and related applications.

# ELOGE.SH is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License,
# in memory of Aaron Swartz.
# See https://creativecommons.org/licenses/by-sa/4.0/

# Got a GitHub account? Please consider starring our repositories to show your support.
# Thank you!

ITAL="\e[3m"
BLDR="\e[1;31m"
OFF="\e[0m"

SCRFLDR=$HOME/.elucidate
DDCTL=2.0.0

PROG_MBS="terminology enlightenment ephoto evisum rage express ecrire enventor edi entice enlightenment-module-forecasts enlightenment-module-penguins eflete efl"

beep_exit() {
  aplay --quiet /usr/share/sounds/sound-icons/pipe.wav 2>/dev/null
}

remov_preq() {
  echo

  if [ -d $ESRCDIR/rlottie ]; then
    read -t 12 -p "Remove rlottie? [Y/n] " answer
    case $answer in
    y | Y)
      cd $ESRCDIR/rlottie
      sudo ninja -C build uninstall
      cd .. && rm -rf rlottie
      echo
      ;;
    n | N)
      printf "\n$ITAL%s $OFF%s\n\n" "(do not remove rlottie... OK)"
      ;;
    *)
      cd $ESRCDIR/rlottie
      sudo ninja -C build uninstall
      cd .. && rm -rf rlottie
      echo
      ;;
    esac
  fi

  if [ -d $ESRCDIR/ddcutil-$DDCTL ]; then
    read -t 12 -p "Remove ddcutil? [Y/n] " answer
    case $answer in
    y | Y)
      cd $ESRCDIR/
      sudo make uninstall
      cd .. && rm -rf $ESRCDIR/ddcutil-$DDCTL
      echo
      ;;
    n | N)
      printf "\n$ITAL%s $OFF%s\n\n" "(do not remove ddcutil... OK)"
      ;;
    *)
      cd $ESRCDIR/ddcutil-$DDCTL
      sudo make uninstall
      cd .. && rm -rf $ESRCDIR/ddcutil-$DDCTL
      echo
      ;;
    esac
  fi
}

# Enlightenment-related files and folders to be removed.
del_list() {
  cd /etc
  sudo rm -rf enlightenment

  cd /etc/xdg/menus
  sudo rm -rf e-applications.menu

  cd /usr/local/bin
  sudo rm -rf efl*

  cd /usr/local/etc
  sudo rm -rf enlightenment

  cd /usr/local/include
  sudo rm -rf -- *-1
  sudo rm -rf enlightenment
  sudo rm -rf express-0

  cd /usr/local/lib/cmake
  sudo rm -rf ddcutil

  cd /usr/local/lib/x86_64-linux-gnu
  sudo rm -rf ecore*
  sudo rm -rf edje*
  sudo rm -rf eeze*
  sudo rm -rf efreet*
  sudo rm -rf elementary*
  sudo rm -rf emotion*
  sudo rm -rf enlightenment*
  sudo rm -rf ephoto*
  sudo rm -rf ethumb*
  sudo rm -rf evas*
  sudo rm -rf rage*
  sudo rm -rf libecore*
  sudo rm -rf libefl*

  cd /usr/local/lib/x86_64-linux-gnu/cmake
  sudo rm -rf Ecore*
  sudo rm -rf Edje*
  sudo rm -rf Eet*
  sudo rm -rf Eeze*
  sudo rm -rf Efl*
  sudo rm -rf Efreet
  sudo rm -rf Eina*
  sudo rm -rf Eio*
  sudo rm -rf Eldbus*
  sudo rm -rf Elementary*
  sudo rm -rf Elua*
  sudo rm -rf Emile*
  sudo rm -rf Emotion*
  sudo rm -rf Eo*
  sudo rm -rf Eolian*
  sudo rm -rf Ethumb*
  sudo rm -rf Evas*

  cd /usr/local/lib/x86_64-linux-gnu/pkgconfig
  sudo rm -rf ecore*
  sudo rm -rf efl*
  sudo rm -rf rlottie*

  cd /usr/local/share
  sudo rm -rf ddcutil*
  sudo rm -rf ecore*
  sudo rm -rf ecrire*
  sudo rm -rf edi*
  sudo rm -rf edje*
  sudo rm -rf eeze*
  sudo rm -rf eflete*
  sudo rm -rf efreet*
  sudo rm -rf elementary*
  sudo rm -rf elua*
  sudo rm -rf embryo*
  sudo rm -rf emotion*
  sudo rm -rf enlightenment*
  sudo rm -rf entice*
  sudo rm -rf enventor*
  sudo rm -rf evisum*
  sudo rm -rf eo*
  sudo rm -rf eolian*
  sudo rm -rf ephoto*
  sudo rm -rf ethumb*
  sudo rm -rf evas*
  sudo rm -rf exactness*
  sudo rm -rf express*
  sudo rm -rf rage*
  sudo rm -rf terminology*
  sudo rm -rf wayland-sessions*

  cd /usr/local/share/applications
  sudo sed -i '/enlightenment_filemanager/d' mimeinfo.cache
  sudo sed -i '/ecrire/d' mimeinfo.cache
  sudo sed -i '/entice/d' mimeinfo.cache
  sudo sed -i '/ephoto/d' mimeinfo.cache
  sudo sed -i '/rage/d' mimeinfo.cache
  sudo rm -rf enlightenment_paledit.desktop
  sudo rm -rf terminology.desktop

  cd /usr/local/share/doc
  sudo rm -rf edi

  cd /usr/local/share/gdb/auto-load/usr/lib
  sudo rm -rf libeo*

  cd /usr/local/share/icons
  sudo rm -rf Enlightenment*

  cd /usr/local/share/info
  sudo rm -rf edi

  cd /usr/share/dbus-1/services
  sudo rm -rf org.enlightenment.Ethumb.service

  cd /usr/share/wayland-sessions
  sudo rm -rf enlightenment.desktop

  cd /usr/share/xsessions
  sudo rm -rf enlightenment.desktop

  cd $HOME
  sudo rm -rf $ESRCDIR/enlighten
  rm -rf $SCRFLDR
  rm -rf .e
  rm -rf .e-log*
  rm -rf .elementary
  sudo chattr -i $HOME/.cache/ebuilds/storepath && rm -rf .cache/ebuilds
  rm -rf .cache/efreet
  rm -rf .cache/ephoto
  rm -rf .cache/evas_gl_common_caches
  rm -rf .cache/rage
  rm -rf .config/ecrire.cfg
  rm -rf .config/edi
  rm -rf .config/eflete
  rm -rf .config/entice
  rm -rf .config/enventor
  rm -rf .config/ephoto
  rm -rf .config/evisum
  rm -rf .config/express
  rm -rf .config/rage
  rm -rf .config/terminology
  rm -rf .local/bin/elucidate.sh
}

final_stp() {
  if [ -f $HOME/.bash_aliases ]; then
    read -t 12 -p "Remove the bash_aliases file? [Y/n] " answer
    case $answer in
    y | Y)
      rm -rf $HOME/.bash_aliases && source $HOME/.bashrc
      sleep 1
      ;;
    n | N)
      printf "\n$ITAL%s $OFF%s\n\n" "(do not delete bash_aliases... OK)"
      sleep 1
      ;;
    *)
      echo
      rm -rf $HOME/.bash_aliases && source $HOME/.bashrc
      sleep 1
      ;;
    esac
  fi

  sudo rm -rf /usr/lib/systemd/user/enlightenment.service
  sudo rm -rf /usr/lib/systemd/user/ethumb.service
  sudo rm -rf /usr/lib/libintl.so
  sudo systemctl daemon-reload
  sudo ldconfig

  # Removes the translation files too.
  find /usr/local/share/locale/*/LC_MESSAGES 2>/dev/null | while read -r I; do
    echo "$I" |
      xargs sudo rm -rf \
        $(grep -E 'efl|enlightenment|ephoto|evisum|terminology|ecrire|edi|enventor|eflete|forecasts|penguins')
  done
}

uninstall_enlighten() {
  if [ "$XDG_CURRENT_DESKTOP" == "Enlightenment" ]; then
    printf "$BLDR%s $OFF%s\n\n" "PLEASE LOG IN TO THE DEFAULT DESKTOP ENVIRONMENT TO EXECUTE THIS SCRIPT."
    beep_exit
    exit 1
  fi

  ESRCDIR=$(cat $HOME/.cache/ebuilds/storepath)

  clear
  printf "\n\n$BLDR%s %s\n\n" "* UNINSTALLING ENLIGHTENMENT DESKTOP ENVIRONMENT *"
  printf "$BLDR%s %s\n\n" "This may take a few minutes."
  sleep 1
  printf "$BLDR%s $OFF%s\n\n" "You will be prompted to answer some basic questions..."
  sleep 1

  cd $HOME

  for I in $PROG_MBS; do
    cd $ESRCDIR/enlighten/$I
    sudo ninja -C build uninstall
    echo
  done

  remov_preq
  del_list
  final_stp
}

# Calls the main function.
lo() {
  trap '{ printf "\n$BLDR%s $OFF%s\n\n" "KEYBOARD INTERRUPT."; exit 130; }' INT

  uninstall_enlighten

  printf "\n$BLDR%s $OFF%s\n\n" "Done!"
  # Candidates for further deletion: Search for “eloge”, “ebackups” and “pbackups” in your home folder.
}

lo
