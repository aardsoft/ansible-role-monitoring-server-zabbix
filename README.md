Role Name
=========
A role to install and setup Zabbix server.

Requirements
------------
A MySQL/MariaDB database is needed.

Role Variables
--------------

    # The Admin password name in passdb
    zabbix_server_admin_passwd: zabbix_admin
    # The IP of the MySQL/MariaDB host
    zabbix_server_db_host: 127.0.0.1
    # The mariadb/mysqldb password name in passdb
    zabbix_server_db_pass: sql_mariadb_zabbix
    # A name for the Zabbix instance, e.g. the company name
    zabbix_server_instance_name: Zabbix
    # The timezone
    zabbix_server_php_timezone: Europe/Helsinki
    # under which URL will Zabbix be reachable, needed to access the API
    # from the host running Ansible
    zabbix_server_url: http://monitoring/zabbix/

    # Optional
    # a proxy server to be used by yum, gets added to the repo config file
    zabbix_server_repo_proxy: http://proxy:8080

Example Playbook
----------------

    - hosts: zabbix-server
      roles:
        - monitoring-zabbix-server
