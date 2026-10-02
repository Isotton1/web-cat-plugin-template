# Web-Cat Plugin Template

## Table of Contents
* [Service Users](#service-users)
* [Files](#files)
* [Container](#container)
	- [Environment Variables](#environment-variables)
	- [Mount Points](#mount-points)
	- [Building](#building)
	- [Running](#running)
* [Examples](#examples)

## Service Users
TODO: Add purpose for instructor
| User | UID | Privilege | Purpose |
|------|-----|-----------|---------|
| instructor | 60001 | High | |
| student | 60002 | Low | Run student code and tests |

## Files
TODO: Add purposes and info about using sudo to run student code
| Files | Owner | Execution | Purpose |
|-------|-------|-----------|---------|
| Dependencies Script | root | Manual or by Dockerfile |
| Plugin Entrypoint | instructor | Manual or by Dockerfile |
| Student Code Script | student | `sudo -u student <student code script>`, by plugin entrypoint |
| Plugin Director | instructor | By plugin entrypoint |

## Container

### Environment Variables
| Environment Variable | Purpose |
|----------------------|---------|
| DEPENDENCIES\_SCRIPT | Dependencies script path |
| STUDENT\_CODE\_SCRIPT | Student code script path |
| PLUGIN\_ENTRYPOINT | Plugin entrypoint path |
| PLUGIN\_DIR | Student code directory path |

### Mount Points
| Mount Point | Owner | Purpose |
|-------------|-------|---------|
| /plugin/instructor\_input/ | instructor | Directory for instructor input (properties file, test files, etc.)|
| /plugin/student\_input/ | student | Directory for instructor input (code, test files, etc.) |
| /plugin/results/ | instructor | Directory for plugin results output |

### Building
``` bash
docker build \
	-t <plugin_name> \
	--build-arg DEPENDENCIES_SCRIPT=<dependencies_script> \
	--build-arg STUDENT_CODE_SCRIPT=<student_code_script> \
	--build-arg PLUGIN_ENTRYPOINT=<plugin_entrypoint> \
	--build-arg PLUGIN_DIR=<plugin_dir> \
	<base_dir> 

# Example
# docker build \
#	-t example-plugin \
#	--build-arg DEPENDENCIES_SCRIPT=dependencies.sh \
#	--build-arg STUDENT_CODE_SCRIPT=student_code.sh \
#	--build-arg PLUGIN_ENTRYPOINT=plugin.sh \
#	--build-arg PLUGIN_DIR=./plugin \
#	.
```

### Running
``` bash
docker run \
	--name <instance_name> \
	--v <instructor_input_dir>:/plugin/instructor_input \
	--v <student_input_dir>:/plugin/student_input \
	--v <results_dir>:/plugin/results \
	<plugin_image>

# Example
# docker run \
#	--name example-plugin-1234 \
#	--v /assignments/X/input/:/plugin/instructor_input \
#	--v /submissions/studentY/X/0/:/plugin/student_input \
#	--v /results/studentY/X/0/:/plugin/results \
#	ghcr.io/web-cat/example-plugin:latest
```

## Examples
TODO: Insert links to plugin repos that use this template
