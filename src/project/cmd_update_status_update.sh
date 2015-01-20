curl -v -H "Content-Type: application/json" -X PUT \
    --data '{"issue":{"status_id": "$[new_status_id]"}}' \
    -u $[/server/poc/REDMINE_USERNAME]:$[/server/poc/REDMINE_PASSWORD] \
    http://$[/server/poc/REDMINE_HOST]/redmine/issues/$[issue_id].json