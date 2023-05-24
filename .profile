# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/profile.pre.bash" ]] && . "$HOME/.fig/shell/profile.pre.bash"
# vim: ts=2 sw=2 sts=2 et ai
#set -x
[ -f /etc/profile.d/vte.sh ] && source /etc/profile.d/vte.sh

# workaround for 
# https://github.com/systemd/systemd/issues/6414
# https://github.com/systemd/systemd/issues/7641
for want_import in PATH PYTHONSTARTUP PYTHONUSERBASE ANDROID_SDK_ROOT ANDROID_HOME LINE_ANDROID_REPO DBUS_SESSION_BUS_ADDRESS SESSION_MANAGER SSH_AUTH_SOCK
for S in /usr/lib/systemd/user-environment-generators/[0-9]*
do
  P=$($S | grep ^$want_import | xargs)
  if [ -n "$P" ]; then
    export $P
  fi
  unset P
done
#systemctl --user import-environment PATH



ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export ANDROID_SDK_ROOT PATH

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/profile.post.bash" ]] && . "$HOME/.fig/shell/profile.post.bash"
