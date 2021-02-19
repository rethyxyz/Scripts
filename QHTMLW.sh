#!/bin/bash
#TODO: clean this up
#TODO: reduce redundancy
#TODO: Most if statements should be converted to case statements at some point

write_tag_to_file () {
	if [ $choice -eq 1 ]
	then
		echo -e "$open_tag$text$close_tag" >> $filename #open, text, close, filename
	else
		echo -e "$open_tag$text>$title$close_tag" >> $filename #open, text, title, close, filename
	fi
	counter=$((counter+1)) #counter                    
}

write_on_exit () {
	echo -e "</body>" >> $filename
	echo -e "</html>" >> $filename
	exit 0
}

main () {
    counter=0

	echo "Insert the filename of the file you want to create (omit .HTML suffix in title): "
    read filename

	echo -e "What do you want to name the website?"
	read title

	filename=$(echo $filename | tr -d ' ')

	#TODO: Remove spaces from $filename
	filename="${filename}.html" #.html is suffix of $filename

    if [ -e "$filename" ]
	then
        echo "ERROR: File exists"
		exit 1
    else
        echo -e "<html>\n" >> $filename
        echo -e "<head>" >> $filename
        echo -e "<title>$title</title>" >> $filename
        echo -e "</head>\n" >> $filename
        echo -e "<body>" >> $filename
	fi

    while :
	do
        echo -e "Number of additions this session: $counter\n"
        while :
		do
			echo -e "h) Create a header\np) Create a paragraph\nl) Create a hyperlink\ni) Create an image\n\nq) Quit\n"
            read user_input

            if [ -z $user_input ]
			then
				echo "ERROR: Choice cannot be empty"
            else
				if [ $user_input = 'h' ] || [ $user_input = 'p' ] || [ $user_input = 'l' ] || [ $user_input = 'i' ] || [ $user_input = 'q' ]
				then
					break
				else
					echo "ERROR: Choice does not exist"
				fi
			fi
		done
		message=$(echo -e "Input the text you want to use in the section: ")
		choice=1
		if [ $user_input = "h" ]
		then
			while :
			do
				echo -e "1) Create a h1 title\n2) Create a h2 title\n3) Create a h3 title\n\nq) Quit\n"
				read user_input

				if [ -z $user_input ]
				then
					echo "ERROR: Entry cannot be blank"
				else
					if [ $user_input = '1' ] || [ $user_input = '2' ] || [ $user_input = '3' ] || [ $user_input = 'q' ]
					then
						break
					else
						echo "ERROR: Choice does not exist"
					fi
				fi
			done

			if [ $user_input -eq 1 ]
			then
				title=""
				open_tag="<h1>"
				close_tag="</h1>"
			elif [ $user_input -eq 2 ]
			then
				title=""
				open_tag="<h2>"
				close_tag="</h2>"
			elif [ $user_input -eq 3 ]
			then
				title=""
				open_tag="<h3>"
				close_tag="</h3>"
			else
				write_on_exit
			fi

        elif [ $user_input = "p" ]
		then
            title=""
			open_tag="<p>"
            close_tag="</p>"
        elif [ $user_input = "i" ]
		then
            title=""
            message="Insert the path to image (ex: ./images/photo.png): "
			open_tag="<img src='"
            close_tag="'>"
        elif [ $user_input = "q" ]
		then
            write_on_exit
        else
            choice=2
            while :
			do
                echo "Insert the link title you want to display on the website: "
				read title
                if [ -z $title ]
				then
                    echo "Entry cannot be blank"
                else
                    message="Insert the link you want to embed: "
					open_tag="<a href='"
                    close_tag="</a>"
                    break
				fi
			done
		fi

		echo "Input the text you want to use in the section: "
		read text
		write_tag_to_file
	done
}

main
