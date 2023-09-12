[TOC]

* web apis：使用js去操作html和浏览器
	* dom：文档对象模型
	* bom：浏览器对象模型

### DOM

* document：网页所有内容都在document中，一个最大的对象
* dom：文档对象模型，用来呈现以及与任意html或xml文档交互的api，**操作网页内容**
* 作用
	* 开发网页内容特效和实现用户交互
	* 核心思想：把网页内容当做对象来处理
* dom树：html以树状结构直观的表现出来，体现标签与标签之间的关系
* dom对象：浏览器根据html标签生成的js对象(object) 
	* 所有的标签属性都在这个对象中
	* 修改这个对象的属性值会自动映射到标签上

#### 获取DOM对象

1. **根据CSS选择器来获取DOM元素**

	```javascript
	//参数为一个或多个有效的css选择器字符串
	//获取匹配的**第一个**元素
	document.querySelector("css_selector")
	//获取匹配的所有的元素：NodeList伪数组没有pop，push等方法
	document.querySelectorAll("css_selector");
	```

2. 其他

	```javascript
	document.getElementById("id")
	...
	document.getElementsBy...
	```

#### 操作元素内容

* `d_name.innerText`：文字内容，不解析标签
* `d_name.innerHTML`：文本内容，会解析标签，多标签建议使用模版字符

#### 操作元素属性

* 常用属性
	* href
	* title
	* src
* 样式属性：操作css
	* style
	* className
	* classList



