#!/bin/bash
time=$(date "+%Y-%m-%d %H:%M:%S")
echo $time >> git.log
echo "Start git!" >> git.log
echo "\$ pwd"  >> git.log
echo `pwd`  >> git.log
echo "\$ git pull"  >> git.log
git pull >> git.log
if [ $? -ne 0 ]; then
	echo "\$ git pull failed"  >> git.log
else
	if [ $1x = "pushx" ]; then
		echo "\$ git status"  >> git.log
		git status   >> git.log
		echo "\$ git add ." >> git.log
		git add .  >> git.log
		echo "\$ git commit -m \"time\"" >> git.log
		git commit -m "${time}"  >> git.log
		echo "\$ git push" >> git.log
		git push  >> git.log
		if [ $? -ne 0 ]; then
			echo "\$ git push failed" >> git.log
		else
			echo "push success" >> git.log
		fi
	fi
fi
echo "############End#############" >> git.log
