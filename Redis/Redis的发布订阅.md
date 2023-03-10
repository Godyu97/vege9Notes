1. Redis发布订阅(pub/sub)是一种消息通道模式：发送者(pub)发送消息，订阅者(sub)接受消息；Redis客户端可以订阅任意数量的频道
2. `subscribe c1`订阅频道   `publish c1 message`发布消息