window=1

obsnum=`cat ./nonbuzz_starts.txt | uniq | wc -l`
lim1=`echo $obsnum*0.75 | bc`
lim2=`echo $obsnum*0.9 | bc`

n=1
for i in `cat ./nonbuzz_starts.txt | uniq`;
	do 
		echo sox processing nonbuzz $n from Colony3Day170.wav at time point $i
		if [ $(echo "$n<=$lim1" | bc) -eq 1 ]; then
			sox Colony3Day170.wav -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered1s/Train/NonBuzzes/nonbuzz$n.png &
		elif [ $(echo "$n>$lim1" | bc) -eq 1 ] && [ $(echo "$n<=$lim2" | bc) -eq 1 ]; then
			sox Colony3Day170.wav -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered1s/Validate/NonBuzzes/nonbuzz$n.png &
		elif [ $(echo "$n>$lim2" | bc) -eq 1 ] && [ $(echo "$n<=$obsnum" | bc) -eq 1 ]; then
			sox Colony3Day170.wav -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered1s/Test/NonBuzzes/nonbuzz$n.png &
		else
			echo 'Uh Oh, Something went wrong'
		fi
		n=`expr $n + 1`
	done


obsnum=`cat ./buzz_starts.txt | uniq | wc -l`
n=1
for i in `cat ./buzz_starts.txt | uniq`;
	do 
		echo sox processing buzz $n from Colony3Day170.wav at time point $i
		if [ $(echo "$n<=$lim1" | bc) -eq 1 ]; then
			sox Colony3Day170.wav -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered1s/Train/Buzzes/nonbuzz$n.png &
		elif [ $(echo "$n>$lim1" | bc) -eq 1 ] && [ $(echo "$n<=$lim2" | bc) -eq 1 ]; then
			sox Colony3Day170.wav -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered1s/Validate/Buzzes/buzz$n.png &
		elif [ $(echo "$n>$lim2" | bc) -eq 1 ] && [ $(echo "$n<=$obsnum" | bc) -eq 1 ]; then
			sox Colony3Day170.wav -n remix 2 trim $i $window noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Data/Noisered1s/Test/Buzzes/buzz$n.png &
		else
			echo 'Uh Oh, Something went wrong'
		fi
		n=`expr $n + 1`
	done
