+++
author = "Blair Fix"
title = "4. Batch renumbering your script files"
slug = "batch-renumbering-scripts"
date = "2022-07-19"
description = "I wrote a script to renumber my scripts"
tags = [ "batch renumber", "bash", "data pipeline" ]
+++

When I analyze data, I like to write a series of short scripts rather than one long piece of code. I find that by keeping each step of the analysis in its own file, I can better grasp what I'm doing.

The result will be a series of numbered scripts that might look something like this:

```bash
1_get_data.R
2_clean_data.R
3_combine_data.R
4_analyze_data.R
```

As the analysis grows, I accumulate more scripts. And often, I realize that I need to insert a new script somewhere in the middle of the pipeline, meaning the rest of the scripts need to be renumbered. Also, when I accumulate more than 10 scripts, suddenly my computer thinks that `10_` comes before `1_`. So I need to pad all the files with leading zeroes.

Of course this renumbering is a simple task. But it's also a pain in the butt. And so I wrote a bash script that will do it for me.

Here's an example. Suppose I delete the first file in my pipeline:

```bash
2_clean_data.R
3_combine_data.R
4_analyze_data.R
```

To renumber the remaining files, I execute my script, which is called `pad_file`. It will renumber the remain files like this:

```bash
 2_clean_data.R  ---->  01_clean_data.R
 3_combine_data.R  ---->  02_combine_data.R
 4_analyze_data.R  ---->  03_analyze_data.R
```

Then I realize that I need to move the first file to the end of the pipeline. I'm not sure what it's number should be, so I just give it something high, say `05`. I rename it with the `mv` command as:

```bash
mv 01_clean_data.R  05_clean_data.R
```

Then I renumber everything with `pad_file`:

```bash
 02_combine_data.R  ---->  01_combine_data.R
 03_analyze_data.R  ---->  02_analyze_data.R
 05_clean_data.R  ---->  03_clean_data.R
```

When there are only a handful of numbered files, this renumbering command doesn't save much time. But when there are 20 scripts, it's a life saver.

Here's the code for the renumbering script. Execute it in the directory containing the files you want renumbered. It will first show you what it's going to rename, and then prompt you to proceed. 

If you want the script to be executable from anywhere, put it in your [PATH](https://www.techrepublic.com/article/linux-101-what-is-the-linux-path/) and give it a name you like. You can then execute it by typing that name in the terminal. I call mine `pad_file`.




```bash
#!/bin/bash

# A bash script to renumber files

# test rename
#-------------------------------------------

# get files containing number
files=$( ls | grep '^[0-9]' | sort --version-sort )

# output color
RED='\033[0;31m'


n=1;
for f in $files; do
    
    # strip numbers from file
    file_name=$( printf '%s\n' "${f//[[:digit:]]/}" )

    # pad file number
    file_number=$( printf %02d $n)

    # new file name
    file_new="$file_number""$file_name"

    echo $(tput setaf 2) $f  $(tput setaf 5) '---->' $(tput setaf 4) $file_new $(tput setaf 7)

    let n="$n+1"

done



# actually rename
#-------------------------------------------

echo Type GO to rename files
read test 

if [ $test == "GO" ] ; 
then

    echo renaming ...

    n=1;
    for f in $files; do
	
	# strip numbers from file
	file_name=$( printf '%s\n' "${f//[[:digit:]]/}" )

	# pad file number
	file_number=$( printf %02d $n)

	# new file name
	file_new="$file_number""$file_name"
	
	# test if file names are different
	# rename files
	mv $f $file_new

	let n="$n+1"

    done

fi
```



