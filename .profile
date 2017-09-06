echo load profiles
[ -f /etc/profile.d/vte.sh ] && source /etc/profile.d/vte.sh
if [ -d ~/.profile.d ]; then
  for profile in ~/.profile.d/S[0-9][0-9]*[^~] ; do
	source $profile
  done
  unset profile
fi
