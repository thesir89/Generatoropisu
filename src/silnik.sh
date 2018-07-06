#!/bin/bash
DIR=$DIRECTORY
LOG=$LOGFILE
YNCOUNT=0
LOOP_CLR_TMP() {
	OUTPUT="./tmp/input.txt"
	# Stwórz pusty plik
	>$OUTPUT
	# if any of the signals - SIGHUP SIGINT SIGTERM it received.
	trap " rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM

}
LOOP_GET_RSP() {
	# get response
	response=$?
	# get data stored in $OUTPUT using input redirection
}
LOOP_PRO_END() {
# make a decision
 case $response in
   #0)
		
   #;;
   
   1)
	echo "Cancel."
   ;;
   255)
	echo "[ESC] Wyjście."
esac
	# remove $OUTPUT file
	rm $OUTPUT
}
LOOP_YN_END() {
 case $response in
	 0)
		YNCOUNT=$YNCOUNT + 1
			LOOP_N$YNCOUNT_1=$1
			LOOP_N$YNCOUNT_2=$2
			LOOP_N$YNCOUNT_3=$3
			LOOP_N$YNCOUNT_4=$4
		a=$1
		b=$2
		c=$3
		d=$4
		LOOP_CLR_TMP
		dialog --title "$b" \
		       --backtitle "$BACKTITLE"\
	       		--inputbox "$c" 8 60 2>$OUTPUT
		 LOOP_GET_RSP
		 	e=$(<$OUTPUT)
		 LOOP_PRO_END
		 echo "$a=\"$e\"" >> ./Docs/$DIRECTORY/$LOGFILE
		 ;;
	 1)
 		YNCOUNT=$YNCOUNT + 1
			LOOP_N$YNCOUNT_1=$1
			LOOP_N$YNCOUNT_2=$2
			LOOP_N$YNCOUNT_3=$3
			LOOP_N$YNCOUNT_4=$4

		a=$1
		b=$2
		c=$3
		d=$4
		f=$a\ilosc
		LOOP_CLR_TMP
			dialog --title "$b" \
				--backtitle "$BACKTITLE" \
				--inputbox "$d" 8 60 2>$OUTPUT
		LOOP_GET_RSP
			e=$(<$OUTPUT)
		LOOP_PRO_END
			echo "$f=\"$e\"" >> ./Docs/$DIRECTORY/$LOGFILE
			for ((i=1;i<=$e;i++));
			do
			 LOOP_CLR_TMP
			 dialog --title "$b" \
				--backtitle "$BACKTITLE" \
				--inputbox "$c nr $i" 8 60 2>$OUTPUT
			 h=$a$i
			 LOOP_GET_RSP
			 	j=$(<$OUTPUT)
			 LOOP_PRO_END	
			 echo "$h=\"$j\"" >> ./Docs/$DIRECTORY/$LOGFILE
			 done
			 ;;
	255) echo "[ESC] key pressed..."
		YNCOUNT=$YNCOUNT+1
			;;
 esac
}
LOOP_DZ_GEOD() {
 case $response in
	 0)
		YNCOUNT=$YNCOUNT+1
			LOOP_N$YNCOUNT_1=$1
			LOOP_N$YNCOUNT_2=$2
			LOOP_N$YNCOUNT_3=$3
			LOOP_N$YNCOUNT_4=$4
		zmienna=$1
		tytul=$2
		pyt=$3
		pyt_i=$4
		LOOP_CLR_TMP
		dialog --title "$tytul" \
		       --backtitle "$BACKTITLE"\
	       		--inputbox "$pyt" 8 60 2>$OUTPUT
		 LOOP_GET_RSP
		 	e=$(<$OUTPUT)
		 LOOP_PRO_END
		 echo "$zmienna=\"$e\"" >> ./Docs/$DIRECTORY/$LOGFILE
		 ;;
	 1)
		YNCOUNT=$YNCOUNT+1
			LOOP_N$YNCOUNT_1=$1
			LOOP_N$YNCOUNT_2=$2
			LOOP_N$YNCOUNT_3=$3
			LOOP_N$YNCOUNT_4=$4
		tytul=$2
		pyt=$3
		pyt_i=$4
		f=$zmienna\ilosc
		LOOP_CLR_TMP
			dialog --title "$tytul" \
				--backtitle "$BACKTITLE" \
				--inputbox "$pyt_i" 8 60 2>$OUTPUT
		LOOP_GET_RSP
			e=$(<$OUTPUT)
		LOOP_PRO_END
			echo "$f=\"$e\"" >> ./Docs/$DIRECTORY/$LOGFILE
			for ((i=1;i<=$e;i++));
			do
			 LOOP_CLR_TMP
			 dialog --title "$tytul" \
				--backtitle "$BACKTITLE" \
				--inputbox "$pyt nr $i" 8 60 2>$OUTPUT
			 h=$zmienna$i
			 LOOP_GET_RSP
			 	j=$(<$OUTPUT)
			 LOOP_PRO_END	
			 echo "$h=\"$j\"" >> ./Docs/$DIRECTORY/$LOGFILE
			 if [ $obrebewidilosc > 0 ] ; then
				 OUTPUT2=./tmp/output2.txt
				 >$OUTPUT2
				 echo -n "OPTIONS1=(1 "$LOOP_N1_1" #poprawic!!!!!!
				 for ((i=1;i<=$obrebewidilosc;i++));
				 do
					 echo -n "
		  	   dialog --title "$tytul" \
				  --backtitle "$BACKTITLE"\
				  --radiolist "Wybierz obręb ewidencyjny działki geod. nr $h" 20 61 5 \
			     for ((i=1;i<=$obrebewidilosc;i++));
			     do
	#			     #wtfwtfwtf
	#		     LOOP_CLR_TMP
	#		     cel=obrebewid$i
	#		     "" "$cel" off \
			     done
	#		     "" "" off 2>$OUTPUT
	#		     LOOP_GET_RSP
		   	  fi
			  ;;
	255) echo "[ESC] key pressed."
	YNCOUNT=$TNCOUNT+1	

		;;
 esac
}


START_TEST() {
### Test istnienia katalogu Docs
if [ ! -e ./Docs/ ] ; then
	echo ""
	echo "Brak katalogu z dokumentami..."
	sleep 1
	echo ""
	echo "Utworzono."
	mkdir ./Docs/
	read -n1 -r -p "Naciśnij dowolny klawisz..." key
fi

### Test istnienia pliku do backupu skryptu

if [ ! -e ./backup.sh ] ; then
	echo ""
	echo "Brak pliku backup... "
	echo "#!/bin/bash" > backup.sh
	echo "nazwa=$me" >> backup.sh
	echo "kopia=\"\`date +%d.%m\` \`date +%R\` test.sh\"" >> backup.sh
	echo "cp \"$nazwa\" \"$kopia\"" >> backup.sh
	sleep 1
	echo ""
	echo "Utworzono."
	read -n1 -r -p "Naciśnij dowolny klawisz..." key

fi

### Test istnienia lokalnego katalogu tmp

if [ ! -e ./tmp/ ] ; then
	echo ""
	echo "Brak katalogu tymczasowego..."
	sleep 1
	echo ""
	mkdir ./tmp/
	read -n1 -r -p "Naciśnij dowolny klawisz..." key
fi
}
