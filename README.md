   <div style="text-align: center;">
   
   ![alt text](https://softwarereviews.s3.amazonaws.com/production/logos/offerings/6116/original/ParrotSecurity_logo.png?1582749483)

   </div>

ParrotWSL
===========
ParrotOS on WSL2
-------------------

**_Here's the thing..._** I went scouring the Internet to find some way to put ParrotOS on WSL2 and I found a couple of scripts, another couple of guides; but the apt sources were old, the tools were deprecated, and there were just a lot of tweaks/further debugging that needed to be done in order to get the thing right speed. Plus, you had to start with an **Ubuntu/Debian/Kali** distro _anyway_ which to me didn't seem like the right answer. 

As much as I would like to take credit for this super straight-forward simple way of installing... really any distro your little heart desires {yea you, I'm talking about your little heart buddy}, I just ganked this from the Microsoft documentation found [here](https://learn.microsoft.com/en-us/windows/wsl/use-custom-distro). So I shant toot my own horn. I don't know why it took me so damn long to read the documentation but I figured I'm not the only one, so here we are.

What's that? Shut the Fv\*k up and get on with it? Right Right Right... my bad.

Prerequisites 
-------------

1. There are a million and one guides out there on how to install WSL2.  Like [this one](https://learn.microsoft.com/en-us/windows/wsl/install), [that one](https://www.ceos3c.com/wsl-2/install-wsl2-with-windows-terminal/#:~:text=Install%20WSL2%20on%20Windows%20-%20The%20Easiest%20Way,3%20Step%203%20-%20Initial%20Ubuntu%20Setup%20), or [this other](https://youtu.be/VMZH9Pj2dXw)\(for those of you who like the motion picture formats\). So if you don't have that done, it's *kinda* necessary.
   - Next
2. You need to Head over to the [Website of Docker](https://docs.docker.com/desktop/install/windows-install/) and follow thier guide on setting up Docker Desktop with WSL2 backend. There are obvious workarounds for this which... *I suppose* may be worth getting into later but for now, if you can, do the do and install the thing.
   - Meat & Potatoes

 Get yourself a [hot-n-ready](https://littlecaesars.com/) tar'd ParrotOS
 -----------
**Now I imagine that there are a ton of ways to go about this.  ~~Heck, I even did you a solid and got one here for ya.~~  But for the sake of learnin you one, we'll go through the steps anyway.**

___

So the easiest way ~~\(besides getting yours here\)~~ to get a ParrotOS tar file of the entire image is to compress a container. I  highly encourage you to head over to the ParrotSec [website](https://parrotsec.org) to view their latest [Downloads](https://parrotsec.org/download/). Here is their official [Docker documentation](https://parrotsec.org/docs/cloud/parrot-on-docker/) where you will find 2 containers.  Again - I *highly* recommend that you go check it out.  
___
1. Open your WSL2 CLI (*bash or whatevs*) in a distro you've already got installed.

2. In WSL you are going to start Docker
```bash
sudo service docker start
```
3. Pick one of the following container templates and spin it up.
   + **_I recommend rolling up the smallest image since you will be able to update and customize once everything is installed_**

##### Core Template:
#### [Parrot.run/Core](https://parrotsec.org/docs/cloud/parrot-on-docker/#parrotruncore)
  >Core system with just the Parrot basics. You can use it as a start point to create your custom containers.
  >This image is multiarch, and works for amd64, arm64 and armhf architectures.

  **__Launch the container__**
  ```bash
  docker run -t parrotsec/core bash
  ```
##### Security Template
#### [Parrot.run/sec](https://parrotsec.org/docs/cloud/parrot-on-docker/#parrotrunsecurity)
  >This container includes a huge collection of tools that can be used via command line from inside a docker container.
  >Some tools with graphical interface were excluded for obvious reasons.
  >This container ships with the following metapackages:
  > -parrot-cloud

  **__Launch the container__**
  ```bash
  docker run -t parrotsec/security bash
  ```
  
  4. Get the image's container ID and save it as a variable 
  ```bash
  dockerContainerID=$(docker container ls -a | grep -i parrot | awk '{print $1}')
  ```
  5. Export your image to the Windows file system
  ```bash
  docker export $dockerContainerID > /mnt/c/temp/ParrotOS.tar
  ```
  All that so you can import the tar file as an image into WSL2
 ___
 
 Import ParrotOS tar file into WSL
 ---
 
  1. Open yourself a powershell instance and get to your <User> directory and make a folder to install your Distro.
  ```powershell
  cd
  mkdir WSLdistro
  ```
  
  2. move into your new directory Import your tar file into WSL2. Syntax is important here '''wsl --import <DistroName> <where distro data will live> <tar file to be imported>
  ```powershell
  cd WSLdistro
  wsl --import ParrotSec .\ "C:\temp\ParrotOS.tar"
  ```
  3. Check installed distros
  ```powershell
  wsl -l -v
  ```
  4. Launch that nizbich
  ```powershell
  wsl -d ParrotOS
  ```
  
Extras in this Repository
---
Check out the Docs folder.  There are a few things in there which help out post import.
Some dot files, and wsl config files.  If they help, cool, if not.. no sweat.
