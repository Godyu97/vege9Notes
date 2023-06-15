* 开发机
* go install github.com/swaggo/swag/cmd/swag@latest   安装swag  swag -v
* 项目内
* go get -u -v github.com/swaggo/gin-swagger 
* go get -u -v github.com/swaggo/files 
* go get -u -v github.com/alecthomas/template
* import _ ".../docs"
* swag fmt //格式化注释
* swag init // 生成docs







```
// @Summary		SmsWebApi
//
// @Description	发送短信
// @Accept			application/json
// @Produce		application/json
// @Param			req	body		SmsWebApiReq			true	"req for email"
// @Success		200	{object}	ApiResp{data=string}	"Success"
// @Failure		500	{object}	ApiResp{data=string}	"服务器内部错误"
// @Router			/v1/api/SmsWebApi [post]
```
