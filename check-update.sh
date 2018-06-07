#! /bin/bash
#script check github repository, and if one are updated, then send webhook or rebuild images.
set -e
. .mail_to

NOTIFY=0
#check update
gitChecksum(){
  git ls-remote -h https://github.com/$1 master | cut -f1
}

gitRelease(){
curl --silent "https://api.github.com/repos/$1/releases/latest" | sed -nr 's/.*"tag_name": "(.*)",/\1/p'
}

log() {
echo "$@"
echo "$(date): $@" >> $tmp
}


compareChecksum() {
repo=$1
if grep "$repo" $webhook >/dev/null; then
id_old=$(grep "$repo" $webhook | cut -d" " -f2)
	if [[ "$id_old" == "$id_new" ]];then
		log "already up to date: $repo"
	else
		log "UPDATE NEEDED: $repo"
		send-webhook
	fi
else
	log "ajout de $repo dans $webhook ($id_new)"
	log "$repo $id_new" >> $webhook
fi
}

#send webhook to $url, it whil update image on the docker hub

send-webhook() {
if grep webhookurl $webhook >/dev/null; then
  url=$(grep webhookurl $webhook | cut -d" " -f2)
  if curl --data build=true -X POST $url >/dev/null ;then
    log "web trigger send to $url"
    sed -ie "s!$id_old!$id_new!" $webhook
#    send-email
    NOTIFY=$(($NOTIFY + 1))
  else
    log "failed to send to $url"
  fi
else
  log "no webhookurl found in $webhook"
fi
}

send-email(){
cat $tmp | mail -s "Docker update" $mail_to
}

## MAIN ##
tmp=$(mktemp)
for d in $(ls -d ./*/); do
  [[ ! -e $d.webhook ]]  && continue
  webhook=$d.webhook
  log "check update for $d"
	sed -nr '/github\.com.*release.*/d;s/.*https:\/\/github\.com\/([a-zA-Z0-9_-]*)\/([a-zA-Z0-9_-]*).*/\1\/\2/p' $d/Dockerfile | \
	while read -r; do
		id_new="$(gitChecksum $REPLY)"
		compareChecksum $REPLY $id_new
	done

	sed -nr '/github\.com.*release.*/!d;s/.*https:\/\/github\.com\/([a-zA-Z0-9_-]*)\/([a-zA-Z0-9_-]*).*/\1\/\2/p' $d/Dockerfile | \
	while read -r; do
		id_new="$(gitRelease $REPLY)"
		compareChecksum $REPLY $id_new
	done
  log""
done

if [ $NOTIFY -gt 0 ]; then
	cat $tmp | /usr/bin/slack-push.sh Docker-update info "$NOTIFY MaJ docker"
fi

rm $tmp
