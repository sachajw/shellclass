# Bash Scripting

## Getting Started
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Virtual Box](https://www.virtualbox.org/wiki/Downloads)

## Shell Script Requirements:

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

## Shell Script Requirements:
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