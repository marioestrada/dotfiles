function bash_git_branch
{
  git branch 2> /dev/null | grep \* | python -c "print '[git:'+raw_input()[2:]+']'" 2> /dev/null
  #git branch 2> /dev/null | grep \* | awk '{print $2}'
}

export PS1="\[\e[1;31m\]\u\[\e[m\]:\[\e[1;34m\]\W \[\e[1;33m\]\$(bash_git_branch)\[\e[m\]\$ "

. `brew --prefix`/etc/profile.d/z.sh

gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

source /Users/mario/bin/git-completion.bash
