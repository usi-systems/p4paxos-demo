# Setup a Virtual Machine
You must install [vagrant](https://www.vagrantup.com) before running the following commands:

```
cd p4paxos-demo
vagrant up
```

##Connect to the VM
From the p4paxos-demo directory, type:

```
vagrant ssh
```


# Demo

After connecting to the VM, change to the **p4paxos/bmv2** directory, and start the demo:

```
cd p4paxos/bmv2
sudo ./run_demo.sh
```

From the mininet prompt, type the following command to open a terminal on host **h4**:

```
mininet> xterm h4
```

# Testing
In the h4 terminal, execute [`scripts/test.sh`](p4paxos/bmv2/scripts/test.sh)
```bash
#!/bin/bash
curl -X POST http://10.0.0.1:8080/put -d key="ciao" -d value="hello"
curl -X GET  http://10.0.0.1:8080/get?key="ciao"
curl -X GET  http://10.0.0.1:8080/get?key=nonexist
```

You should see the following output:
```
Success
hello
None
```

*Success* means that the request to put (*ciao*, *hello*) pair in the KeyValue store has been succeeded. Similarly, *hello* is the value returned by the request to get the value of the key *ciao*. And *None* is the result of the request that gets a nonexistent key.


Or, start Firefox web browser in h4 terminal
```
firefox &
```

In the firefox browser, visit 10.0.0.1:8080, then you can try to Get or Put a (key, value) pair.

# Simulating Failures

In this demo, there are two replicas (learners) running on h2 and h3.
The service is still alive if a minority of the switches or replicas crash.

We can simulate the link failure by running the *link* command in Mininet:
```
mininet> link h2 s2 down
```

Or, simulate a server failure by stopping the server process:
```
mininet> h3 kill %python
```

If you perform another test similar to the one in section Testing, you should observe the same output, because node h2 still receives a majority of accepted requests from s3 and s4 switches. If the link from h2 to s3 is also down. Then the service is disrupted because the node h2 can't decide which request is selected for the current instance.

In mininet, type:
```
mininet> link h2 s3 down
```
and in h4's terminal, type:
```
curl -X GET  http://10.0.0.1:8080/get?key="ciao"
```
The request should be blocked.

## Configuration

In the *bmv2/scripts/paxos.cfg* configuration file:

```
[instance]
count=65536

[timeout]
second=0
```

* The *count* variable in the *instance* section configures the maximum 
number of requests that learners will handle.

* The *second* variable in the *timeout* section configures the number of seconds
to run the learners. If timeout is set to 0, the learners do not terminate.