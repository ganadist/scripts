echo load profiles

if [ -d ~/.profile.d ]; then
  for profile in ~/.profile.d/S[0-9][0-9]*[^~] ; do
	source $profile
  done
fi


