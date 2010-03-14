
cd $TM_PROJECT_DIRECTORY
case $1 in
	start)
		mongrel_rails start -d --port=3000 --pid=log/mongrel.pid
		echo "Mongrel was started"
	;;
	
	stop)
		mongrel_rails stop --pid=log/mongrel.pid
		echo "Mongrel was stopped"
	;;
	
	restart)
		mongrel_rails restart --pid=log/mongrel.pid
		echo "Mongrel was restarted"
	;;
	
	status)
		cat log/mongrel.pid | awk '{print "Running with pid = ",$0}'
	;;
esac