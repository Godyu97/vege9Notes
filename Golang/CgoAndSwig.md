* linux安装


```bash
apt install libpcre2-dev
./configure
make
sudo make install

```

* swig -c++ -cgo -go -intgosize 64 xxx.i

  ```c++
  %module vegePcre
  %{
      #include "mypcre.h"
  %}
  %include "mypcre.h"
  ```

  

* ```go
  #cgo LDFLAGS: -lpcre++ -lpcre
  #cgo CFLAGS: -I/usr/include
  ```

