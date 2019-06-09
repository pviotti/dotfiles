#!/bin/bash
# Simple script to change keyboard layout

current=`setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}'`
case $current in
	ie)
		setxkbmap it
		;;
	*)
		setxkbmap ie
		;;
esac
