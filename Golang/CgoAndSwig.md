* swig -c++ -cgo -go -intgosize 64 xxx.i

  ```c++
  %module vegePcre
  %{
      #include "mypcre.h"
  %}
  %include "mypcre.h"
  ```

  

* ```go
  #cgo LDFLAGS: -lpcre++
  #cgo CFLAGS: -I/usr/include
  ```

