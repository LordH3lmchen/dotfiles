#!/bin/bash

i3-msg "workspace 2; append_layout ~/.i3/workspace_main.json"

(termite &)
(termite &)
(google-chrome-stable --new-window https://archlinux.org/ &)

sleep 0.5
i3-msg "workspace 3; append_ layout ~/.i3/workspace_2.json"

(google-chrome-stable --new-window https://invoice.moneysoft.at/ "https://docs.google.com/spreadsheets/d/1pzG7KXYuCD3erY6tWFBBpozeCGijT-bm5cR9CKxVPo4/edit#gid=87528301" &)
