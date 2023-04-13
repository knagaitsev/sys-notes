Start out by installing Parsec:
```
https://parsec.cs.princeton.edu/download.htm#installation
```

Once you have entered the root parsec directory, edit the file `config/gcc.bldconf`. Find the `CXXFLAGS` line and add `-std=c++11`

Make sure to clean:
```
parsecmgmt -a fullclean -p all
```
And then build either one thing or everything:
```
parsecmgmt -a build -p blackscholes -c gcc-pthreads
parsecmgmt -a build -c gcc
```
