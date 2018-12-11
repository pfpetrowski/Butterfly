timefile=./nonbuzz_starts
soundfile=Colony3Day170.wav

window=0.1

obsnum=`cat $timefile | uniq | wc -l`
lim1=`echo $obsnum*0.75 | bc`
lim2=`echo $obsnum*0.9 | bc`

n=1
for i in `cat $timefile | uniq`;
	do 
		echo sox processing nonbuzz $n from $soundfile at time point $i
		if [ $(echo "$n<=$lim1" | bc) -eq 1 ]; then
			sox $soundfile -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered100ms/Train/NonBuzzes/nonbuzz$n.png &
		elif [ $(echo "$n>$lim1" | bc) -eq 1 ] && [ $(echo "$n<=$lim2" | bc) -eq 1 ]; then
			sox $soundfile -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered100ms/Validate/NonBuzzes/nonbuzz$n.png &
		elif [ $(echo "$n>$lim2" | bc) -eq 1 ] && [ $(echo "$n<=$obsnum" | bc) -eq 1 ]; then
			sox $soundfile -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered100ms/Test/NonBuzzes/nonbuzz$n.png &
		else
			echo 'Uh Oh, Something went wrong'
		fi
		n=`expr $n + 1`
	done


exit


timefile=./buzz_starts
soundfile=Colony3Day170.wav


obsnum=`cat $timefile | uniq | wc -l`
n=1
for i in `cat $timefile | uniq`;
	do 
		echo sox processing buzz $n from $soundfile at time point $i
		if [ $(echo "$n<=$lim1" | bc) -eq 1 ]; then
			sox $soundfile -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered100ms/Train/Buzzes/buzz$n.png &
		elif [ $(echo "$n>$lim1" | bc) -eq 1 ] && [ $(echo "$n<=$lim2" | bc) -eq 1 ]; then
			sox $soundfile -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered100ms/Validate/Buzzes/buzz$n.png &
		elif [ $(echo "$n>$lim2" | bc) -eq 1 ] && [ $(echo "$n<=$obsnum" | bc) -eq 1 ]; then
			sox $soundfile -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered100ms/Test/Buzzes/buzz$n.png &
		else
			echo 'Uh Oh, Something went wrong'
		fi
		n=`expr $n + 1`
	done
