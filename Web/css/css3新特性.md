------

[TOC]

------



### 圆角边框

* 圆角边框原理：`border-radius`的值为 **水平半径 / 垂直半径** 的圆或椭圆与矩形边框相切形成的圆角效果

  ```css
  border-radius               /*四个角的弧度*/
  border-top-left-radius      /*左上角的弧度*/
  border-top-right-radius     /*右上角的弧度*/
  border-bottom-right-radius  /*右下角的弧度*/
  border-bottom-left-radius   /*左下角的弧度*/
  ```

* 椭圆或正圆：`border-radius: 50%;`

* `border-radius: 1-4 length|% / 1-4 length|%;`顺时针

  * `/`之前的四个数值表示圆角的水平半径，后面四个值表示圆角的垂直半径。

### 盒子阴影

* `box-shadow: offset-x offset-y [blur] [spread] [color] [inset];`

  | 值       | 描述                                           |
  | :------- | :--------------------------------------------- |
  | offset-x | 阴影的水平偏移量。正数向右偏移，负数向左偏移。 |
  | offset-y | 阴影的垂直偏移量。正数向下偏移，负数向上偏移。 |
  | blur     | 可选。阴影模糊距离，不能取负数。               |
  | spread   | 可选。阴影大小                                 |
  | color    | 可选。阴影的颜色                               |
  | inset    | 可选。表示添加内阴影，默认为外阴影             |

* 默认是外阴影(outset)，但是不可以指定outset值，否则阴影无效

* 盒子阴影**不占用空间**，不影响其他盒子排列

### 文字阴影

* `text-shadow: offset-x offset-y [blur] [color]` 

  | 值       | 描述                                           |
  | :------- | :--------------------------------------------- |
  | offset-x | 阴影的水平偏移量。正数向右偏移，负数向左偏移。 |
  | offset-y | 阴影的垂直偏移量。正数向下偏移，负数向上偏移。 |
  | blur     | 可选。阴影模糊距离，不能取负数。               |
  | color    | 可选。阴影的颜色                               |



