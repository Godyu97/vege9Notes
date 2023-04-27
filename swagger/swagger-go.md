* 开发机
* go install github.com/swaggo/swag/cmd/swag@latest   安装swag  swag -v
* 项目内
* go get -u -v github.com/swaggo/gin-swagger 
* go get -u -v github.com/swaggo/files 
* go get -u -v github.com/alecthomas/template
* import _ ".../docs"







```
//  @Summary      SendEmail
// @Description   发送1条邮件
// @Accept          application/json
// @Produce      application/json
// @Param       req    body      SendEmailReq            true   "req for email"
// @Success      200    {object}   ApiResp{Body=SendEmailResp}    "Success"
// @Failure      500    {object}   ApiResp{Body=SendEmailResp}    "服务器内部错误"
// @Router          /ses/SendEmail [post]
```
