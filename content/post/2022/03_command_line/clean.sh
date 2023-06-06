#!/usr/bin/env bash


# meta data for figures
#---------------------------------------------
wordpress=false
fig_location="analysis/figures/"
month="2022/07/"
fig_iteration="0"


# get most recent draft
#---------------------------------------------

# source dir
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# get most recent draft
post=$(find . -maxdepth 1 -mindepth 1  -name '*[0-9].md' | sort | tail -n 1)

# remove fig-width
sed "/fig-width/d" $post > tmp.md


# convert markdown to html
#---------------------------------------------
#pandoc --wrap=none --filter pandoc-eqnos --mathjax $post -o temp.html
pandoc --wrap=none --mathjax tmp.md -o temp.html


# format header and footer of post, add references,	
#---------------------------------------------

# split body and footer
sed -n '/footer_here/q;p' temp.html > body.html
sed -n '/footer_here/,$p'  temp.html > foot.html
sed -i 's/footer_here//g' foot.html

# get wordpress header and footer
header=~/Dropbox/cloud_work/blog/pages/utilities/frontmatter/header
footer=~/Dropbox/cloud_work/blog/pages/utilities/frontmatter/footer



# make final draft for local editing
#---------------------------------------------
cat $header body.html foot.html > final_draft.html
echo "</body>" >> final_draft.html
echo "</html>" >> final_draft.html


# switch to firefox and refresh browser
#---------------------------------------------
wtype -M alt ';' -m ctrl
wtype -P f5  -p f5

# remove temporary files
rm temp.html foot.html body.html tmp.md


