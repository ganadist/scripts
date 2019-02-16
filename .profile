[ -f /etc/profile.d/vte.sh ] && source /etc/profile.d/vte.sh
if [ -z ${DOT_PROFILE} -a -d ~/.profile.d ]; then
  echo load profiles
  for profile in ~/.profile.d/S[0-9][0-9]*[^~] ; do
	source $profile
  done
  unset profile
  export DOT_PROFILE=1
fi
