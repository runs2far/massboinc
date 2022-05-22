# massboinc

This is just a small hobby project for managing multiple boinc instances.

The script requires boinccmd is installed.

The conf file is not really a configuration,
it is a list of changes that is interpreted one line at the time
and executed when the interpretation reaches a line with the word run.

mb.conf usage.<br/>
Everything is a parameter that has to be set followed by the value.

Lines starting with &#35; are comments and will be ignored.<br/>
Example:
```
# This is just a comment
```

mode - sets the current mode, "update" is the only mode supported so far.<br/>
Example:
```
mode update
```

host - is the ip or hostname used.<br/>
Example:
```
host 127.0.0.1
```

baseport - the first port used.<br/>
Example:
```
baseport 31416
```

instances - subsequent ports to use, ports are used in sequential order.<br/>
When set to 1 the script will only contact the set base port, 
setting instances to any number above 1 will result in contacting additinal ports aka boinc instances.<br/>
Example:
```
instances 1 
# Baseport is 31416 and instances is 1, the script will contact port 31416
instances 3
# Baseport is 31416 and instances is 3, the script will contact port 31416, 31417 and 31418
instances 5
# Baseport is 31416 and instances is 5, the script will contact port 31416, 31417, 31418, 31419 and 31420
```

guirpc - the gui rpc password.<br/>
Example:
```
guirpc mybigsecret
# To clear the password add a guirpc line with no password
guirpc
```

projecturl - the current project url available from the project page.<br/>
Example:
```
projecturl somethingsomethingsomething.invalidurl
```

Usage examples:<br/>
For a machine that just wants to update the local boinc instance with no guirpc password,
the following will work after the projecturl has been opdated.
```
mode update
host 127.0.0.1
baseport 31416
instances 1
projecturl thatniceurl.invalid
run

#end of conf, empty line is required
```

A guirpc password can be added when needed.
```
mode update
host 127.0.0.1
baseport 31416
instances 1
guirpc mybigsecret
projecturl thatniceurl.invalid
run

#end of conf, empty line is required
```

The lines are interpreted as changes, so a host with two projects that have to be updated can be done in the following manner.
```
mode update
host 127.0.0.1
baseport 31416
instances 1
guirpc mybigsecret
projecturl thatniceurl.invalid
run
projecturl anotherniceurl.invalid
run

#end of conf, empty line is required
```

Or multiple machines with the same base port, gui rpc password and project but different number of instances.
```
mode update
host 127.0.0.1
baseport 31420
instances 10
guirpc mybigsecret
projecturl thatniceurl.invalid
run
host 127.0.0.2
instances 5
run

#end of conf, empty line is required
```

Or two machines that only share the base port.
```
mode update
# My home pc
host 127.0.0.1
baseport 31420
instances 10
guirpc mybigsecret
projecturl thatniceurl.invalid
run
host 127.0.0.2
instances 1
# Dad does not want a gui rpc password on his pc 
guirpc
projecturl anotherniceurl.invalid
run

#end of conf, empty line is required
```
