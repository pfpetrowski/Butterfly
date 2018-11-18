n=1
for i in `cat ./nonbuzz_starts.txt | uniq`;
	do 
		echo sox processing nonbuzz $n from Colony3Day170.wav at time point $i
		sox Colony3Day170.wav -n remix 2 trim $i 1 noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Spectrograms/Noisered1s/NonBuzzes/nonbuzz$n.png &
		n=`expr $n + 1`
	done

n=1
for i in `cat ./buzz_starts.txt | uniq`;
	do 
		echo sox processing buzz $n from Colony3Day170.wav at time point $i
		sox Colony3Day170.wav -n remix 2 trim $i 1 noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Spectrograms/Noisered1s/Buzzes/buzz$n.png &
		n=`expr $n + 1`
	done
