# Shell Navigation Boost
Shell-Navigation-Boost creates commands to improve your shell navigation experience.
<br/><br/><br/>

## Key commands
- **back**: Navigate backwards in the directory history.

	$ ```back --help```
	```
	Usage: back [OPTION]
	Navigate backwards in the directory history.
		-n=NUMBER	navigate NUMBER times backwards
    	-h, --help 	display this help
	```

- **fwd**: Navigate forward in the directory history.
	
  $ ```fwd --help```
	```
	Usage: fwd [OPTION]...
	Navigate forward in the directory history.
		-n=NUMBER	navigate NUMBER times forward
		-a, --all	navigate forward until the last directory in the history
    	-h, --help 	display this help
	```

## Examples
  \~/Documents/projects/university/hello_world $ ```cd ~/Downloads/code-example/```
 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ```...```
 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~/Downloads/code-example/ $ ```back``` <del>```cd ~/Documents/projects/university/hello_world```</del>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ``` ... ```
  
  \~/Documents/projects/university/hello_world $ ``` fwd ``` <del>```cd ~/Downloads/code-example/```</del>
  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~/Downloads/code-example/ $ ```...```
<br/><br/><br/>

## Installation
#### ppa-repository ....
- For bash (default shell) and zsh
```sh
cd $HOME
git clone https://github.com/LucaDillenburg/Shell-Navigation-Boost.git ".shell-navigation-boost"
chmod +x install.sh
./install.sh
```
- For other shells: add this to your the correspondent ~/.bashrc file:
```sh
source $libraryDirectory/bin/index.sh
```

## FAQ
- **Will these commands be available to non-interactive shells (such as shell scripts, start up scripts, administrative and system maintains)?**

  It won't be available by default. However, but you can add ```source $libraryDirectory/bin/index.sh``` to your file to do it.

### Please, feel free to contribute :)