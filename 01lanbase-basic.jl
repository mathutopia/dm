### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 67019338-dca4-4fe1-8a7c-55cf5b929486
using PlutoUI

# ╔═╡ 466451e1-bc3f-401e-a2fc-7b39a77732a6
using Plots

# ╔═╡ 91f95dc2-c9b1-4664-bf93-459c55887519
begin
x = 10
sin(x)
end;

# ╔═╡ 7e8f6056-fccd-4a44-83bc-bf452ebaac17
md"""
我要测试一下code  julia !
"""

# ╔═╡ 8ca0be6d-1b94-40eb-af87-d04756cb2509
PlutoUI.TableOfContents(title = "目录", indent = true, depth = 4, aside = true)

# ╔═╡ f0e96543-bbd5-4095-89e4-e11f510c2d12
md"""
该教程粗略的摘录了 Julia 的基本语法，不熟悉 Julia 的同学可以先粗略地通读该教程，以大致熟悉基本操作。

如果想要了解详细内容可以查阅[官方文档](https://docs.julialang.org/en/v1/)，Julia 中文社区提供了中文版本的[文档](https://docs.juliacn.com/latest/)。 [B 站](https://www.bilibili.com/video/BV1Cb411W7Sr?p=1)有一个简单的视频教程。 这个教程的有部分代码来自该视频作者。 

如果想比较全面的学一下Julia, 可以看看Github上面的这种本[Julia编程基础](https://github.com/hyper0x/JuliaBasics/tree/master/book)
"""

# ╔═╡ 284d7a22-69b2-4bbb-95c0-c6c7ec32a57f
md"""
**程序 = 数据结构+算法**， 要学会编程， 你需要知道一些基本的数据结构（类型）以及如果去操作这些数据（算法）。 数据结构可以理解为数据的组织方式。
"""

# ╔═╡ 167ee46b-e00f-406a-aa9e-b0d932641611
md"""
# 变量
在Julia中，变量是与值关联(或绑定)的名称。当您想要存储一个值时，它很有用(例如，你经过一些数学运算后得到的)以备以后使用。 通常， 我们会用**赋值操作符（=）**实现将一个值和对应的变量名关联起来 （也就是赋值的时候，实现变量的定义）。如`x=3`， 表示把数字3跟变量x绑定起来。 赋值操作符在很多语言中都是类似的。


例如:
```julia
	# 把数值10分配给变量x， 或者说， 变量x绑定数值10
	julia> x = 10
	10
	# 用变量x绑定的数字做运算
	julia> x + 1
	11
	# 重新绑定x的值为一个表达式运算的结果
	julia> x = 1 + 1
	2
	# 也可以把变量x绑定到其他的数据类型上去（比如字符串）
	julia> x = "Hello World!"
	"Hello World!"
```
"""

# ╔═╡ 36ce4558-39b7-4c2e-9e78-4f0ecbdfae41
md"""
你可以把变量看成是**盒子**的名字。 这个盒子里面可以装各种类型的数据。比如， x = 10， 就可以看成是名叫x的盒子， 里面装的是数字10。 很多语言要求变量名只能是字母数字下划线构成， 在julia中，你可以使用几乎所有可能的符号做变量名。
"""

# ╔═╡ 03901eec-aa18-48b2-a807-7a7551e6268f
中国 = 100

# ╔═╡ a0cdaed9-868c-4619-9ee5-665ee6f69686
中国

# ╔═╡ 0ab3c5e9-3767-404b-a361-7f194e740be3
美国=80

# ╔═╡ 2dc076e1-9d5a-4d6f-ad52-78f3c60a5a58
中国 - 美国

# ╔═╡ b38e185e-c64e-4c26-9e58-c9ad2dec3969
π = "你好"

# ╔═╡ 9cbd6def-d1e9-406e-a6db-5baecc535537
⬠ = "五边形"

# ╔═╡ 5defb84a-0fe2-4972-8dd5-f0430426b4b4
π * ⬠

# ╔═╡ 89802f31-36af-4458-a1d7-f4f3c627a951


# ╔═╡ 2d963618-f5b5-47f1-85bc-832bbbc29e5b
md"""
# 基础数据类型
这里总结一些基础的数据类型， 主要有数值类型， 字符和字符串类型， 字典与集合， 数组等几种常见的类型。Julia的优势之一就是它强大的类型系统。 在Julia中，任何数据都是有类型的， 就像C语言， 从而可以使代码运算速度加快。 但与此同时， Julia也可以不指定数据类型， 这时候它会给数据一个默认的数据类型， 这让Julia写起来， 又有点像R和Python。 虽然我们可以不指定数据类型， 但知道一些基本的常识，有利于我们写出高性能的代码和读懂别人写的代码。因此， 下面过一下基本的一些数据类型。 参考[Julia编程基础第五章](https://github.com/hyper0x/JuliaBasics/blob/master/book/ch05.md)
"""

# ╔═╡ 7fc75f1d-d3c4-435d-a6d3-9a9f453e999c
md"""
## 数值类型
数字是我们从小的开始学习的概念， 从最开始的整数到，有理数， 实数， 复数，我们接触了各种数值的概念。 在程序语言中， 数值是通常最简单、最基础的数据类型。有些语言不关注数据的具体类型， 都统一视为“数字”。 但强于科学计算的Julia语言， 有丰富的数值类型， 罗列部分如下：

		- 布尔类型：Bool
		- 有符号整数类型： BigInt、Int8、Int16、Int32、Int64和Int128
		- 无符号整数类型： UInt8、UInt16、UInt32、UInt64和UInt128
		- 浮点数类型： BigFloat、Float16、Float32和Float64
将数值细分为不同的类型是有意义的， 不仅能减少数据的存储空间， 还可以提交数据的计算效率。 当然， 如果你觉得处理这么多数据类型很麻烦， 你也可以不管数据类型。 Julia会自动选择默认的数据类型。 比如， 通常整数会当成Int64的类型（在64位的机器里）， 而带了小数点的有理数会当成Float64类型。

"""

# ╔═╡ e635ce57-29b9-4164-881b-132f41e3b6ba
md"""
#### **获取对象的类型typeof**
下面的代码显示整数默认是Int64类型， 实际上， 因为我的电脑是64位， 所以显示是Int64， 如果是32位的机器上，下面的结果会是Int32.
"""

# ╔═╡ 1a1880ca-f9d5-45df-a8c7-65026c990962
typeof(10), typeof(10.5)

# ╔═╡ f344e8fa-67cd-411e-9a75-5d5406bb3ff9
md"""
#### 正负无穷大与不存在（Inf*, NaN*）
Inf*表示无穷大（*表示宽度）， NaN*表示不是数（Not a Number）， 参考下面的例子。
"""

# ╔═╡ e2513772-84f0-4bcc-b234-fb30054e1dd5
typemax(Int64), typemax(Float64), 1/0, 0 * Inf

# ╔═╡ 35fbe418-4bd5-4dee-a98d-9e976a8cb3d9
md"""
## 运算符
这里主要是总结一下Julia中的常见操作符，也称运算符（Operator）。 Julia中的运操作符是用于对变量和值执行操作的数学符号， 这些符号通常用来进行算术和逻辑计算。 操作符对其执行操作的变量称为操作数(Operands)。 比如，在表达式
`a + b` 中， a和b就是操作数，而 `+` 就是操作符。 作为入门和基础的应用， 需要我们掌握以下四种运算符： 

- 算术运算符  
- 逻辑运算符  
- 赋值操作符  
- 矢量化的点操作符  
- 比较运算符  


可参考这篇[文章](https://www.geeksforgeeks.org/operators-in-julia/)获取更多的细节描述。
"""

# ╔═╡ 292223b0-0549-47d5-9c13-55e4bca029e2
md"""
### 算术运算符
算术运算符是一门语言中常见的， 主要包括 + - * /等。

|运算符| 含义 | 用法|
|-----|------|-----|
| + | 求和  | a + b |
| - | 求差  | a - b |
| * | 乘法  | a * b |
| / | 除法  | a / b |
| \ | 除法  | a \ b (等价于 b / a) |
| $\div$ | 整除 | a $\div$ b|
| % | 求余数 | a % b|
| ^ | 乘方  | a ^ b|

注意， + - 也可以用作一元运算符， 在变量前添加 + ， 不会改变变量值； 添加 - ， 会将变量变相反数。 上面的$\div$在编辑器中可以通过 \div+[TAB] 键输入。 这也是Julia特殊的地方， 它是完全支持Unicode字符的， 所以我们可以使用类似于数学书写的方式去写各种变量。 以后看到类似的数学符号， 他们都是通过相应的latex符号+ TAB键打印出来的。 你也可以通过复制一个符号， 然后用 `? 符号`的方式在REPL中获得其书写方法帮助。
下面是一些例子：
"""

# ╔═╡ f699b11c-6d47-4c18-9fef-3136467a090c
7 ÷ 3

# ╔═╡ 8acfc20e-2d57-4cc6-a24e-42fa8acf012a
?÷

# ╔═╡ 01496ff6-683a-4d00-951e-691e7945c293
α 

# ╔═╡ 5839e72e-8771-4184-a065-2196ba60b2f4
2^3

# ╔═╡ 0b6940b5-9d5e-439d-a974-fa056ee1ad2e
 # 定义变量， 你也可以改变这里的定义, 一次给多个变量赋值， 跟Python类似
a, b = 9, 4

# ╔═╡ 4e8df286-dfb2-4693-9261-64a9bcc9d002
(a + b, a - b, a * b, a / b, a \ b, a \ b == b / a, a ÷ b, a % b, +a, -b)

# ╔═╡ 4e544be5-4a04-4182-a58e-13bdcd6c517e
md"""
### 比较运算
比较运算主要用于对变量的大小比较，主要有大于、小于、等于，以及衍生的大于等于、小于等于、不等于等6种情况， 比较的结果通常是逻辑值 true 或 false， 常用于 if 语句等逻辑判断场景。 下面是具体用法：

|运算符| 含义 | 用法|
|-----|------|-----|
|>	| 大于: 左操作数大于右操作数时为 true	| x > y |
|<	| 小于: 左操作数小于右操作数时为 true	| x < y |
|==	| 等于： 左操作数等于右操作数时为 true    | x == y |
|!=, ≠	| 不等于： 左操作数不等于右操作数时为 true 	| x != y or x ≠ y |
|>=, ≥	| 大于或等于: 左操作数大于或等于右操作数时为 true	| x >= y or x ≥ y |
|<=, ≤	| 小于或等于: 左操作数小于或等于右操作数时为 true	| x <= y or x ≤ y |

注意， 上面几个特殊符号对应的latex代码≠ （\ne）, ≥ (\geq), ≤ (\leq) 。 
下面是几个例子：

"""

# ╔═╡ b1d9c45b-3a31-4029-895c-427d44d44d40
4 ≠ 4

# ╔═╡ f12ade36-ff61-435b-9a76-e9f739fe79ce
a > b, a < b, a == b, a != b, a >= b, a <= b

# ╔═╡ d5b8e5de-f040-408c-92ac-aed3c3dffe51
md"""
### 逻辑运算符
逻辑运算符主要用于构造复合条件， 多用于程序流程控制。 主要是三种： 与（and）, 或（or）, 非（not）。 具体用法如下：

|运算符| 含义 | 用法|
|---|---|---|
| &&	| 与: 当且仅当两个操作数都是 true 时， 结果为true	| x && y|
|  \|\|	|或： 当至少有一个操作数为true时， 结果为true |	x \|\| y | 
| !	| 非： 将true变为false， false变为true | !x |

下面是几个例子， 其中`isodd`, `iseven`分别用于判断一个数是奇数和偶数。
"""

# ╔═╡ 28a8e5e5-d904-4888-b36b-13c0aad8f3a1
a, b

# ╔═╡ 3540f431-7b50-4ed1-9d66-3cb4568856a2
isodd(a), iseven(b), isodd(a) && isodd(b), isodd(a) || isodd(b), !isodd(a)

# ╔═╡ 5912b3ca-a74b-4174-859c-ed5b4cd669d5
md"""
### 常用数学函数
Julia 预定义了非常丰富的数学函数。一些常用的函数如下：

- 数值类型转换： 主要有T(x)和convert(T, x)。其中，T代表目的类型，x代表源值。
- 数值特殊性判断： 有isequal、isfinite、isinf和isnan。
- 舍入： 有四舍五入的round、向正无穷舍入的ceil、向负无穷舍入的floor，以及总是向0舍入的trunc。
- 绝对值获取： 用于获取绝对值的函数是abs(x)。一个相关的函数是，用于求平方的abs2(x)。
- 求根： 函数sqrt(x)用于求取x的平方根，而函数cbrt(x)则用于求取x的立方根。
- 求指数： 函数exp(x)会求取x的自然指数。另外还有expm1(x)，为接近0的x计算exp(x)-1。
- 求对数： log(x)会求取x的自然对数，log(b, x)会求以b为底的x的对数，而log2(x)和log10(x)则会分别以2和10为底求对数。另外还有log1p(x)，为接近0的x计算log(1+x)。

除了以上函数之外，Julia 的Base包中还定义了很多三角函数和双曲函数，比如sin、cos、atanh、acoth等等。另外，在SpecialFunctions.jl包里还有许多特殊的数学函数。不过这个包就需要我们手动下载了。
"""


# ╔═╡ d74a2fae-422d-4f9d-be03-d438535e2a70
ceil(5.6), floor(5.6)

# ╔═╡ f92faad9-15f5-4a2a-951d-42a4b2744e4e
convert(Int64,10.0)

# ╔═╡ cc6f8d8b-fa94-418c-9b1b-11d517e5bb8c
ceil(4.5)

# ╔═╡ c0764726-337c-4c9c-b0bc-235cca726051
floor(4.5)

# ╔═╡ 27e2d30c-96bb-4a28-ba47-6ea7d9bb3b2d
md"""
### 矢量化的点操作符
点操作符是Julia中实现向量化运算的关键操作符。在R、Python等语言中， 许多运算默认都是向量化的。 但在Julia中， 情况有所不同。 在Julia中， 只要在一个运算的前面加上一个点， 这个运算就变成了向量化的了。 即这个运算会作用到运算对象的每一个元素上。 
"""

# ╔═╡ 88e526c6-cd09-4a75-9bc0-cec5a7a80234
v1 = [1,2,3]; v2 = [4,5,6];

# ╔═╡ a89c40a4-4d12-4fc5-8cb9-75a8e2c9f708
v1 .* v2

# ╔═╡ 698fa3c2-b992-40ce-b69e-ab9465ecf287
v1^2

# ╔═╡ ff6530fa-8b79-4321-bde4-d42f3de138c5
v1.^2

# ╔═╡ a779ef7b-f4ff-4d01-9f69-6e04d4e224a9
v1 .* v2



# ╔═╡ e793992d-2837-41a4-9cbe-ab8cf3b2107e
typemax(Float16)

# ╔═╡ 8632439c-d232-4409-ab8c-e6ad2bf032d8
typemin(Float16)

# ╔═╡ 7e049a7f-b8d0-48e5-b5f6-a49c77760785
1/0

# ╔═╡ 42119f8c-df8e-4694-969f-65801856ea18
0 * Inf

# ╔═╡ a4d6c456-6820-40d0-afaf-fe4abae93e0e
md"""
## 字符与字符串
Julia支持Unicode编码， 单个的字符用**单引号**包裹。 字符串用**双引号**包裹，  也可以用三联双引号， 通常用于文档中。 字符的类型是Char， 字符串的类型是String。
"""

# ╔═╡ 53131e75-c2b4-466f-ba79-16502afb5994
typeof('a')

# ╔═╡ f78e2451-4a2e-4e62-83ca-e29e286f3e8a
'中'

# ╔═╡ cf6e3e5c-44fa-42a6-b673-399207c5e7a2
length("我爱Julia！")

# ╔═╡ da23c8b2-eb37-49c1-9631-346df6d1b2f2


# ╔═╡ 83393a23-3579-4cd4-af61-729c6d018074
md"""
#### 字符串的常用操作
- `sizeof` 获取字符串（任何对象都可以）占用的字节数。
- `length` 获取字符串的字符数量。
- `*` 字符串拼接， 也可以使用`string`函数。
- [i] 字符串索引(获取第i个字符）， 不过请注意Unicode字符串索引可能引发的问题。
- [i:j] 字符串截取（获取索引号从i到j的所有字符）。
- `$(var)` 用变量var的值插入字符串中。
- **搜索**。 `findfirst`, `findlast`, 请使用`@doc 函数名` 的方式获取其使用方法。
- occursin, contains 判断一个字符串是否包含某个子串（或模式）
- startswith， endswith 判断字符串是否以某个子串开头或结尾
- first, last 获取字符串前面或结尾的n个字符。
"""

# ╔═╡ a27ab32c-234c-4aed-afe0-7322f80eefe2
"good" * "morning"

# ╔═╡ 075479d5-3e84-4986-9997-c91db99b2855


# ╔═╡ 100ab0c0-d2ee-4dfb-ac3d-fe0c5d64ba50
id = "352719200008101112"

# ╔═╡ 85c998ac-fc82-4a9b-8f00-2b8fc918d45b
parse(Int64,id[11:12])

# ╔═╡ e4518582-b59c-42c5-99df-3050ec380be9
str = "我爱julia！"

# ╔═╡ ac876fd2-3d8a-4935-b820-f457ee7eddb4
str[1:2]

# ╔═╡ b784f2fc-0b13-4b8e-97f1-f302693106d7
sizeof("我")

# ╔═╡ dcaf2d4a-5ed7-4a20-8067-3bd132ede38d
str[1:4]

# ╔═╡ d6d17cbb-e1db-458e-9a42-3b512c242fb1
sizeof("我爱")

# ╔═╡ 9ae6d271-39ee-4ccb-891f-6544898f8fe7
length(str)

# ╔═╡ 7c31f5b7-500d-4e7c-96a1-19db5ccf8f72
sizeof(str)

# ╔═╡ 13c81d30-da5f-4e6b-a294-567392996a9a
str[1:4]

# ╔═╡ f1ce2a50-b769-4332-8c1d-cf11b3e08293
sizeof(str)

# ╔═╡ 72c20cb6-da93-427b-a38c-e7ff3c9fab3e
length(str)

# ╔═╡ 7f64e457-50d0-491c-a207-fa79b5fb4c3f
first(str, 2)

# ╔═╡ d62a0bed-29ba-49e1-ac25-90dad9c3a574
contains("JuliaLang is pretty cool!", "Julia")

# ╔═╡ 43acbce2-d2cd-428e-a5da-3d28af05e4be
md"""
字符串在数据分析中一种常用应用是： 我们读取的数据可能是字符串格式， 需要将其转换为数字。常使用的函数是`parse(type, str)`， 这个函数通常用于类型之间的转换。
"""

# ╔═╡ d83a5d22-a5c8-4e39-8714-d16edd4cfa09
parse(Float64, "33222.45")

# ╔═╡ b398f7e6-1d5a-4249-a4fd-771a6616ec6c
md"""
# 重点数据类型（容器）
接下来介绍经常碰到的两种重要数据类型。也是容器类型。容器类型， 就是由包含多个数据对象的集合类型。
## 元组类型
元组是由**括号**包裹的一个容器。里面可以填充任何对象， 但**元组不能修改**， 常见于函数参数，返回值等。 通常，用逗号隔开的数据自动构成一个元组。 可以将元组想象成一个有多节车厢的小火车， 每个车厢可以装不同的数据， 所有车厢构成一个整体。

常见的操作包括：
- 元素提取： 我们可以使用[]去提取元组的元素（类似字符串）。 
- 元组拼接： 不能使用*+等符号， 可以使用元组的构造方法， (t1..., t2...),或者函数tuple。 其中`...`的作用是将其左边的对象的所有元素值平铺开来。
"""

# ╔═╡ b21dedc7-23a2-4e79-84fc-943dd3053fab
t = "ok",15

# ╔═╡ 718f6f4a-f337-4cb3-a9f1-e90a32411d8e
t[2]

# ╔═╡ b0cb4f2c-db8f-4b48-acb4-3b599a5144c5


# ╔═╡ afd0c8c3-b0af-4855-9d13-af0a2e68372d
t1 = (1,2,3)

# ╔═╡ 15c45167-4b0a-4630-af0c-20328f8c7835
t2 = (4,5,6)

# ╔═╡ 032120c8-ae85-479c-897a-579d7200a943
t1..., t2...

# ╔═╡ 6a8e2e1c-ca66-4f56-a912-411e6ab87c4f
tuple(t1, t2)

# ╔═╡ 6437b9bd-2936-47d8-a1dd-987d68c00d00
t3 = ((1,2), 3, (4,5))

# ╔═╡ 8e01e846-b392-4610-8be1-e15485a74eaf
md"""
**有名元组**
有名元组中的“有名”并不是说元组有名字，而是说其中的每一个元素值都拥有自己的名字。例如：

"""

# ╔═╡ 0a4a689d-5a4e-4d5e-a278-beb137a80ac6
named_tuple1 = (name="Robert", reg_year=2020, extra="something")

# ╔═╡ a2f9b403-8ad7-4e6a-8e47-9b3bc0f4f73c
 reg_year,extra = named_tuple1

# ╔═╡ c5b7f19b-1d06-4c30-b9d6-700e6d8cb95b
md"""
## 数组
数组是科学计算中使用非常频繁的一种数据结构。 最常使用的有一维数组（向量），二维数据（矩阵）。与元组对比，数据具有如下特点 ：1）元素是可变的； 2）数组中所有元素都具有相同类型； 3）数组具有维度；

数组的类型是Array{T,N}， 其中T表示数组元素的类型， N表示数组的维度。 一维数组（向量）也可以表示为Vector{T}, 二维数据可表示为： Matrix{T}
"""

# ╔═╡ 5ffe88cd-6e98-4705-b427-51c1bbca3ea6
md"""
### 数组的构造
通常情况下， 尤其是在REPL中哦， 用中括号[]构造数据。 用空格、逗号、分号都可以分隔元素， 但含义各不相同。 通常， 逗号分隔的元素会被排列成一列； 空格分隔的元素会被排列成一行， 而分号会起到拆解拼接的作用。
"""

# ╔═╡ b4f5295a-71a1-45a1-b840-465b97dfa35f
# 空格分隔的元素被排成了一行， 请注意返回结果是一个一行的矩阵， Julia中没有行向量。
[1 2 3]

# ╔═╡ 77ec8655-ce23-4156-8923-517137d91535
# 逗号排成一列， 结果是向量。
 [1, 2, 3]

# ╔═╡ 0a3257ba-e9f8-4a39-a730-9273c582ee8b
# 分号构建的也是列向量
[1;2;3]

# ╔═╡ 85813563-d7c2-4e63-83bb-8aa9895e10e6
# 分号会将前面的的元素拆解， 但只会拆解一层
[[1, 2]; [3,  [4, 5]];]

# ╔═╡ a141eaaf-1cef-47d0-b005-edea009c7b9d
# 我们说数组的元素类型要相同， 这里一个整数， 一个字符， 很明显类型不同， 但Julia也认可， 原因是默认会做类型提升， 提升到Any类型（也就是啥类型都可以）。 
typeof([1, 'a'])

# ╔═╡ a36438b3-e1fc-41d2-9e1d-5a35f8d5bc37
ma = [1 2; 3 4]

# ╔═╡ 02ba9156-7b3a-4b82-a10f-af98273c1401
typeof(ma)

# ╔═╡ b2d2446b-691a-4575-9650-59a5bb5f9424
md"""
有时候， 我们需要构造大量的数据， 用上面的方法是不行的。 这时可以使用数组的构造函数。 类型构造类似函数调用， 就是把类型名当函数名， 把数据当调用函数的参数。

比如， 构造一个Int64的向量， 可以用`Array{Int64, 1}()`, 在构造的时候， 我们可以指定初始值， 也可以指定元素的个数， 比如 `Vector{Float32}(undef, 100)` 就是构造一个长度是100的未初始化的元素类型是Float32的向量（用`@doc Vector `可以查看帮助文档）。 对于向量来说， 还可以用  **类型[]**的方式构造某种类型的向量, 但不能同时指定长度。 
"""

# ╔═╡ 78bcb294-fb84-4b4d-a97c-4e9928d48c8b
Array{Int64, 1}()

# ╔═╡ fe74029a-f5ac-48ec-944a-643339767a06
ty = Int32[]

# ╔═╡ 38ca5fa7-d0e2-42fb-b5ac-974daa4c3cef
Vector{Float32}(undef, 100)

# ╔═╡ f434ec9b-f21f-4b13-a2b3-0d1fb3249e1c
md"""
**一些其他构造方法**
- 特殊数组的构造。 比如全是1或0的数组， ones(m, n)(构造m*n的全1矩阵)， zeros(m, n, k)构造全是0的三维数组。 
- 根据已有的数据去构造。 已有一个数组A， 要构造一个跟A的结构一样的（维度，长度都一样）数组， 可用similar函数。 如similar（A）构造一个数据类型和维度跟A完全相同的未初始化数组。
- rand: 可以通过给定维度长度构造（0,1）间的随机数数组， 例如：rand(m, n)构造m*n的随机矩阵。-
- randn: 可以通过给定维度长度构造符合正态分布的随机数数组
"""

# ╔═╡ c28b635b-8595-4afd-9b10-d48a69075ae4
ones(3,4)

# ╔═╡ 0ef61758-ac55-45dd-aaaa-776fdd254009
rand(3,4)

# ╔═╡ d3a303c2-3b95-4b4b-b07e-26650f7e984d
let
A = rand(3,4 ); 
similar(A)
end

# ╔═╡ 14cbe708-d673-4f76-93d9-855286429db0
rand(3,4 )

# ╔═╡ 5a9e906b-1e3a-4bc1-b7f1-8ab4ca607169
rand(3,4)

# ╔═╡ eb8159ae-9e94-4a5f-9264-01f0ed72a0ce
md"""
有时候， 我们可能需要构造等差数列， 这可以方便的使用冒号运算构造, 基本语法是：` start:step:stop`，表示构造从start开始， 步长是step，到stop结束的集合。可以不指定步长（step）， 这时默认步长为1。 只是， 这种情况下，构造的并非向量， 需要使用`collect`函数， 将构造的所有元素提取出来， 才能形成一个向量。
"""

# ╔═╡ 113c916f-a534-416b-a601-b9484de3225f
1:2:10, typeof(1:2:10), collect(1:2:10)

# ╔═╡ 014ec4b5-1430-4cdb-8db9-e377fe1cda22
typeof(1:2:10)

# ╔═╡ 7a7fdd35-0c54-44f1-b248-c1da3b846a2d
collect(10:-2:1)

# ╔═╡ 05b2f5c1-cecc-4815-ad4c-87bce0b103ca
md"""
### 数组操作的基本函数
- eltype： 获取数组的元素类型。
- length： 获取数组的元素个数。
- size： 获取数组各个维度上的长度， 还可以指定维度dim，获取指定维度的长度。 
- reshape: 改变数组的维度
- [i,j,k]: 典型索引操作， 获取（假定是3维数组）第i,j,k号元素(这是笛卡尔坐标表示)。 也可以使用：连续选取， 或者仅用：表示选取所在维度的所有元素。
- view: 用于创建数组的视图， 对视图的操作相当于对原数组相应部分的操作。
- sort: 用于对数组排序。

- copy， deepcopy： 数组的复制， copy只是浅复制（只有原语类型的元素被复制， 其他的只是引用）。 deepcopy是深复制， 会复制所有的元素。
- push!, append!：将元素push进一个集合（向量）。
- pop!: 从集合中弹出一个元素， 如果是有序集合（比如向量）则是弹出最后一个元素。


- **搜索**
|函数名|	搜索的起始点|	搜索方向	|结果值|
|---|---|---|---|
|findfirst|	第一个元素位置|	线性索引顺序|	首个满足条件的元素值的索引号或nothing|
|findlast|	最后一个元素位置|	线性索引逆序|	首个满足条件的元素值的索引号或nothing|
|findnext|	与指定索引号对应的元素位置|	线性索引顺序|	首个满足条件的元素值的索引号或nothing|
|findprev|	与指定索引号对应的元素位置|	线性索引逆序|	首个满足条件的元素值的索引号或nothing|
|findall|	第一个元素位置|	线性索引顺序|	包含了所有满足条件元素值的索引号的向量|
|findmax|	第一个元素位置|	线性索引顺序|	最大的元素值及其索引号组成的元组或NaN|
|findmin|	第一个元素位置|	线性索引顺序|	最小的元素值及其索引号组成的元组或NaN|
"""

# ╔═╡ e1f4ea2c-9205-45f7-99a7-6257bd7c6155
@doc findfirst	

# ╔═╡ 98a6c543-a3d7-4af0-b2a3-569d3236e7fa
x0=1:10

# ╔═╡ 0341584f-6ece-4b46-b116-628ff80da05e
xx = rand(3,4)

# ╔═╡ 0330c4cf-ac86-45f3-8d77-1cedb6fcaf5d
xx[1:2,2:3]

# ╔═╡ c5f31690-2814-4280-9d5e-d8ebbc0066a3
size()

# ╔═╡ 8a4c2cf4-dffb-4487-93d1-ae3cd32eb4a0
x0[5]

# ╔═╡ 4d8f459b-3c54-4a9e-83e0-1f6fafee5461
x1 = zeros(3,4,5)

# ╔═╡ f94664c4-c237-4cf0-bd8a-2145ecd4deaa
x2 = ones(3,1,1)

# ╔═╡ 7d155360-6d3f-43c2-829c-fb0990f963af
tmp = rand(2,3,4)

# ╔═╡ 0edff351-2fc8-4759-b2ad-fb5c447119d2
length(tmp), size(tmp), size(tmp, 1)

# ╔═╡ 29e0cc0b-50a0-43b6-a41e-681041b02fe1
md"""
下面这个例子显示了数组的存储方式和编号特点。从中可以看出， Julia中的数组是按列存储。对于三维数组，可以想象一本书， 比如一个m$\times$n$\times$k的三维数组A，可以想象为一本有k页的书， 每一页都是m行，n列。 这本书按照从上到下从左到右的方向读。 这样， A[:,:,k]表示这本书的第k页， 它应该是m$\times$n的矩阵。
"""

# ╔═╡ f5a96665-ee82-4aec-8db8-59ec603276be
mx = reshape(1:24, 2,3,4)

# ╔═╡ 5893af83-2924-4024-9eda-ba0a9dc1e326
findfirst(iseven, mx)

# ╔═╡ 5ca71a2a-b7c5-494a-b7e4-25dc4b0a11fa
md"""
### 数组推导
数组推导是构建数组的一个常见形式。与python类似，Julia也提供了数组推导式, 通用的格式如下：
- [f(e) for e in colletion if condition]。 这是遍历collection里面的元素， 当满足条件condition时就进行某种操作f， 最后形成一个数组。 e in colletion 也可以写成 e = colletion， if condition可以省略, 下同。
- [f(x,y) for x in c1, y in c2 if condition]。 这种情况下， x,y分别从两个集合c1,c2取值，如果没有if条件，结果是一个矩阵， 矩阵第i,j位置上的元素是f(x[i],y[j])， 由于Julia中矩阵按列存储， 所以会先计算出第1列，再第二列，依次类推； 如果有if条件， 结果是向量， 相当于先计算一个矩阵，再过滤掉不满足条件的元素。  
**注意：**如果外侧不是用[ ]包裹， 那就不是数组推导。 比如， 用（）包裹得到的可不是python里面的元组， 而是生成器了。
"""

# ╔═╡ 92977747-cbc3-41e5-ba86-a8f1bb547a4c
[x + y for x in [1,2,3] , y in [4,5,6,7] if isodd(x)]

# ╔═╡ 8b9e2b3b-4654-40bd-9304-2ac8f520a2b7
[x + y for x in [1,2,3] , y in [4,5,6,7] ]

# ╔═╡ 46662d36-c690-4bb4-998a-6d6ac9b33a51
[e^2 for e in 1:10], [e^2 for e in 1:10 if iseven(e)]

# ╔═╡ 89ca9824-0441-42e6-aeaf-04bf26600474
[x + y for x in 1:3, y = 4:6], [x + y for x in 1:3, y = 4:6 if x + y > 0]

# ╔═╡ 49ec27d1-72ec-4e50-b38e-bef8941e5522
[x + y + z for x in 1:2, y in 3:5, z in 6:9]

# ╔═╡ 2a24a278-6b7c-439b-b0b6-4fa57b6d98c0
(x + y for x in 1:10, y = [1,2])

# ╔═╡ 2dd38b7f-1310-460e-996d-61f104dbfa7d
## 范围

# ╔═╡ 712fd1de-8d5b-4435-89f6-ef5caf16dc07
typeof(1:10)

# ╔═╡ fb2d2b03-f23a-4b7e-a82d-2d0bb7d279e9


# ╔═╡ f4bde725-a4c4-4822-b4db-cd66a21e9944
md"""
# 流程控制
流程控制是实现逻辑的重要一环。程序从结构上可以分为顺序结构、分支结构和循环结构三种。默认情况下，程序会顺序执行， 当需要构造分支和循环时， 需要特殊的关键字。在Julia中，有：
1. if elseif else end. 实现分支语句， 注意，Julia中一个代码块需要以end结尾。
2. for i in collection ... end。 实现固定范围的for循环。
3. while condition... end。 实现基于条件的while循环。
4. break， continue， 用于跳出、提前结束循环。
5. let....end。 用于构造一个局部执行环境。
"""

# ╔═╡ 84d5071e-2b91-4341-8839-0352172afb7d
begin
	# 声明一个变量
	some_var = 5
	
	# 这是一个 if 语句，缩进不是必要的
	if some_var > 10
	    println("some_var is totally bigger than 10.")
	elseif some_var < 10    # elseif 是可选的.
	    println("some_var is smaller than 10.")
	else                    # else 也是可选的.
	    println("some_var is indeed 10.")
	end
	# => prints "some var is smaller than 10"
end

# ╔═╡ 1e01d43a-01a0-46eb-bc80-5c00d7b6c135
begin
	# For 循环遍历
	# Iterable 类型包括 Range, Array, Set, Dict, 以及 String.
	for animal=["dog", "cat", "mouse"]
	    println("$animal is a mammal")
	    # 可用 $ 将 variables 或 expression 转换为字符串into strings
	end
	# You can use 'in' instead of '='.
	for animal in ["dog", "cat", "mouse"]
	    println("$animal is a mammal")
	end
	
	for a in ["dog"=>"mammal","cat"=>"mammal","mouse"=>"mammal"]
	    println("$(a[1]) is a $(a[2])")
	end
	
	for (k,v) in ["dog"=>"mammal","cat"=>"mammal","mouse"=>"mammal"]
	    println("$k is a $v")
	end
end

# ╔═╡ e9537736-ebd3-40a6-9a5f-9b10e91591cb
begin
ret = 0
for i in 1:100
	ret = ret + i
end
end

# ╔═╡ cf5175fe-6e65-42e3-8f25-5a99ca86936d
ret

# ╔═╡ 64945427-7fbf-441b-80e4-a6dfbe9af463
begin
	# While 循环
	i = 0
	while i < 4
	    println(i)
	    i += 1  # i = i + 1
	end
end

# ╔═╡ 48e47bea-64cb-4e97-97dd-f37761fea418
# 用 try/catch 处理异常
try
   error("help")
catch e
   println("caught it $e")
end

# ╔═╡ ec1ec66a-ea21-47d6-9c1a-92ea11629e7d
md"""
# 函数编写
函数编写是一门语言非常重要的内容， 有了上述流程控制的内容， 编写函数就容易多了。 在Julia中， 有多种定义函数的方法。
- 经典定义
```julia
# 其中Type1，Type2， Type等都表示某种数据类型。
function funname(par1::Type, par2::Type2, ...)::Type
# 函数体
end
```
在函数定义中， 对任何参数（parlist）以及函数的返回值， 指定类型（`：：type`）都是可选的。通常指定类型，可以让函数具有更高的运行效率， 不指定类型，函数编写更容易。 比如下面定义的求和函数， sum1可以对任何的数字求和， 而sum2只能对Int64类型的整数求和。
```julia
function sum1(a,b)
	a + b
end 

function sum2(a::Int64,b::Int64)
	a + b
end 
```

- 简洁形式（赋值形式）
有时候， 函数很简单， 可能只要一行就够了，这时候可以通过赋值的形式去定义函数。
```julia
funname(par1, par2, ...) = 表达式
```
这种写法类似于数学函数的写法， 比如二次函数$f(x) = 3x^2 + 2x + 1$， 写成一个Julia函数，几乎是一样的。注意在下面，数字和字母x之间可以没有乘号*， Julia自己能判断这种情况是省略乘号的乘法（是不是很数学？）， 因为变量不能以数字开头去命名。
```julia
f(x) = 3x^2 + 2x + 1
```

- 匿名形式（匿名函数）
有时候， 我们只是临时需要一个功能， 不想给它命名， 这时候可以用匿名函数的形式。
```julia
(parlist) -> 表达式
```
匿名函数一般出现在一个函数的参数需要一个函数时。 通常这种函数会比较简单。 当匿名函数可能很复杂时， 可以使用do形式。 下面的do end之间的部分是一个匿名函数， 函数的参数是x。 这个函数将作为map的第一个参数。

```julia
map(1:10) do x
    2x
end
```




"""

# ╔═╡ fc9a465d-bdea-46fe-8427-17aa8dfa9120
ff(x) = 3x^2 + 2x + 1

# ╔═╡ 525285e8-065a-4d31-9b2c-a4bedeb9d8b4
ff(2)

# ╔═╡ 2102c883-4c2f-461b-bfea-5421c9bfcae8
md"""

### 函数参数
函数参数有两种类型： 位置参数和关键字参数， 每一种又分可选和必选， 位置参数和关键字参数在定义时用分号(；)分隔。 其中位置参数是通过位置来确定参数的赋值， 因此， 调用函数时， 提供的参数的顺序必须要跟对应的位置参数完全匹配。 关键字参数具有一个参数关键字， 调用的时候需要带着关键字去调用， 这时自然也不需要关注顺序的问题。 下面定义的函数`f`的参数中， `a,b...`是必选位置参数， `m,n,...`是可选位置参数（必选位置参数必须在可选位置参数之前）， 可选的意思是，如果没有给定也没关系（因为有默认值）。 分号之后的`key1, key2, ...`等是关键字参数， 关键字参数也可以提供默认值, 成为可选的关键字参数（否则就是必选的关键字参数， 没有必选要在可选之前的规定）。 注意， 位置参数调用时不能指定参数名， 指定参数名， 必然意味着这个参数是关键字参数。 Julia中函数会根据位置参数及其类型实现多重分派(同一函数名， 根据不同的输入参数实现不同的功能)， 细节请参考相关文档。
```julia
function f(a,b,..., m=x1, n=x2, ...; key1, key2 = xk, ...)
#
end

```
"""

# ╔═╡ 41441746-c7d6-4857-8394-6bc72f43bffb
f(x) = 3x^2 + 2x + 1

# ╔═╡ 9657f65d-e46f-48e3-8d68-0c131fc303c2
f(2)

# ╔═╡ ebd59160-9185-4837-bec6-cdd4c4a9acc3
function f1(a,b, m=1, n=2; key1 = 4, key2=10)
#
	a + b + m + n + key1 + key2
end

# ╔═╡ 847d06b7-826c-4aea-9074-69182ec78871
f1(1,2,3,4,key1 = 5, key2 = 6)

# ╔═╡ 032ecfce-4068-423e-ad16-dc007881af26
function ftest(x,y=10;a=1,b)
x + y + a + b
end

# ╔═╡ f013daac-f334-400e-b6f2-d7ebc95d02b4
ftest(1,b=9)

# ╔═╡ 02f86f41-fb50-4a68-bb7a-38d333f168c2
f3(x) = sin(2x); f2(x) = cos(2x)

# ╔═╡ 6d5adffb-61ee-4ea4-871f-97acd6d273ff
plot([x -> x^2, x -> 2x+1], -2pi, 2pi)

# ╔═╡ 437c661b-4757-45b9-bc06-73fd720277de
plot(f, 0, 2pi, legend = false)

# ╔═╡ ce26d829-a7de-4194-96ef-9a81732db012
md"""
### 注意
在Julia中， 有一个关于函数的习惯，**如果一个函数会修改其输入参数，该函数名要以！结尾**。 反过来， 如果发现一个带惊叹号的函数， 那么要知道这个函数会修改输入参数。
"""

# ╔═╡ 9603700b-cd87-4873-b452-0fd0a9395c76
md"""
## 函数编写练习
### Ex1. 编写一个函数，用于返回一个向量的2范数。
"""

# ╔═╡ 86d11ad1-4842-4bdf-9e46-92ef48c3d9ef
norm(v) = sqrt(sum(v.^2))

# ╔═╡ 5a15f415-2959-4b80-ba2d-bf3edaf1f193
norm(v1, v2) = norm(v1 .- v2)

# ╔═╡ 6f386ffe-d3ec-40a9-80e7-30c8e4625fb5
norm(ones(10), 2*ones(10))

# ╔═╡ ab0b7723-6c28-4616-af5f-1e67b62fb03a
md"""
### Ex2. 编写一个函数， 用于实现对向量的最小-最大规范化。
在数据分析中， 因为不同的变量可能存在不同的量纲， 导致数据的大小分布情况是不一致的。 为了减少量纲的影响， 通常我们需要将数据转换到相同的尺度， 这称为数据的规范化。  最小-最大规范化是利用向量的最小-最大值将数据转换到给定的区间， 通常为[0,1]。 即
$$z = \frac{x - min_x}{max_x - min_x}$$
"""

# ╔═╡ 6276c42a-af0e-4277-8dc3-746f7466c010
function zminmax(v)
	dn = min(v...)
	up = max(v...)

	(v .- dn) ./ (up - dn)
end

# ╔═╡ b7433a36-3b91-4dcc-9cc8-bd2ea996f0b5
zminmax([4,5,6,7,10])

# ╔═╡ d851527a-d303-4870-b4a4-b393b138d2c2
md"""
### Ex3. 编写一个函数， 输入参数是一个表示年龄的整数， 输出结果是年龄代表的类别：老中青三种之一。判断条件是：年龄>60岁为老， [40, 60]为中， <40为青。
"""

# ╔═╡ bd574d52-e848-4a5a-a3b2-6b5e2264ceb5
function getclass(age)
	if age > 60
		return "老"
	elseif age >= 40
		return "中"
	else
		return "青"
	end
end

# ╔═╡ 9813645e-5070-4be6-afe3-66ced0456c22
getclass(100)

# ╔═╡ 9db85a08-3b02-4e12-ac20-d5e6e10addcb
md"""
## 自定义类型（高级）
在Python中， 我们可以编写类（Class）。一个类， 有自己的数据和相应的方法。 在Julia中， 我们仍然可以编写自己的数据类型， 但方法已经不再是跟数据绑定在一起了。 编写自定义的数据类型（复合类型）很简单， 只需要用struct关键字：
```
[mutable] struct Typename
field1
field2
...
end
```
默认的复合内容是不可修改的， 为了让结构中各个域可修改， 可在定义之前加关键字mutable。 此外， struct的各个域也可以通过`::Type`指定相应的类型。 

通常情况下， 数据类型会有自动生成构造函数。 默认的构造函数， 函数名就是类型名， 参数会依次赋值给每一个域。如果数据类型不同， 会尝试用convert转换后去赋值， 如果转换不了， 则会构造失败。 下面的代码可以定义平面上的一个点（x, y）。 然后用`Point2D(3, 4)`则可以生成一个具体的点。
```
struct Point2D
	x::Float32
	y::Float32
end
```

在一些高级语言中， 我们可以定义类(class)， 类中同时具有数据和可以绑定方法。 Julia的自定义类型不能在类型定义时定义方法。 但我们可以基于类型定义相应的函数（这种函数， 有时候称为函子）。 比如， 下面的代码我们希望定义一个多项式， 用coeffs来存储多项式的系数：
```
struct Polynomial
	coeffs
end
```
定义了这个多项式的表示类型之后， 我们可以定义该类型绑定的函数如下， 这个函数没有函数名， 函数名对应的是一个类型名， 前面的p在具体调用的时候会指向类型的对象。
```
function (p::Polynomial)(x)
	v = p.coeffs[end]
for i = (length(p.coeffs)-1):-1:1 
	v = v*x + p.coeffs[i]
end
	return v
end
```

此后， 在我们构造了类型的对象之后， 我们就可以用对象去调用这个函数了。 
```
t = Polynomial([1,10,100])
t(5)
```

这种通过给类型加方法使得类型的对象变得可被调用的机制(有点类似于Python中通过class定义数据和方法的过程)， 在一些高级的编程场合使用非常广泛， 比如， 在神经网络中， 就可以通过这种方式定义一种特殊的数据类型， 代表特殊的网络层， 然后定义相应的类型方法， 在初始化之后， 就可以通过对象去计算结果了。 可以把这种机制看成是面向对象编程的一种模拟。
"""

# ╔═╡ 355c0db5-ddfc-4af2-8902-1bcf0cacfb97
struct Point2D
x::Float32
y::Float32
end


# ╔═╡ 33a9f9ee-5e0c-4122-8656-f791c242eb65
p = Point2D(3, 4)

# ╔═╡ 3e5074ba-9b55-417f-99b8-b1ff3796c969
p.x, p.y

# ╔═╡ 7d2fe83e-f691-43a0-bd64-4b6ddafb7f8d
let 
struct Polynomial
	coeffs
end

function (p::Polynomial)(x)
	v = p.coeffs[end]
for i = (length(p.coeffs)-1):-1:1 
	v = v*x + p.coeffs[i]
end
	return v
end

p = Polynomial([1,10,100])

p(5), p(3)
end

# ╔═╡ 6900f9dc-1655-458a-8592-cb25c4319b92
md"""
### Ex4. 用结构体重写Ex2.
在建模过程中， 我们对原始数据施加了某个变换， 当新的样本来临时， 我们仍需要进行同样的变换才能用于模型的预测。 这时候， 我们需要将变换保存起来， 在后续碰到新的数据时， 再使用它去做变换。 这意味着， 我们需要存储变换过程中使用到的值。 为了实现这一点， 我们用一个结构体表示一个变换。

下面先定义最小-最大变换结构体。

"""

# ╔═╡ 30f934d3-9ece-43df-9f12-bbe2805a4120
mutable struct MinMax
	dn
	up
end

# ╔═╡ 5703fed8-0c25-4a94-a70a-626f90817cd0
md"""
有了结构体之后， 相当于我们有了一个抽象的变换。 当我们给定一个向量去“训练”后， 我们就可以用这个变换去变换数据了。
"""

# ╔═╡ 0b66c477-02be-44f8-ad85-a44824c3d24f
function fit!(t::MinMax, v)
	t.dn = min(v...)
	t.up = max(v...)
end

# ╔═╡ d32932e7-a200-4833-962c-aa1de136598d
T1 = MinMax(0,0)

# ╔═╡ 5f555381-cf5c-4122-957f-f01f5dca8cf1
fit!(T1, [4,5,6,7,10])

# ╔═╡ b9838c1d-9a89-4529-8c91-60a1f03eb503
T1

# ╔═╡ 693010e2-de30-4902-b24e-a5a3fdf15737
function transform(T::MinMax, v)
	(v .- T.dn) ./ (T.up - T.dn)
end

# ╔═╡ 6cb35f5f-20dd-4c44-9843-3687d847882d
transform(T1, [4,5,6,7,10])

# ╔═╡ 76e9e262-0599-4e9f-9a49-1a223602cfec
md"""
当有新的数据需要转换时
"""

# ╔═╡ 99f1f97b-d6cd-4d7b-a41f-73ae9c1786ce
transform(T1, [8,12])

# ╔═╡ 57f0cdb1-b4d0-45c3-97a1-59f42c369df9
md"""
有时候， 可能还需要逆变换， 比如知道变换后的值是 0.7， 变换之前是多少？
"""

# ╔═╡ 14f0ed67-7a2c-4ed1-9630-163d95de5bae
function inverse_transform(t::MinMax, v)
	v .* (t.up - t.dn) + t.dn
end 

# ╔═╡ 818fab0d-f4ae-41cd-a00f-874e3ef8aa54
inverse_transform(T1, 0.166667)

# ╔═╡ 63e58114-c900-48b6-a271-9a34199add6b
md"""
## 阅读作业
[DataFrame.jl](https://dataframes.juliadata.org/stable/)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Plots = "~1.38.6"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "cedc214eb01f3def0da8840e0a48d43984f87d6f"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c6d890a52d2c4d55d326439580c3b8d0875a77d9"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.7"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "485193efd2176b88e6622a39a246f8c5b600e74e"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.6"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random", "SnoopPrecompile"]
git-tree-sha1 = "aa3edc8f8dea6cbfa176ee12f7c2fc82f0608ed3"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.20.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "61fdd77467a5c3ad071ef8277ac6bd6af7dd4c04"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "660b2ea2ec2b010bb02823c6d0ff6afd9bdc5c16"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.71.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d5e1fd17ac7f3aa4c5287a61ee28d4f8b8e98873"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.71.7+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "37e4657cd56b11abe3d10cd4a1ec5fbdb4180263"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.7.4"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "2422f47b34d4b127720a18f86fa7b1aa2e141f29"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.18"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "6503b77492fd7fcb9379bf73cd31035670e3c509"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9ff31d101d987eb9d66bd8b176ac7c277beccd09"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.20+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "c95373e73290cf50a8a22c3375e4625ded5c5280"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "da1d3fb7183e38603fcdd2061c47979d91202c97"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "261dddd3b862bd2c940cf6ca4d1c8fe593e457c8"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.3"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase", "SnoopPrecompile"]
git-tree-sha1 = "e974477be88cb5e3040009f3767611bc6357846f"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.11"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "94f38103c984f89cf77c402f2a68dbd870f8165f"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.11"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c6edfe154ad7b313c01aceca188c05c835c67360"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.4+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╠═67019338-dca4-4fe1-8a7c-55cf5b929486
# ╠═91f95dc2-c9b1-4664-bf93-459c55887519
# ╟─7e8f6056-fccd-4a44-83bc-bf452ebaac17
# ╠═8ca0be6d-1b94-40eb-af87-d04756cb2509
# ╟─f0e96543-bbd5-4095-89e4-e11f510c2d12
# ╟─284d7a22-69b2-4bbb-95c0-c6c7ec32a57f
# ╟─167ee46b-e00f-406a-aa9e-b0d932641611
# ╟─36ce4558-39b7-4c2e-9e78-4f0ecbdfae41
# ╠═03901eec-aa18-48b2-a807-7a7551e6268f
# ╠═a0cdaed9-868c-4619-9ee5-665ee6f69686
# ╠═0ab3c5e9-3767-404b-a361-7f194e740be3
# ╠═2dc076e1-9d5a-4d6f-ad52-78f3c60a5a58
# ╠═b38e185e-c64e-4c26-9e58-c9ad2dec3969
# ╠═9cbd6def-d1e9-406e-a6db-5baecc535537
# ╠═5defb84a-0fe2-4972-8dd5-f0430426b4b4
# ╠═89802f31-36af-4458-a1d7-f4f3c627a951
# ╟─2d963618-f5b5-47f1-85bc-832bbbc29e5b
# ╟─7fc75f1d-d3c4-435d-a6d3-9a9f453e999c
# ╟─e635ce57-29b9-4164-881b-132f41e3b6ba
# ╠═1a1880ca-f9d5-45df-a8c7-65026c990962
# ╠═f344e8fa-67cd-411e-9a75-5d5406bb3ff9
# ╠═e2513772-84f0-4bcc-b234-fb30054e1dd5
# ╟─35fbe418-4bd5-4dee-a98d-9e976a8cb3d9
# ╟─292223b0-0549-47d5-9c13-55e4bca029e2
# ╠═f699b11c-6d47-4c18-9fef-3136467a090c
# ╠═8acfc20e-2d57-4cc6-a24e-42fa8acf012a
# ╠═01496ff6-683a-4d00-951e-691e7945c293
# ╠═5839e72e-8771-4184-a065-2196ba60b2f4
# ╠═0b6940b5-9d5e-439d-a974-fa056ee1ad2e
# ╠═4e8df286-dfb2-4693-9261-64a9bcc9d002
# ╟─4e544be5-4a04-4182-a58e-13bdcd6c517e
# ╠═b1d9c45b-3a31-4029-895c-427d44d44d40
# ╠═f12ade36-ff61-435b-9a76-e9f739fe79ce
# ╟─d5b8e5de-f040-408c-92ac-aed3c3dffe51
# ╠═28a8e5e5-d904-4888-b36b-13c0aad8f3a1
# ╠═3540f431-7b50-4ed1-9d66-3cb4568856a2
# ╟─5912b3ca-a74b-4174-859c-ed5b4cd669d5
# ╠═d74a2fae-422d-4f9d-be03-d438535e2a70
# ╠═f92faad9-15f5-4a2a-951d-42a4b2744e4e
# ╠═cc6f8d8b-fa94-418c-9b1b-11d517e5bb8c
# ╠═c0764726-337c-4c9c-b0bc-235cca726051
# ╠═27e2d30c-96bb-4a28-ba47-6ea7d9bb3b2d
# ╠═88e526c6-cd09-4a75-9bc0-cec5a7a80234
# ╠═a89c40a4-4d12-4fc5-8cb9-75a8e2c9f708
# ╠═698fa3c2-b992-40ce-b69e-ab9465ecf287
# ╠═ff6530fa-8b79-4321-bde4-d42f3de138c5
# ╠═a779ef7b-f4ff-4d01-9f69-6e04d4e224a9
# ╠═e793992d-2837-41a4-9cbe-ab8cf3b2107e
# ╠═8632439c-d232-4409-ab8c-e6ad2bf032d8
# ╠═7e049a7f-b8d0-48e5-b5f6-a49c77760785
# ╠═42119f8c-df8e-4694-969f-65801856ea18
# ╠═a4d6c456-6820-40d0-afaf-fe4abae93e0e
# ╠═53131e75-c2b4-466f-ba79-16502afb5994
# ╠═f78e2451-4a2e-4e62-83ca-e29e286f3e8a
# ╠═cf6e3e5c-44fa-42a6-b673-399207c5e7a2
# ╠═da23c8b2-eb37-49c1-9631-346df6d1b2f2
# ╟─83393a23-3579-4cd4-af61-729c6d018074
# ╠═a27ab32c-234c-4aed-afe0-7322f80eefe2
# ╠═075479d5-3e84-4986-9997-c91db99b2855
# ╠═100ab0c0-d2ee-4dfb-ac3d-fe0c5d64ba50
# ╠═85c998ac-fc82-4a9b-8f00-2b8fc918d45b
# ╠═e4518582-b59c-42c5-99df-3050ec380be9
# ╠═ac876fd2-3d8a-4935-b820-f457ee7eddb4
# ╠═b784f2fc-0b13-4b8e-97f1-f302693106d7
# ╠═dcaf2d4a-5ed7-4a20-8067-3bd132ede38d
# ╠═d6d17cbb-e1db-458e-9a42-3b512c242fb1
# ╠═9ae6d271-39ee-4ccb-891f-6544898f8fe7
# ╠═7c31f5b7-500d-4e7c-96a1-19db5ccf8f72
# ╠═13c81d30-da5f-4e6b-a294-567392996a9a
# ╠═f1ce2a50-b769-4332-8c1d-cf11b3e08293
# ╠═72c20cb6-da93-427b-a38c-e7ff3c9fab3e
# ╠═7f64e457-50d0-491c-a207-fa79b5fb4c3f
# ╠═d62a0bed-29ba-49e1-ac25-90dad9c3a574
# ╟─43acbce2-d2cd-428e-a5da-3d28af05e4be
# ╠═d83a5d22-a5c8-4e39-8714-d16edd4cfa09
# ╟─b398f7e6-1d5a-4249-a4fd-771a6616ec6c
# ╠═b21dedc7-23a2-4e79-84fc-943dd3053fab
# ╠═718f6f4a-f337-4cb3-a9f1-e90a32411d8e
# ╠═b0cb4f2c-db8f-4b48-acb4-3b599a5144c5
# ╠═afd0c8c3-b0af-4855-9d13-af0a2e68372d
# ╠═15c45167-4b0a-4630-af0c-20328f8c7835
# ╠═032120c8-ae85-479c-897a-579d7200a943
# ╠═6a8e2e1c-ca66-4f56-a912-411e6ab87c4f
# ╠═6437b9bd-2936-47d8-a1dd-987d68c00d00
# ╠═8e01e846-b392-4610-8be1-e15485a74eaf
# ╠═0a4a689d-5a4e-4d5e-a278-beb137a80ac6
# ╠═a2f9b403-8ad7-4e6a-8e47-9b3bc0f4f73c
# ╟─c5b7f19b-1d06-4c30-b9d6-700e6d8cb95b
# ╟─5ffe88cd-6e98-4705-b427-51c1bbca3ea6
# ╠═b4f5295a-71a1-45a1-b840-465b97dfa35f
# ╠═77ec8655-ce23-4156-8923-517137d91535
# ╠═0a3257ba-e9f8-4a39-a730-9273c582ee8b
# ╠═85813563-d7c2-4e63-83bb-8aa9895e10e6
# ╠═a141eaaf-1cef-47d0-b005-edea009c7b9d
# ╠═a36438b3-e1fc-41d2-9e1d-5a35f8d5bc37
# ╠═02ba9156-7b3a-4b82-a10f-af98273c1401
# ╟─b2d2446b-691a-4575-9650-59a5bb5f9424
# ╠═78bcb294-fb84-4b4d-a97c-4e9928d48c8b
# ╠═fe74029a-f5ac-48ec-944a-643339767a06
# ╠═38ca5fa7-d0e2-42fb-b5ac-974daa4c3cef
# ╟─f434ec9b-f21f-4b13-a2b3-0d1fb3249e1c
# ╠═c28b635b-8595-4afd-9b10-d48a69075ae4
# ╠═0ef61758-ac55-45dd-aaaa-776fdd254009
# ╠═d3a303c2-3b95-4b4b-b07e-26650f7e984d
# ╠═14cbe708-d673-4f76-93d9-855286429db0
# ╠═5a9e906b-1e3a-4bc1-b7f1-8ab4ca607169
# ╟─eb8159ae-9e94-4a5f-9264-01f0ed72a0ce
# ╠═113c916f-a534-416b-a601-b9484de3225f
# ╠═014ec4b5-1430-4cdb-8db9-e377fe1cda22
# ╠═7a7fdd35-0c54-44f1-b248-c1da3b846a2d
# ╟─05b2f5c1-cecc-4815-ad4c-87bce0b103ca
# ╠═e1f4ea2c-9205-45f7-99a7-6257bd7c6155
# ╠═98a6c543-a3d7-4af0-b2a3-569d3236e7fa
# ╠═0341584f-6ece-4b46-b116-628ff80da05e
# ╠═0330c4cf-ac86-45f3-8d77-1cedb6fcaf5d
# ╠═c5f31690-2814-4280-9d5e-d8ebbc0066a3
# ╠═8a4c2cf4-dffb-4487-93d1-ae3cd32eb4a0
# ╠═4d8f459b-3c54-4a9e-83e0-1f6fafee5461
# ╠═f94664c4-c237-4cf0-bd8a-2145ecd4deaa
# ╠═7d155360-6d3f-43c2-829c-fb0990f963af
# ╠═0edff351-2fc8-4759-b2ad-fb5c447119d2
# ╠═29e0cc0b-50a0-43b6-a41e-681041b02fe1
# ╠═f5a96665-ee82-4aec-8db8-59ec603276be
# ╠═5893af83-2924-4024-9eda-ba0a9dc1e326
# ╠═5ca71a2a-b7c5-494a-b7e4-25dc4b0a11fa
# ╠═92977747-cbc3-41e5-ba86-a8f1bb547a4c
# ╠═8b9e2b3b-4654-40bd-9304-2ac8f520a2b7
# ╠═46662d36-c690-4bb4-998a-6d6ac9b33a51
# ╠═89ca9824-0441-42e6-aeaf-04bf26600474
# ╠═49ec27d1-72ec-4e50-b38e-bef8941e5522
# ╠═2a24a278-6b7c-439b-b0b6-4fa57b6d98c0
# ╠═2dd38b7f-1310-460e-996d-61f104dbfa7d
# ╠═712fd1de-8d5b-4435-89f6-ef5caf16dc07
# ╠═fb2d2b03-f23a-4b7e-a82d-2d0bb7d279e9
# ╟─f4bde725-a4c4-4822-b4db-cd66a21e9944
# ╠═84d5071e-2b91-4341-8839-0352172afb7d
# ╠═1e01d43a-01a0-46eb-bc80-5c00d7b6c135
# ╠═e9537736-ebd3-40a6-9a5f-9b10e91591cb
# ╠═cf5175fe-6e65-42e3-8f25-5a99ca86936d
# ╠═64945427-7fbf-441b-80e4-a6dfbe9af463
# ╠═48e47bea-64cb-4e97-97dd-f37761fea418
# ╟─ec1ec66a-ea21-47d6-9c1a-92ea11629e7d
# ╠═fc9a465d-bdea-46fe-8427-17aa8dfa9120
# ╠═525285e8-065a-4d31-9b2c-a4bedeb9d8b4
# ╟─2102c883-4c2f-461b-bfea-5421c9bfcae8
# ╠═41441746-c7d6-4857-8394-6bc72f43bffb
# ╠═9657f65d-e46f-48e3-8d68-0c131fc303c2
# ╠═ebd59160-9185-4837-bec6-cdd4c4a9acc3
# ╠═847d06b7-826c-4aea-9074-69182ec78871
# ╠═032ecfce-4068-423e-ad16-dc007881af26
# ╠═f013daac-f334-400e-b6f2-d7ebc95d02b4
# ╠═466451e1-bc3f-401e-a2fc-7b39a77732a6
# ╠═02f86f41-fb50-4a68-bb7a-38d333f168c2
# ╠═6d5adffb-61ee-4ea4-871f-97acd6d273ff
# ╠═437c661b-4757-45b9-bc06-73fd720277de
# ╟─ce26d829-a7de-4194-96ef-9a81732db012
# ╠═9603700b-cd87-4873-b452-0fd0a9395c76
# ╠═86d11ad1-4842-4bdf-9e46-92ef48c3d9ef
# ╠═5a15f415-2959-4b80-ba2d-bf3edaf1f193
# ╠═6f386ffe-d3ec-40a9-80e7-30c8e4625fb5
# ╠═ab0b7723-6c28-4616-af5f-1e67b62fb03a
# ╠═6276c42a-af0e-4277-8dc3-746f7466c010
# ╠═b7433a36-3b91-4dcc-9cc8-bd2ea996f0b5
# ╟─d851527a-d303-4870-b4a4-b393b138d2c2
# ╠═bd574d52-e848-4a5a-a3b2-6b5e2264ceb5
# ╠═9813645e-5070-4be6-afe3-66ced0456c22
# ╠═9db85a08-3b02-4e12-ac20-d5e6e10addcb
# ╠═355c0db5-ddfc-4af2-8902-1bcf0cacfb97
# ╠═33a9f9ee-5e0c-4122-8656-f791c242eb65
# ╠═3e5074ba-9b55-417f-99b8-b1ff3796c969
# ╠═7d2fe83e-f691-43a0-bd64-4b6ddafb7f8d
# ╠═6900f9dc-1655-458a-8592-cb25c4319b92
# ╠═30f934d3-9ece-43df-9f12-bbe2805a4120
# ╠═5703fed8-0c25-4a94-a70a-626f90817cd0
# ╠═0b66c477-02be-44f8-ad85-a44824c3d24f
# ╠═d32932e7-a200-4833-962c-aa1de136598d
# ╠═5f555381-cf5c-4122-957f-f01f5dca8cf1
# ╠═b9838c1d-9a89-4529-8c91-60a1f03eb503
# ╠═693010e2-de30-4902-b24e-a5a3fdf15737
# ╠═6cb35f5f-20dd-4c44-9843-3687d847882d
# ╟─76e9e262-0599-4e9f-9a49-1a223602cfec
# ╠═99f1f97b-d6cd-4d7b-a41f-73ae9c1786ce
# ╠═57f0cdb1-b4d0-45c3-97a1-59f42c369df9
# ╠═14f0ed67-7a2c-4ed1-9630-163d95de5bae
# ╠═818fab0d-f4ae-41cd-a00f-874e3ef8aa54
# ╠═63e58114-c900-48b6-a271-9a34199add6b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
