n=1
for i in `cat ./nonbuzz_starts.txt | uniq`;
	do 
		echo sox processing nonbuzz $i from Colony3Day170.wav at time point $n
		sox Colony3Day170.wav -n remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Spectrograms/NonBuzzes/nonbuzz$n.png &
		n=`expr $n + 1`
	done

n=1
for i in `cat ./buzz_starts.txt | uniq`;
	do 
		echo sox processing buzz $i from Colony3Day170.wav at time point $n
		sox Colony3Day170.wav -n remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 spectrogram -X 2000 -y 200 -m -r -o ./Spectrograms/Buzzes/buzz$n.png &
		n=`expr $n + 1`
	done
