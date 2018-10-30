n=1
for i in `cat nonbuzz_starts.txt | uniq`;
	do 
		echo sox Colony3Day170.wav -n remix 2 trim $i 1 spectrogram -m -r -o ./NonBuzzes/nonbuzz$n.png
		sox Colony3Day170.wav -n remix 2 trim $i 1 spectrogram -m -r -o ./NonBuzzes/nonbuzz$n.png
		n=`expr $n + 1`
	done
