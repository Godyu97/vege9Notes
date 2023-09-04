* struct深浅拷贝问题：出现于结构体字段有引用类型时，出现变量意外被修改的状况 [Go 结构体深浅拷贝](https://www.ssgeek.com/post/golang-jie-gou-ti-lei-xing-de-shen-qian-kao-bei/#3-%E7%BB%93%E6%9E%84%E4%BD%93%E7%9A%84%E6%B7%B1%E6%8B%B7%E8%B4%9D)

* 交叉编译：[跨平台静态编译](https://imwnk.cn/archives/cgo-compile/)
	* `CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-s -w --extldflags "-static -fpic"' -o ./build/`