n=1
for i in `cat ./nonbuzz_starts.txt | uniq`;
	do 
		echo sox Colony3Day170.wav -n remix 2 trim $i 0.1 spectrogram -x 200 -y 200 -m -r -o ./Spectrograms/NonBuzzes/nonbuzz$n.png
		sox Colony3Day170.wav -n remix 2 trim $i 0.1 spectrogram -x 200 -y 200 -m -r -o ./Spectrograms/NonBuzzes/nonbuzz$n.png &
		n=`expr $n + 1`
	done

n=1
for i in `cat ./buzz_starts.txt | uniq`;
	do 
		echo sox Colony3Day170.wav -n remix 2 trim $i 0.1 spectrogram -x 200 -y 200 -m -r -o ./Spectrograms/Buzzes/buzz$n.png
		sox Colony3Day170.wav -n remix 2 trim $i 0.1 spectrogram -x 200 -y 200 -m -r -o ./Spectrograms/Buzzes/buzz$n.png &
		n=`expr $n + 1`
	done
