#yum install wget
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
    echo "Internet connection available.\n"

    dpkg-query -W --showformat '${Status}\n' dpkg > /dev/null
    if [ $? -eq 0 ]; then
        dpkg-query -W --showformat '${Status}\n' auditbeat > /dev/null
        if [ $? -ne 0 ]; then
	    rm auditbeat-*.deb
            echo "Downloading deb packages...\n"
            wget -q https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-6.6.2-amd64.deb
            echo "Installing auditbeat packages...\n"
            dpkg -i auditbeat-6.6.2-amd64.deb  > /dev/null
	    echo "Removing existing beat's configuration...\n"
            rm /etc/auditbeat/auditbeat.yml
            echo "Adding new beat's configuration...\n"
            cp auditbeat.yml /etc/auditbeat/auditbeat.yml
	else
	    echo "Auditbeat already exists.\n"
        fi

        dpkg-query -W --showformat '${Status}\n' filebeat > /dev/null
        if [ $? -ne 0 ]; then
	    rm filebeat-*.deb
            echo "Downloading deb packages...\n"
            wget -q https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.2-amd64.deb
            echo "Installing filebeat packages...\n"
            dpkg -i filebeat-6.6.2-amd64.deb  > /dev/null
	    echo "Removing existing beat's configuration...\n"
            rm /etc/filebeat/filebeat.yml
            echo "Adding new beat's configuration...\n"
            cp filebeat.yml /etc/filebeat/filebeat.yml
	else
	    echo "Filebeat already exists.\n"
        fi

    fi

    rpm -q rpm > /dev/null
    if [ $? -eq 0 ]; then
        rpm -q filebeat > /dev/null
        if [ $? -ne 0 ]; then
	    rm filebeat-*.rpm
            echo "Downloading rpm packages...\n"
            wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.2-x86_64.rpm
            echo "Installing filebeat packages...\n"
            rpm -vi filebeat-6.6.2-x86_64.rpm
	    echo "Removing existing beat's configuration...\n"
            rm /etc/filebeat/filebeat.yml
	    echo "Adding new beat's configuration...\n"
            cp filebeat.yml /etc/filebeat/filebeat.yml
	else
            echo "Filebeat already exists.\n"
        fi
        rpm -q auditbeat > /dev/null
        if [ $? -ne 0 ]; then
    	    rm auditbeat-*.rpm
            echo "Downloading rpm packages...\n"
            wget https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-6.6.2-x86_64.rpm
            echo "Installing auditbeat packages...\n"
            rpm -vi auditbeat-6.6.2-x86_64.rpm
	    echo "Removing existing beat's configuration...\n"
            rm /etc/auditbeat/auditbeat.yml
            echo "Adding new beat's configuration...\n"
            cp auditbeat.yml /etc/auditbeat/auditbeat.yml

	else
            echo "Auditbeat already exists.\n"
        fi
    fi
    echo "Removing existing beat's configuration...\n"
    rm /etc/filebeat/filebeat.yml
    rm /etc/auditbeat/auditbeat.yml
    echo "Adding new beat's configuration...\n"
    cp filebeat.yml /etc/filebeat/filebeat.yml
    cp auditbeat.yml /etc/auditbeat/auditbeat.yml
else
    echo "No internet connection.\n"
fi


