# Python script to run a command line
import subprocess

def execute(cmd):
    """
        Purpose  : To execute a command and return exit status
        Argument : cmd - command to execute
        Return   : exit_code
    """
    process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (result, error) = process.communicate()

    rc = process.wait()

    if rc != 0:
        print "Error: failed to execute command:", cmd
        print error
    return result
# def

dropdatabase = "echo 'DROP DATABASE IF EXIST ut_pos | mysql -u root -pg3mb0k"
command1 = "echo 'create database ut_pos' | mysql -u root -pg3mb0k";
command2 = "mysql -u root -pg3mb0k ut_pos < db_pos_client.sql";
sample = "mysql -u root -pg3mb0k ut_pos < sample_data.sql";
print "Drop database... \n", execute(dropdatabase)
print "This process create database... \n", execute(command1)
print "This process migration tables... \n", execute(command2)
print "Create sample data... \n", execute(sample)
