# bzc
**bzc** is a depressingly effective MD5 password hash cracker with almost zero CPU/GPU load. Instead of rainbow tables, dictionaries, or brute force, **bzc** simply *finds* the plaintext password. Specifically, it googles the MD5 hash and hopes the plaintext appears somewhere on the first page of results.

It is a clone of the <a href="https://github.com/juuso/BozoCrack">BozoCrack</a> hash cracker, but even more minimalistic, which justifies the shorter name: **bzc**.

## How?
### Principle
The tasks executed by **bzc** are the following:
1. Use the <a href="http://pypi.python.org/pypi/requests/0.5.1">requests</a> Python module to get contents of a Google Search page (searching for the hash)
2. Split the output into a list. Each word has one entry into the list.
3. Iterate into the list: Get the MD5 hex digest for each word and compare the hash output with the desired comparison hash.
4. If the MD5 hash of an element of the list matches the one specified on the command-line argument, the program prints the word and exits.

### Basic usage
`$ bzc <hash / file>`

As the first (and only) command-line argument you should specify a MD5 hash or a file which contains one hash in each line. **bzc** will look up the single hash, or the multiple ones.

### Example with output
	$ bzc fcf1eed8596699624167416a1e7e122e
	fcf1eed8596699624167416a1e7e122e: octopus

## Why?
To show just how bad an idea it is to use plain MD5 as a password hashing mechanism. Honestly, if the passwords can be cracked with *this software*, there are no excuses.

## Installation
To automatically install everything you need to run **bzc**, run:<br>
`$ curl https://raw.github.com/theiostream/bzc/master/inst.sh | sh`

To get a read-only version of the source, just run:<br>
`$ [sudo] easy_install requests`<br>
`$ git clone git://github.com/theiostream/bzc.git`

## Fix-Me
* Make faster: make the array of words only contain important data to interate over.
* This code is pretty much lame, so please inform me of any nicer ways to do what I'm doing (without making the code size grow epically much :p)

## License
WTFPL -- *Do **what the fuck** you want to*.