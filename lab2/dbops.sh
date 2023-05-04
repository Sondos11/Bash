function authenticate {
	echo "Authentication.."
}

function querystudent {
	echo "Now query"
	echo -n "Enter student name to query GPA : "
	read NAME
	
	LINE=$(grep "^${NAME}:" datafile)
	if [ -z ${LINE} ]
	then
		echo "Error, student name ${NAME} not found"
	else
		GPA=$(echo ${LINE} | awk ' BEGIN { FS=":" } { print $2 } ')
		echo "GPA for ${NAME} is ${GPA}"
	fi
}

function insertstudent {
	echo "Inserting a new student"
	echo -n "Enter name : " 
	read NAME
	echo -n "Enter GPA : "
	read GPA
	
	checkFloatPoint ${GPA}
	if [ ${?} -ne 0 ]
	then
		echo "Entered GPA is not a positive floating point number"
	else
		echo "${NAME}:${GPA}" >> datafile
		echo "A Student has been added successfully"
	fi
}

function deletestudent {
	echo "Deleting an existing student"
	echo -n "Enter student to delete : "
	read NAME
	
        LINE=$(grep "^${NAME}:" datafile)
        if [ -z ${LINE} ]
        then
                echo "Error, student name ${NAME} not found"
        else
		
		echo " Are You Sure that you want to Delete ${NAME} ?(Y/N)"
		read CONFIRM
		if [ "${CONFIRM}" == "Y" ] || [ "${CONFIRM}" == "y" ]
		then
			
			grep -v "^${NAME}:" datafile > /tmp/datafile
			cp /tmp/datafile datafile
			rm /tmp/datafile
			echo "Student ${NAME} has been Deleted Successfully"
		else
			
			echo "Delete Process Canceled Successfully"
		fi
        fi
}

function updatestudent {
	echo "Updating an existing student"
	echo -n "Enter student Name : "
	read NAME
	
        LINE=$(grep "^${NAME}:" datafile)
        if [ -z ${LINE} ]
        then
                echo "Error, student name ${NAME} not found"
        else
        	echo -n "Enter GPA : "
		read GPA
		### Before adding, we want to check GPA valid floating point or no
		checkFloatPoint ${GPA}
		if [ ${?} -ne 0 ]
		then
			echo "Entered GPA is not a positive floating point number"
			exit 4
		else
			
			echo " Are You Sure that you want to Update ${NAME} GPA ?(Y/N)"
			read CONFIRM
			if [ "${CONFIRM}" == "Y" ] || [ "${CONFIRM}" == "y" ]
			then
				
				LINE=$(grep -n "^${NAME}:" "datafile" | cut -d ':' -f1)
				UPDATE="${NAME}:${GPA}"
				sed -i "${LINE}s/.*/${UPDATE}/" "datafile"
				echo "A Student has been updated successfully"
			else
				
				echo "Update Process cancelled successfully"
			fi
			
		fi
        
        fi
}