# Bash Scripting

## Getting Started
- Install Virtual Box first [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
- Install Vagrant second [Vagrant](https://www.vagrantup.com/downloads.html)
- Once you have installed Vagrant and Virtual box, dive into the localusers folder
- Type vagrant up
- And Bash away

## Tips
- Use shell builtins as it makes your scripts more portable.
- If you find your code WET take out the umbrella and let your code DRY.

## Shell Script Requirements: Exercise 1

You think about what the shell script must do and how you would like it operate. You come up with
the following list.
The script:
- Is named # "add-local-user.sh".
- Enforces that it be executed with superuser (root) privileges. If the script is not executed with
superuser privileges it will not attempt to create a user and returns an exit status of 1.
- Prompts the person who executed the script to enter the username (login), the name for
person who will be using the account, and the initial password for the account.
- Creates a new user on the local system with the input provided by the user.
- Informs the user if the account was not able to be created for some reason. If the account is
not created, the script is to return an exit status of 1.
- Displays the username, password, and host where the account was created. This way the
help desk staff can copy the output of the script in order to easily deliver the information to
the new account holder.
- After coming up with your list, you realize that you're not sure where to get the hostname
information. You decide to wait until you start writing your shell script to check the bash man page
to see if there are any builtin commands or variables that could provide this information.
You decide to develop your script on a Linux virtual machine running on your local operating system.
This way you can test the script's functionality before uploading it to the server where it will be used
by the help desk staff.

## Shell Script Requirements: Exercise 2
You have your requirements from the "add-local-user.sh" script you created. You decide to use
those as the basis for your new requirements. You come up with the following list.
The script:
- Is named "add-new-local-user.sh". (You add the word new to distinguish it from the
original script.)
- Enforces that it be executed with superuser (root) privileges. If the script is not executed with
superuser privileges it will not attempt to create a user and returns an exit status of 1.
- Provides a usage statement much like you would find in a man page if the user does not
supply an account name on the command line and returns an exit status of 1.
- Uses the first argument provided on the command line as the username for the account. Any
remaining arguments on the command line will be treated as the comment for the account.
- Automatically generates a password for the new account.
- Informs the user if the account was not able to be created for some reason. If the account is
not created, the script is to return an exit status of 1.
- Displays the username, password, and host where the account was created. This way the
help desk staff can copy the output of the script in order to easily deliver the information to
the new account holder


## Shell Script Requirements: Exercise 3
You have your requirements from the "add-new-local-user.sh" script you created. You decide
to use those as the basis for your new requirements. You come up with the following list.
The script:
- Is named "add-newer-local-user.sh". (You change the name slightly to distinguish it
from the previous script. NOTE: In the real world you could have easily kept the same script
name. I just want to use a different name for the purpose of discussing specific scripts in the
class.)
- Enforces that it be executed with superuser (root) privileges. If the script is not executed with
superuser privileges it will not attempt to create a user and returns an exit status of 1. All
messages associated with this event will be displayed on standard error.
- Provides a usage statement much like you would find in a man page if the user does not
supply an account name on the command line and returns an exit status of 1. All messages
associated with this event will be displayed on standard error.
- Uses the first argument provided on the command line as the username for the account. Any
remaining arguments on the command line will be treated as the comment for the account.
- Automatically generates a password for the new account.
- Informs the user if the account was not able to be created for some reason. If the account is
not created, the script is to return an exit status of 1. All messages associated with this event
will be displayed on standard error.
- Displays the username, password, and host where the account was created. This way the
help desk staff can copy the output of the script in order to easily deliver the information to
the new account holder.
- Suppress the output from all other commands.

## Shell Script Requirements: Exercise 4
You think about what the shell script must do and how you would like it operate. You come up with
the following list.
The script:
- Is named "disable-local-user.sh".
- Enforces that it be executed with superuser (root) privileges. If the script is not executed with
superuser privileges it will not attempt to create a user and returns an exit status of 1. All
messages associated with this event will be displayed on standard error.
- Provides a usage statement much like you would find in a man page if the user does not
supply an account name on the command line and returns an exit status of 1. All messages
associated with this event will be displayed on standard error.
- Disables (expires/locks) accounts by default.
- Allows the user to specify the following options:
○ -d Deletes accounts instead of disabling them.
○ -r Removes the home directory associated with the account(s).
○ -a Creates an archive of the home directory associated with the accounts(s) and stores
the archive in the /archives directory. (NOTE: /archives is not a directory that exists by
default on a Linux system. The script will need to create this directory if it does not
exist.)
○ Any other option will cause the script to display a usage statement and exit with an exit
status of 1.
- Accepts a list of usernames as arguments. At least one username is required or the script will
display a usage statement much like you would find in a man page and return an exit status of
- All messages associated with this event will be displayed on standard error.
- Refuses to disable or delete any accounts that have a UID less than 1,000.
○ Only system accounts should be modified by system administrators. Only allow the
help desk team to change user accounts.
- Informs the user if the account was not able to be disabled, deleted, or archived for some
reason.
- Displays the username and any actions performed against the account.
