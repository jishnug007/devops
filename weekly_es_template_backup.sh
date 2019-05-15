

git clone https://github.com/jishnug007/devops.git
cd devops
mkdir weekly_backup
cd weekly_backup
CurrentDate=`date +"%Y-%m-%d"`
curl -s localhost:9200/_template | jq . > template_backup_$CurrentDate.json

git add -A
git commit -m "template_backup_$CurrentDate.json"
git push
