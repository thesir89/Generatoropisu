#!/bin/bash
#echo "Witam w generatorze dokumentacji projektowej dla zadań sanitarnych"

### Zmienne bazowe
me=`basename "$0"`
source ./src/silnik.sh
START_TEST
DIR=$DIRECTORY
LOG=$LOGFILE

### Menu główne	
# clear the screen
tput clear

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="B&B Jan Burglin"
TITLE="Generator dokumentów"
MENU="Wybierz co chcesz zrobić:"

OPTIONS=(1 "Nowy dokument"
         2 "Edytuj dokument"
	 3 "Importuj dokumentu"
	 4 "Wyjście")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in

### Nowy dokument
	1)
LOOP_CLR_TMP
	dialog --title "Nazwa katalogu" \
		--backtitle "$BACKTITLE" \
		--inputbox "Podaj nazwę katalogu " 8 60 2>$OUTPUT
LOOP_GET_RSP
	nazwakatalogu=$(<$OUTPUT)
	nazwakatalogu_bezspacji="$(echo -e "${nazwakatalogu}" | tr -d '[:space:]')"
	echo -e "nazwakatalogu_bezspacji='${nazwakatalogu_bezspacji}'"
LOOP_PRO_END 
	if [ -e ./Docs/$nazwakatalogu_bezspacji ] ; then
		echo "Katalog już istnieje!"
	      	echo "dla bezpieczeństwa przed nadpisaniem, wychodzę"
		echo "podaj inną nazwę, lub przemianuj stary katalog"
		exit
      	      fi
### Tworzenie katalogu zadania
			     LOGFILE="$nazwakatalogu_bezspacji.log"
			     DIRECTORY="$nazwakatalogu_bezspacji"
		     	     echo "Tworzę katalog : $DIRECTORY" >> ./tmp/nazwa
			     echo "Tworzę plik log : $LOGFILE" >> ./tmp/nazwa
			     dialog --title "Info" \
				    --backtitle "$BACLTITLE" \
				    --textbox ./tmp/nazwa 8 60 \
				    #2>&1 >/dev/tty
			     rm ./tmp/nazwa
			     mkdir ./Docs/$DIRECTORY/ 
			     touch ./Docs/$DIRECTORY/$LOGFILE
			     echo "##########################" > ./Docs/$DIRECTORY/$LOGFILE

			     echo "#Utworzono `date +%Y.%m.%d`" >> ./Docs/$DIRECTORY/$LOGFILE
			     echo "#!/bin/bash" >> ./Docs/$DIRECTORY/$LOGFILE
### Liczba inwestorów
LOOP_CLR_TMP      
	dialog --title "Ilość inwestorów" \
	    	--backtitle "$BACKTITLE" \
		--inputbox "Podaj liczbę inwestorów" 8 60 2>$OUTPUT
LOOP_GET_RSP    
	liczbainwestorow=$(<$OUTPUT)
LOOP_PRO_END
	echo "liczbainwestorow=\"$liczbainwestorow\"" >> ./Docs/$DIRECTORY/$LOGFILE
### Dane inwestora

for ((i=1;i<=$liczbainwestorow;i++));
do
  ### Imię i nazwisko inwestora	
  LOOP_CLR_TMP
	dialog --title "Nazwa inwestora" \
		--backtitle "$BACKTITLE" \
		--inputbox "Podaj nazwę inwestora nr $i" 8 60 2>$OUTPUT
  LOOP_GET_RSP
	nazwainwestora=$(<$OUTPUT)
  LOOP_PRO_END
	echo "nazwainwestora$i=\"$nazwainwestora\"" >> ./Docs/$DIRECTORY/$LOGFILE
  ### Ulica inwestora
  LOOP_CLR_TMP 
	dialog --title "Adres inwestora" \
		--backtitle "$BACKTITLE" \
		--inputbox "Podaj ulicę inwestora nr $i" 8 60 2>$OUTPUT
  LOOP_GET_RSP
	ulica_inwestora=$(<$OUTPUT)
  LOOP_PRO_END	     
	echo "ulica_inwestora$i=\"$ulica_inwestora\"" >> ./Docs/$DIRECTORY/$LOGFILE
  ### Miasto inwestora
  LOOP_CLR_TMP
	dialog --title "Miasto inwestora"\
		--backtitle "$BACKTITLE" \
		--inputbox "Podaj miasto inwestora nr $i" 8 60 2>$OUTPUT
  LOOP_GET_RSP
	miastoinwestora=$(<$OUTPUT)
  LOOP_PRO_END
	echo "miastoinwestora$i=\"$miastoinwestora\"" >> ./Docs/$DIRECTORY/$LOGFILE
  ### Adres inwestycji
  LOOP_CLR_TMP			      
	dialog --title "Adres inwestora" \
		--backtitle "$BACKTITLE" \
		--inputbox "Podaj kod pocztowy inwestora nr $i" 8 60 2>$OUTPUT
  LOOP_GET_RSP
	kodpocztowyinwestora=$(<$OUTPUT)
  LOOP_PRO_END
	echo "kodpocztowyinwestora$i=\"$kodpocztowyinwestora\"" >> ./Docs/$DIRECTORY/$LOGFILE

done			     
### Nazwa zadania
LOOP_CLR_TMP
	dialog --title "Nazwa zadania" \
		--backtitle "$BACKTITLE" \
		--inputbox "Podaj nazwę zadania" 8 60 2>$OUTPUT
LOOP_GET_RSP
	nazwazadania=$(<$OUTPUT)
LOOP_PRO_END
	echo "nazwazadania=\"$nazwazadania\"" >> ./Docs/$DIRECTORY/$LOGFILE
### Obręb ewid
LOOP_CLR_TMP
	dialog --title "Obręb ewidencyjny" \
		--backtitle "$BACKTITLE" \
		--yesno "Czy inwestycja obejmuje jeden obręb ewidencyjny? " 8 60 2>$OUTPUT
LOOP_GET_RSP
LOOP_YN_END "obrebewid" "Obręby ewidencyjne" "Podaj obręb ewidencyjny np. Chojnice 0001" "Podaj ilość obrębów ewidencyjnych w inwestycji"

### Jednostka ewid 
LOOP_CLR_TMP
	dialog --title "Jednostka ewidencyjna" \
		--backtitle "$BACKTITLE" \
		--yesno "Czy inwestycja obejmuje tylko jedną jednostkę ewidencyjną?" 8 60 2>$OUTPUT
LOOP_GET_RSP
LOOP_YN_END "jewid" "Jednostki ewidencyjne" "Podaj jednostkę ewidencyjną np. Chojnice - 220201_1" "Podaj ilość jednostek ewidencyjnych w inewstycji"
### Działki geod
#LOOP_CLR_TMP
	dialog --title "Działki geodezyjne"\
		--backtitle "$BACKTITLE"\
		--yesno "Czy inwestycja swoim zakresem obejmuje tylko jedną działkę geodezyjną?" 8 60 2>$OUTPUT
LOOP_GET_RSP
LOOP_DZ_GEOD "dzgeod" "Działki geodezyjne" "Podaj działkę geodezyjną np. 115/2" "Podaj ilość działek geodezyjnych wchodzących w skład inwestycji"	
#	dialog --title "Działki geodezyjne"
#	cmd=(dialog --separate-output --checklist "Wybierz wymagane opcje:" 22 76 16)
#	options=(1 "Option 1" off    # any option can be set to default to "on"
#	         2 "Option 2" off
#	         3 "Option 3" off
#	         4 "Option 4" off)
#	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
#		clear
#		for choice in $choices
#		do
#			case $choice in
#				1)
#					echo "First Option"
#					;;
#				2)
#					echo "Second Option"
#					;;
#				3)
#					echo "Third Option"
#					;;
#				4)
#					echo "Fourth Option"
#					;;
#			esac
#		done
#	
              ;;
          2)
              echo "You chose Option 2"
	      LOOP_CLR_TMP
	        dialog --title "Lista plików" --dselect ./Docs 50 50
              ;;
          3)
              echo "You chose Option 3"
              ;;
      	  4)
   	      echo "Wybrałeś Wyjście, żegnaj (╥﹏╥)"
	      ;;

esac


if [ "$choice" == 4 ] ; then
		dialog --title "Delete file" \
		--backtitle "Linux Shell Script Tutorial Example" \
		--yesno "Are you sure you want to permanently delete \"/tmp/foo.txt\"?" 7 60
	 
	# Get exit status
	# 0 means user hit [yes] button.
	# 1 means user hit [no] button.
	# 255 means user hit [Esc] key.
	response=$?
	case $response in
		   0) echo "File deleted."
			   
			   ;;
		      1) echo "File not deleted."
			      OUTPUT="/tmp/input.txt"
			      # create empty file
			      >$OUTPUT

			      # Purpose - say hello to user 
			      #  $1 -> name (set default to 'anonymous person')
			      function sayhello(){
				      	local n=${@-"anonymous person"}
					#display it
					dialog --title "Hello" --clear --msgbox "Hello ${n}, let us be friends!" 10 41
  		 	      }
			      # cleanup  - add a trap that will remove $OUTPUT
			      # if any of the signals - SIGHUP SIGINT SIGTERM it received.
			      trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

			      # show an inputbox
			      dialog --title "Inputbox - To take input from you" \
				     --backtitle "Linux Shell Script Tutorial Example" \
				     --inputbox "Enter your name " 8 60 2>$OUTPUT

			      # get respose
			      respose=$?
			      # get data stored in $OUPUT using input redirection
			      name=$(<$OUTPUT)

			      # make a decsion 
			      case $respose in
			  0) 
			      sayhello ${name} 
			      ;;
			  1) 
			      echo "Cancel pressed."
			      ;;
			  255) 
			      echo "[ESC] key pressed."
			esac
			     # remove $OUTPUT file
			     rm $OUTPUT
			     ;;
		         255) echo "[ESC] key pressed.";;
			 esac
			 echo "Zamykam"
	exit
fi

#date +%Y.%m.%d
