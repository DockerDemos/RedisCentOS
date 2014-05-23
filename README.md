RedisCentOS
===========

Docker container for a basic CentOS-based Redis server

* [Redis](http://redis.io)

Maintainer: Chris Collins \<collins.christopher@gmail.com\>

Updated: 2014-05-23

##Building and Running##

This is a [Docker](http://docker.io) container image.  You need to have Docker installed to build and run the container.

To build the image, change directories into the root of this repository, and run:

`docker build -t redis .`  <-- note the period on the end

Once it finishes building, you can run the container with:

`docker run -d redis`

And there you have it!  A container running a Redis server.  As it is, though, the Redis port is not exposed, so it's not connectable by any outside hosts.  There are two options for working with it:

* Restart the Redis container with the port exposed, so it's accessable to regular hosts
* Start another Docker container and link it to the Redis server, allowing them to communicate securely

###Restart the Redis container with the Redis port exposed###

Stop the running Redis container:

`docker stop <container name>`

Start a new container with the port open:

`docker run -d -p 6379:6379 redis`

This will start a new container, and map port 6379 on the container to port 6379 on the host.

###Start another Docker container and link it to the Redis server###

First find or make a new Docker image for this server.  If you just want a quick server to test, you can use [DockerDemos CloudBase](http://github.com/DockerDemos/CloudBase) SSH server.  Once the image is ready to run, start it in it's usual manner, but add the following to the options at `docker run`:

` --link <redis container name>:db` 

Access your new container in your preferred manner, and install Redis to give you access to the `redis-cli` binary.

Your new container will have several environmental variables passed to it with the prefix `db`, thanks to the link you created when you started the new container.  (Note: Some shells, like bash, will toss out these variables when it's started, so if you connected to your container with a bash shell, you won't see them.)  One of these variables will be `DB_PORT_6379_TCP_ADDR=<ip.ofyour.redis.server>`.  You can use this variable to connect to your Redis database.

`redis-cli -h $DB_PORT_6379_TCP_ADDR`

This will present you with the Redis prompt, and allow you to set and get data from the database.
 `redis 172.17.0.2:6379> set docker awesome
OK
$ redis 172.17.0.2.6379> get docker
"awesome"
$ redis 172.17.0.33:6379> exit`

(Example shamelessly stolen from Docker.io's Redis Service page.)


##Known Issues##

Tracked on Github: [https://github.com/DockerDemos/RedisCentOS/issues](https://github.com/DockerDemos/RedisCentOS/issues)

##Acknowledgements##

Thanks to:

* Docker.io, upon who's [Redis Service](http://docs.docker.io/examples/running_redis_service/) container example (Ubuntu) this one is based.  Also, their example for connecting to the Redis server.

##Copyright Information##

Copyright (C) 2014 Chris Collins

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
