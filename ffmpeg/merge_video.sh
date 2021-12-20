#!/bin/bash

######Mô tả######
#Input: 1 video có âm thanh nền (ko có tiếng người) , list audio mp3 với start time audio sẽ đc play.
#Output: Ghép thành 1 video với âm thanh nền và các audio sẽ được nối theo start time có sẵn vào video đó. 
# Audio cần được lọc tạp âm, tăng volumne lên 20% so với âm thanh gốc.

ffmpeg -hide_banner -i v2.mp4 -i 1.mp3 -i 2.mp3 -i 3.mp3 -i 4.mp3 -i 5.mp3 -i 6.mp3 -filter_complex "
    [1]adelay=4120|4120, atempo=1.0[s1];
    [2]adelay=7620|7620[s2];
    [3]adelay=9440|9440[s3];
    [4]adelay=11600|11600[s4];
    [5]adelay=17440|17440[s5];
    [6]adelay=20400|20400[s6];
    [0][s1][s2][s3][s4][s5][s6]amix=7,
    afftdn=nf=-25,highpass=f=200,lowpass=f=3000,
    volume=20.0[mixout]" -map 0:v -map "[mixout]" -c:v copy -y result.mp4
