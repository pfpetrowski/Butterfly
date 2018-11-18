obsnum=`cat ./nonbuzz_starts.txt | uniq | wc -l`
lim1=`echo $obsnum*0.75 | bc`
lim2=`echo $obsnum*0.9 | bc`

n=1
for i in `cat ./nonbuzz_starts.txt | uniq`;
	do 
		echo sox processing nonbuzz $n from Colony3Day170.wav at time point $i
		if [ $(echo "$n<=$lim1" | bc) ]; then
			sox Colony3Day170.wav ./Data/100msSoundBytes/Train/Buzzes/nonbuzz$n.wav remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 &
		elif [ $(echo "$n>$lim1" | bc) ] && [ $(echo '$n<=$lim2' | bc) ]; then
			sox Colony3Day170.wav ./Data/100msSoundBytes/Validate/Buzzes/nonbuzz$n.wav remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 &
		elif [ $(echo "$n>$lim2" | bc) ] && [ $(echo '$n<=$obsnum' | bc) ]; then
			sox Colony3Day170.wav ./Data/100msSoundBytes/Test/Buzzes/nonbuzz$n.wav remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 &
		else
			echo 'Uh Oh, Something went wrong'
		fi
		n=`expr $n + 1`
	done


obsnum=`cat ./buzz_starts.txt | uniq | wc -l`
lim1=`echo $obsnum*0.75 | bc`
lim2=`echo $obsnum*0.9 | bc`
n=1
for i in `cat ./buzz_starts.txt | uniq`;
	do 
		echo sox processing buzz $n from Colony3Day170.wav at time point $i
		if [ $(echo "$n<=$lim1" | bc) ]; then
			sox Colony3Day170.wav ./Data/100msSoundBytes/Train/NonBuzzes/buzz$n.wav remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 &
		elif [ $(echo "$n>$lim1" | bc) ] && [ $(echo '$n<=$lim2' | bc) ]; then
			sox Colony3Day170.wav ./Data/100msSoundBytes/Validate/NonBuzzes/buzz$n.wav remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 &
		elif [ $(echo "$n>$lim2" | bc) ] && [ $(echo '$n<=$obsnum' | bc) ]; then
			sox Colony3Day170.wav ./Data/100msSoundBytes/Test/NonBuzzes/buzz$n.wav remix 2 trim $i 0.1 noisered ./static10.noise-profile 0.20 &
		else
			echo 'Uh Oh, Something went wrong'
		fi
		n=`expr $n + 1`
	done
