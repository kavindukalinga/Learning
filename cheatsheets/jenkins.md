# </ Jenkins >


## Structures

### Scripted

```groovy
@Library("sharedlib") _
pipeline{
	agent any
	stages{
		stage("build"){
			steps{

			}
		}
	}
}
```


### Declarative

```groovy
node{
	// groovy script
}

```

## Attributes

### post 

Execute some logic After all stages executed
1. always
2. success
3. failure

```groovy
pipeline{
	agent any
	stages{
		stage("build"){
			steps{
				//
			}
		}
	}
	post{
		always{
			//
		}
	}
}

```

### Define conditionals / When expression


```groovy
pipeline{
	agent any
	stages{
		stage("build"){
			when{
				expression{
					BRANCH_NAME == 'dev' || BRANCH_NAME == 'master'
				}
			}
			steps{
				//
			}
		}
	}
}
```

## Environmental Variables


```groovy
pipeline{
	agent any
	environment{
		NEW_VERSION = '1.3.0'
	}
	stages{
		stage("build"){
			steps{
				echo "building version ${NEW_VERSION}"
			}
		}
	}
}
```

### Bitbucket Variables

| Variable | Description |
|----------|-------------|
| `BITBUCKET_SOURCE_BRANCH` | Source branch - only for pull requests (BB Cloud and BB Server). |
| `BITBUCKET_PULL_REQUEST_ID` | Pull request identifier (BB Cloud and BB Server). |
| `BITBUCKET_PULL_REQUEST_LINK` | Pull request link (BB Cloud and BB Server). |
| `BITBUCKET_TARGET_BRANCH` | Target branch (BB Cloud and BB Server). |
| `BITBUCKET_REPOSITORY_UUID` | Repository identifier - only for BB Cloud pushes. |
| `BITBUCKET_REPOSITORY_ID` | Repository identifier - only for BB Server pushes. |
| `BITBUCKET_REPOSITORY_URL` | Repository URL - only for BB Cloud pushes. |
| `BITBUCKET_PULL_REQUEST_COMMENT_TEXT` | Text comment of BB Cloud Pull Request. |
| `BITBUCKET_ACTOR` | Actor name (BB Cloud and BB Server). |
| `BITBUCKET_PULL_REQUEST_TITLE` | Pull request title (BB Cloud and BB Server). |
| `BITBUCKET_PULL_REQUEST_DESCRIPTION` | Pull request description (BB Cloud and BB Server). |
| `BITBUCKET_PAYLOAD` | Complete BB Payload (BB Cloud and BB Server). |
| `BITBUCKET_X_EVENT` | BB X-Event which has triggered the plugin (BB Cloud and BB Server). |

### Multibranch Project Variables

| Variable | Description |
|----------|-------------|
| `BRANCH_NAME` | Name of the branch being built. |
| `BRANCH_IS_PRIMARY` | Indicates if the branch is a primary branch. |
| `CHANGE_ID` | Change request ID (e.g., pull request number). |
| `CHANGE_URL` | Change request URL. |
| `CHANGE_TITLE` | Change request title. |
| `CHANGE_AUTHOR` | Username of the author of the change request. |
| `CHANGE_AUTHOR_DISPLAY_NAME` | Human-readable name of the change author. |
| `CHANGE_AUTHOR_EMAIL` | Email of the change author. |
| `CHANGE_TARGET` | Target branch for merging the change. |
| `CHANGE_BRANCH` | Name of the actual head on the source control system. |
| `CHANGE_FORK` | Name of the forked repo if applicable. |

### Tag Variables

| Variable | Description |
|----------|-------------|
| `TAG_NAME` | Name of the tag being built. |
| `TAG_TIMESTAMP` | Timestamp of the tag in milliseconds since Unix epoch. |
| `TAG_UNIXTIME` | Timestamp of the tag in seconds since Unix epoch. |
| `TAG_DATE` | Timestamp in Java Date format. |

### Jenkins Build Variables

| Variable | Description |
|----------|-------------|
| `BUILD_NUMBER` | Current build number. |
| `BUILD_ID` | Current build ID. |
| `BUILD_DISPLAY_NAME` | Display name of the build. |
| `JOB_NAME` | Name of the project being built. |
| `JOB_BASE_NAME` | Short name of the project without folder paths. |
| `BUILD_TAG` | String in format `jenkins-${JOB_NAME}-${BUILD_NUMBER}`. |
| `EXECUTOR_NUMBER` | Unique number identifying the current executor. |
| `NODE_NAME` | Name of the agent running the build. |
| `NODE_LABELS` | List of labels assigned to the node. |
| `WORKSPACE` | Absolute path of the build workspace. |
| `WORKSPACE_TMP` | Temporary directory near the workspace. |

### Jenkins URLs

| Variable | Description |
|----------|-------------|
| `JENKINS_HOME` | Path to Jenkins home directory. |
| `JENKINS_URL` | Full URL of Jenkins. |
| `BUILD_URL` | URL of the current build. |
| `JOB_URL` | URL of the current job. |
| `JOB_DISPLAY_URL` | Redirect URL to the job. |
| `RUN_DISPLAY_URL` | Redirect URL to the build. |
| `RUN_ARTIFACTS_DISPLAY_URL` | Redirect URL to build artifacts. |
| `RUN_CHANGES_DISPLAY_URL` | Redirect URL to build changelog. |
| `RUN_TESTS_DISPLAY_URL` | Redirect URL to build test results. |

### Git Variables

| Variable | Description |
|----------|-------------|
| `GIT_COMMIT` | Current commit hash. |
| `GIT_PREVIOUS_COMMIT` | Hash of the last built commit. |
| `GIT_PREVIOUS_SUCCESSFUL_COMMIT` | Hash of the last successfully built commit. |
| `GIT_BRANCH` | Remote branch name. |
| `GIT_LOCAL_BRANCH` | Local branch name. |
| `GIT_CHECKOUT_DIR` | Directory where the repo is checked out. |
| `GIT_URL` | Remote repository URL. |
| `GIT_COMMITTER_NAME` | Git committer name. |
| `GIT_AUTHOR_NAME` | Git author name. |
| `GIT_COMMITTER_EMAIL` | Git committer email. |
| `GIT_AUTHOR_EMAIL` | Git author email. |

### Mercurial (Hg) Variables

| Variable | Description |
|----------|-------------|
| `MERCURIAL_REVISION` | Full ID of the revision checked out. |
| `MERCURIAL_REVISION_SHORT` | Abbreviated ID of the revision. |
| `MERCURIAL_REVISION_NUMBER` | Number of the revision checked out. |
| `MERCURIAL_REVISION_BRANCH` | Branch of the revision checked out. |
| `MERCURIAL_REPOSITORY_URL` | Repository URL. |

### Subversion (SVN) Variables

| Variable | Description |
|----------|-------------|
| `SVN_REVISION` | Current Subversion revision number. |
| `SVN_URL` | Current Subversion URL checked out. |

### Miscellaneous Variables

| Variable | Description |
|----------|-------------|
| `CI` | Always set to `true` for CI environments. |
| `BUILD_X_EVENT` | Event that triggered the plugin. |


## Credentials

Need two plugins:
1. Credentials
2. Credentials Binding

```groovy
pipeline{
	agent any
	environment{
		NEW_VERSION = '1.3.0'
		SERVER_CREDENTIALS = credentials('server-credentials')
	}
	stages{
		stage("build"){
			steps{
				echo "building version ${SERVER_CREDENTIALS}"
			}
		}
		stage("deploy"){
			steps{
				echo 'deploying...'
				withCredentials([
					usernamePassword(credentials: 'server-credentials', usernameVariable: USER, passwordVariable: PWD)
				]){
					sh "some script ${USER} ${PWD}"
				}
			}
		}
	}
}
```

## Tools

gradle,maven and jdk : Available

```groovy
pipeline{
	agent any
	tools{
		maven 
		gradle
		jdk
	}
	stages{
		stage("build"){
			steps{
				sh "mvn install "
			}
		}
	}
}
```

## Parameters

string, choice, booleanParam

```groovy
pipeline{
	agent any
	parameters{
		string(name: 'VERSION', defaultValue: '', description: 'version pod')
		choice(name: 'Tag', choices: ['1','2','3'], description:'')
		booleanParam(name:'executeTests', defaultValue: true, description: '')
	}
	stages{
		stage("build"){
			when{
				expression{
					params.executeTests == true
				}
			}
			steps{
				sh "mvn install "
			}
		}
	}
}
```

## External groovy scripts

```groovy
def gv

pipeline{
	agent any
	stages{
		stage("init"){
			steps{
				script{
					gv = load "script.groovy"
				}
			}
		}
		stage("build"){
			steps{
				script{
					gv.buildApp()
				}
			}
		}
	}
}
```

script.groovy
```groovy
def buildApp(){
	echo 'Building app'
}
return this
```