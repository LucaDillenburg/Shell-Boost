# Shell Navigation Boost &nbsp;&nbsp; [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
Light-weight tool to improve your shell navigation experience.

Jump to: [installation](#installation) or [contributions](#contributions) (**every contribution is welcome! 😄**)
<br/>

# ```...``` Commands

### Navigation
| Command  | Explanation | Usage | Options and arguments |
| ------------- | ------------- | ------------- | ------------- |
| `back`  | Navigate backwards in the directory history | `back [OPTION]` | <html><ul><li>-n=NUMBER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;navigate NUMBER times backwards</li> <li>-h, --help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;command description</li></html> |
| `fwd`  | Navigate forward in the directory history | `fwd [OPTION]` | <html><ul><li>-n=NUMBER&nbsp;&nbsp;&nbsp;&nbsp;navigate NUMBER times forward</li> <li>-a, --all&nbsp;&nbsp;&nbsp;&nbsp;navigate forward until the last directory in the history</li><li>-h, --help&nbsp;&nbsp;&nbsp;&nbsp;command description</li></html> |
| `c` | Clear shell (alias for `clear`) | `c` | - |
| `..` | Navigate to the parent folder (alias for `cd ..`) | `..` | - |

### General Linux
| Command  | Explanation | Usage |
| ------------- | ------------- | ------------- |
| `mkcd` | Create folder and navigate to it | `mkcd DIRECTORY` |
| `untar` | Untar compressed file with tar  | `untar [FILE]...` |

### Git
| Command  | Explanation | Usage |
| ------------- | ------------- | ------------- |
| `gac` | Stage all files to git and commit with the message writen after this command | `gac [COMMIT-MESSAGE]` |
| `gst` | Display git status  | `gst` |
| `glg` | Display git log  | `glg` |
| `gpm` | Git push master  | `gpm` |

## Examples
- ```back``` and ```fwd```

  \~/Documents/projects/university/hello_world $ ```cd ~/Downloads/code-example/```
  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~/Downloads/code-example/ $ ```back``` <del>```cd ~/Documents/projects/university/hello_world```</del>
  
  \~/Documents/projects/university/hello_world $ ``` fwd ``` <del>```cd ~/Downloads/code-example/```</del>
  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~/Downloads/code-example/ $ ```...```
<br/><br/>

## Other features
- Create custom cd aliases interactively
After installation, you will be prompt to create custom cd aliases. Just copy the path of the directories that you access the most and choose a simple alias for them.

# 💻 <a name="installation"></a>Installation
- For bash (default shell) and zsh
```sh
cd $HOME
git clone https://github.com/LucaDillenburg/Shell-Navigation-Boost.git ".shell-navigation-boost"
cd .shell-navigation-boost
chmod +x install.sh
./install.sh
```
- For other shells: add this to your the correspondent ~/.bashrc file:
```sh
SH_NAV_HOME="insert/path/to/cloned/repository" # [Atention!] do not delete this variable
source $SH_NAV_HOME/bin/index.sh
```
<br/>

# ❓ FAQ
- **Will these commands be available to non-interactive shells?**

  It won't be available by default. However, but you can add ```source $SH_NAV_HOME/bin/index.sh``` to your file to do it.

- **How can I stay always with the latest stable version installed?**

  You don't have to worry about that. ShellNavigationBoost will update automatically for you whenever there is a new stable version.
<br/><br/>

# <a name="contributions"></a>Contributions are very welcome! 😄
###### You don't have to be an experienced programmer to add aliases or create functions you find useful.

#### Quick contribution guide
- After adding new aliases or functions, don't forget to update ```README``` and ```bin/resume.sh```
- [Quick Git Flow explanation](https://medium.com/@muneebsajjad/git-flow-explained-quick-and-simple-7a753313572f)
- Backward compatibility is a must
