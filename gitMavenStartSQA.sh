#!/bin/bash

##This shell script is created for students of SQA school to speed up their process of creating simple maven projects for practice.
##The script is still in beta.
## !!! Make sure you can access your GitHub account through Terminal without username and password !!!
##Run it from your root projects directory

##Steps:
#1. cd to your root projects directory
#1.1. make sure you can execute the script before running it. Run "chmod +x gitMavenStartSQA.sh" from where gitMavenStartSQA.sh is located, e.g. ~/Desktop
#2. run .sh script {Path to the script}/gitMavenStart.sh {name of the project} {your first name} {your last name} {your initials} {Git Hub *.git path}
#2.1. ex. /Users/mac/Dropbox/shell/gitMavenStartSQA.sh my-project Ben Benson bb https://github.com/benbenson/repo.git
#3. This script will create simple maven structure, add README.MD and pox.xml files according to SQA requirements and change initials on pom.xml.
#It will initialize your local Git repo, add the files, commit them and push to your default. i.e. GitHUb.

#TL DR
#Your name is Ben Benson, you have this script and it is located on your Desktop. Run "chmod +x gitMavenStartSQA.sh" just ones to get the rights to execute.
#You want to create a Maven project named "just-a-project" quickly on your local from scratch, initialize it, 
#  add all the files to the staging area and commit them and push everything to GitHub
#You already have or just created a new GitHub repo, e.g. "https://github.com/benbenson/repo.git"
#You go to your projects directory, e.g. ~/Dropbox/Projects

#Run sh script like this: /Users/mac/Dropbox/gitMavenStartSQA.sh just-a-project Ben Benson bb https://github.com/benbenson/repo.git
#That's it.

function usage {
cat <<'USAGE'
Maven GIT Script for SQA
====================

Usage:
	./gitMavenStart.sh <name> <first name> <last name> <your initials for pom.xml> <GitHub repo *.git address>
	
	name = name of your project, without spaces
	first name = to add your first name to README.MD
	last name = to add your last name to README.MD
	your initials for pom.xml = will add your initials to <groupId>com.sqa.${INITIALS}</groupId>
	GitHub repo *.git address = will use provided GitHub path to push everything to default
	

USAGE
}

if [ $# -eq 0 ]; then
	usage
	exit 1
fi

PROJECT=$1
FIRST_NAME=$2
LAST_NAME=$3
INITIALS=$4
GIT_HUB=$5

git --version
IS_GIT=($? -eq 0)

if [ $IS_GIT ]; then
	echo "Creating new Git repository"
	git init "${PROJECT}"
else
	echo "Git was not initialized, proceeding without it."
fi

echo "Creating new Maven project ${PROJECT}"
mkdir -p "${PROJECT}/src/main/java"
mkdir -p "${PROJECT}/src/test/java"
mkdir -p "${PROJECT}/src/main/resources"
mkdir -p "${PROJECT}/src/test/resources"

if [ $IS_GIT ]; then
	touch "${PROJECT}/src/main/resources/.gitkeep"
	touch "${PROJECT}/src/test/resources/.gitkeep"
	touch "${PROJECT}/src/main/java/.gitkeep"
	touch "${PROJECT}/src/test/java/.gitkeep"
	touch "${PROJECT}/README.MD"
fi

(
cat <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
		http://maven.apache.org/maven-v4_0_0.xsd">

  <modelVersion>4.0.0</modelVersion>

  <groupId>com.sqa.${INITIALS}</groupId>
  <artifactId>${PROJECT}</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  
  <name>Replace for ${PROJECT}</name>
  <description>First Java Project</description>
   <dependencies>
  <dependency>
   <groupId>junit</groupId>
   <artifactId>junit</artifactId>
   <version>4.12</version>
   <scope>test</scope>
  </dependency>
 </dependencies>
 <build>
  <plugins>
   <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.3</version>
    <configuration>
     <source>1.7</source>
     <target>1.7</target>
    </configuration>
   </plugin>
  </plugins>
 </build>
</project>
EOF
) > "${PROJECT}/pom.xml"

(
cat <<EOF
## ${PROJECT}

## Created on $(date +"%x %r %Z")

- Java
- Git
- Maven

[${FIRST_NAME} ${LAST_NAME}](mailto:email)
EOF
) > "${PROJECT}/README.MD"

(
cat <<EOF
# Created by https://www.gitignore.io/api/java,eclipse,intellij,maven,osx,xcode,sublimetext

### Java ###
*.class

# Mobile Tools for Java (J2ME)
.mtj.tmp/

# Package Files #
*.jar
*.war
*.ear

# virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
hs_err_pid*


### Eclipse ###

.metadata
bin/
tmp/
*.tmp
*.bak
*.swp
*~.nib
local.properties
.settings/
.loadpath
.recommenders

# Eclipse Core
.project

# External tool builders
.externalToolBuilders/

# Locally stored "Eclipse launch configurations"
*.launch

# PyDev specific (Python IDE for Eclipse)
*.pydevproject

# CDT-specific (C/C++ Development Tooling)
.cproject

# JDT-specific (Eclipse Java Development Tools)
.classpath

# Java annotation processor (APT)
.factorypath

# PDT-specific (PHP Development Tools)
.buildpath

# sbteclipse plugin
.target

# Tern plugin
.tern-project

# TeXlipse plugin
.texlipse

# STS (Spring Tool Suite)
.springBeans

# Code Recommenders
.recommenders/


### Intellij ###
# Covers JetBrains IDEs: IntelliJ, RubyMine, PhpStorm, AppCode, PyCharm, CLion, Android Studio and Webstorm
# Reference: https://intellij-support.jetbrains.com/hc/en-us/articles/206544839

# User-specific stuff:
.idea/workspace.xml
.idea/tasks.xml
.idea/dictionaries
.idea/vcs.xml
.idea/jsLibraryMappings.xml

# Sensitive or high-churn files:
.idea/dataSources.ids
.idea/dataSources.xml
.idea/dataSources.local.xml
.idea/sqlDataSources.xml
.idea/dynamic.xml
.idea/uiDesigner.xml

# Gradle:
.idea/gradle.xml
.idea/libraries

# Mongo Explorer plugin:
.idea/mongoSettings.xml

## File-based project format:
*.iws

## Plugin-specific files:

# IntelliJ
/out/

# mpeltonen/sbt-idea plugin
.idea_modules/

# JIRA plugin
atlassian-ide-plugin.xml

# Crashlytics plugin (for Android Studio and IntelliJ)
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

### Intellij Patch ###
*.iml


### Maven ###
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties


### OSX ###
.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon


# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk


### Xcode ###
# Xcode
#
# gitignore contributors: remember to update Global/Xcode.gitignore, Objective-C.gitignore & Swift.gitignore

## Build generated
build/
DerivedData/

## Various settings
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata/

## Other
*.moved-aside
*.xccheckout
*.xcscmblueprint


### SublimeText ###
# cache files for sublime text
*.tmlanguage.cache
*.tmPreferences.cache
*.stTheme.cache

# workspace files are user-specific
*.sublime-workspace

# project files should be checked into the repository, unless a significant
# proportion of contributors will probably not be using SublimeText
# *.sublime-project

# sftp configuration file
sftp-config.json

EOF
) > "${PROJECT}/.gitignore"

if [ $IS_GIT ]; then
	echo "Adding files to Git and committing"
	cd "${PROJECT}"
	git add -A
	git commit -m "Initial commit for ${PROJECT}"
	git remote add origin "${GIT_HUB}"
	git push -u origin master
	cd ..
fi
