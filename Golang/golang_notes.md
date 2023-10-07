* struct深浅拷贝问题：出现于结构体字段有引用类型时，出现变量意外被修改的状况 [Go 结构体深浅拷贝](https://www.ssgeek.com/post/golang-jie-gou-ti-lei-xing-de-shen-qian-kao-bei/#3-%E7%BB%93%E6%9E%84%E4%BD%93%E7%9A%84%E6%B7%B1%E6%8B%B7%E8%B4%9D)
	* 有引用类型字段的结构体，并且有写操作场景，尽量使用指针

* 交叉编译：[跨平台静态编译](https://imwnk.cn/archives/cgo-compile/)
  * `CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-s -w --extldflags "-static -fpic"' -o ./build/`
* json 序列化高精度float64 和 int64大数时，存在精度损失问题
  * js中的json decode过程，解析结果是number 会被当成float64，超过16位精度损失
  * golang 中unmarshal目标的类型为any时(包括map、struct中的值类型)，会被自动当成float64解析，精度损失；确定类型int64则不会出现该问题
  * float64高精度marshal过程，存在精度损失
* select：没有default会阻塞等待case通道信号，有default不会阻塞通道信号，直接走default
* chan
  * 无缓冲区的chan：发送值会阻塞
  * 有缓冲区的chan：如缓冲为1，发送值不会阻塞
  * 慎用close关闭chan，关闭的chan再发送值会panic
  * chan循环取值：会阻塞直到close(ch)
  	* for range：close(ch)后结束阻塞
  	* for {}：根据ok判断是否break
* goroutine中的业务函数，谨慎使用外部作用域的变量，尽量使用chan通信
* 超时控制：超时后无法强制kill goroutine，业务协程会继续执行
  * time.After、time.NewTimer、context等配合select方案
  * 注意通过通信来共享内存：使用chan 来传输数据，不要直接操作外部作用域的变量