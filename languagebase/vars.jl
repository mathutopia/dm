### A Pluto.jl notebook ###
# v0.19.23

using Markdown
using InteractiveUtils

# ╔═╡ 51e56239-552b-43ca-8a36-6f0ea6f9d8be
using PlutoUI

# ╔═╡ 88cc78ee-c228-4769-abdb-2946707c2301
TableOfContents(title = "目录")

# ╔═╡ a882c1f1-bbe8-4ae5-9639-269d8b8e3a05
md"""
# 变量与数值类型

**程序 = 数据结构+算法**， 要学会编程， 你需要知道一些基本的数据结构（类型）以及如果去操作这些数据（算法）。 数据结构可以理解为数据的组织方式。

数据保存在内存中， 为了操作特定的数据， 我们通常需要给数据取一个名字--变量名。
"""

# ╔═╡ c763528b-869d-4e25-9fef-fe30556e8ec9
md"""
## 变量
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

# ╔═╡ da5df308-956e-4310-80e6-2286d14063e4
md"""
你可以把变量看成是**盒子**的名字。 这个盒子（内存中的某个区域）里面可以装各种类型的数据。比如， x = 10， 就可以看成是名叫x的盒子， 里面装的是数字10。 很多语言要求变量名只能是字母数字下划线构成， 在julia中，你可以使用几乎所有可能的符号做变量名。
"""

# ╔═╡ 3727eb83-7421-4d32-b3db-cafd2a5b4816
中国 = 100

# ╔═╡ 9c429008-6edd-43fa-8625-c3fbea8f2c81
中国

# ╔═╡ 5d06ed7e-d4ad-4d1b-90ef-3acae715e6d5
美国=80

# ╔═╡ a240c6aa-86f8-4f64-ad4a-dd20b632eb04
中国 - 美国

# ╔═╡ 629fb06d-cb0a-4ffa-8d1c-4a55bba71cce
π = "你好"

# ╔═╡ 46b76b9d-7edb-4163-a892-85d3d1dd6863
⬠ = "五边形"

# ╔═╡ 982351d4-7065-4836-97e3-cd138065076c
π * ⬠

# ╔═╡ ebdd01c8-a5b9-4f29-a924-ac031967be0c
md"""
## 数值类型
数字是我们从小的开始学习的概念， 从最开始的整数到，有理数， 实数， 复数，我们接触了各种数值的概念。 在程序语言中， 数值是通常最简单、最基础的数据类型。有些语言不关注数据的具体类型， 都统一视为“数字”。 但强于科学计算的Julia语言， 有丰富的数值类型， 罗列部分如下：

		- 布尔类型：Bool
		- 有符号整数类型： BigInt、Int8、Int16、Int32、Int64和Int128
		- 无符号整数类型： UInt8、UInt16、UInt32、UInt64和UInt128
		- 浮点数类型： BigFloat、Float16、Float32和Float64
将数值细分为不同的类型是有意义的， 不仅能减少数据的存储空间， 还可以提交数据的计算效率。 当然， 如果你觉得处理这么多数据类型很麻烦， 你也可以不管数据类型。 Julia会自动选择默认的数据类型。 比如， 通常整数会当成Int64的类型（在64位的机器里）， 而带了小数点的有理数会当成Float64类型。

"""

# ╔═╡ 21bc77b9-eeaf-4d2a-ace6-d6aec98e9a4b
md"""
### 获取对象的类型typeof
下面的代码显示整数默认是Int64类型， 实际上， 因为我的电脑是64位， 所以显示是Int64， 如果是32位的机器上，下面的结果会是Int32.
"""

# ╔═╡ 109ba8e7-aeef-49b3-84cb-2dc1082c7f07
typeof(10), typeof(10.5)

# ╔═╡ aaa0b712-e6cd-492c-9ea0-ab2c07549754
md"""
### 正负无穷大与不存在（Inf, NaN）
Inf表示无穷大， NaN*表示不是数（Not a Number）， 参考下面的例子。
"""

# ╔═╡ d673f90f-f0d1-400f-958a-623c17d00ba5
typemax(Int64), typemax(Float64), 1/0, 0 * Inf

# ╔═╡ f0b321cd-0fa1-47c9-983a-35a5d2c1ca80
md"""
## 运算符
对于任何一种数据类型， 你都应该知道一些这些数据类型的**构造方法**和**操作方法**。 通常， 操作方法是各种函数。 下面介绍的很多运算符本质上也是一种函数。 

这里结合数值类型总结一下Julia中的常见操作符，也称运算符（Operator）。 Julia中的运操作符是用于对变量和值执行操作的数学符号， 这些符号通常用来进行算术和逻辑计算。 操作符对其执行操作的变量称为操作数(Operands)。 比如，在表达式
`a + b` 中， a和b就是操作数，而 `+` 就是操作符。 作为入门和基础的应用， 需要我们掌握以下四种运算符： 

- 算术运算符  
- 逻辑运算符  
- 矢量化的点操作符  
- 比较运算符  


可参考这篇[文章](https://www.geeksforgeeks.org/operators-in-julia/)获取更多的细节描述。
"""

# ╔═╡ aea5a22c-9976-4983-b932-0cf56766aff6
md"""
### 算术运算符
算术运算符是一门语言中最常见的， 主要包括 + - * /等。

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

注意， + - 也可以用作一元运算符， 在变量前添加 + ， 不会改变变量值； 添加 - ， 会将变量变相反数。 上面的$\div$在编辑器中可以通过 \div+[TAB] 键输入。 这也是Julia特殊的地方， 它是完全支持Unicode字符的， 所以我们可以使用类似于数学书写的方式去写各种变量。 以后看到类似的数学符号， 他们都是通过相应的latex符号+ TAB键打印出来的。 你也可以通过复制一个符号， 然后用 `? 符号`的方式在REPL中获得其书写方法帮助。 或者使用`@doc 名字`的方式**获得一个名字的帮助文档**。
下面是一些例子：
"""

# ╔═╡ 4db40a79-2b6a-4ca9-8e3f-b285140ae5f6
7 ÷ 3

# ╔═╡ eafe3147-624f-47e7-a7ed-0cc6e7f509a6
@doc ÷

# ╔═╡ 2f43fbeb-9f07-40b8-bdcc-23eb66c81b95
2^3

# ╔═╡ 14e10f91-b51d-41c3-8bef-944237d7e58c
# 定义变量， 你也可以改变这里的定义, 一次给多个变量赋值， 跟Python类似
a, b = 9, 4

# ╔═╡ 1c98d7ec-9f1a-499a-9060-94b72a8df03e
(a + b, a - b, a * b, a / b, a \ b, a \ b == b / a, a ÷ b, a % b, +a, -b)

# ╔═╡ 312f9a1c-e87b-4fbd-882c-788328e343bd
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

# ╔═╡ 0471bf91-5788-4ac4-8b7e-c0a262952cbf
4 ≠ 4

# ╔═╡ eacc9099-addc-4eb2-b8fd-6bea98d36408
a > b, a < b, a == b, a != b, a >= b, a <= b

# ╔═╡ cfa6971e-05b5-4aaa-b661-fa6562fecb99
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

# ╔═╡ b629150d-7192-44a6-ad4e-9c0b89c3dc3f
a, b

# ╔═╡ 0b833df1-0385-4140-be7a-dba3c78de5e8
isodd(a), iseven(b), isodd(a) && isodd(b), isodd(a) || isodd(b), !isodd(a)

# ╔═╡ 0122632d-bfa9-4aa7-a0b8-af4d993910dc
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

# ╔═╡ 20f2d4b4-d78b-4e24-9474-f5b19333c495
ceil(5.6), floor(5.6)

# ╔═╡ 5bd68245-bf74-4f08-9a93-7c892372ea65
convert(Int64,10.0)

# ╔═╡ 39c55b9c-cb0b-4ed0-8216-02ab52c01f12
ceil(4.5)

# ╔═╡ 86522c2d-1258-47a5-a499-c12b57f100a0
floor(4.5)

# ╔═╡ 70f11a60-32bd-4568-ad03-3ad26020953f
md"""
### 矢量化的点操作符
点操作符是Julia中实现向量化运算的关键操作符。在R、Python等语言中， 许多运算默认都是向量化的。 但在Julia中， 情况有所不同。 在Julia中， 只要在一个运算的前面加上一个点， 这个运算就变成了向量化的了。 即这个运算会作用到运算对象的每一个元素上。 
"""

# ╔═╡ 1f90bc20-cadf-4645-9a83-499189778029
v1 = [1,2,3]; v2 = [4,5,6];

# ╔═╡ 289fcca8-8449-4c44-99c1-955df51e878b
v1 .* v2

# ╔═╡ 7b2490fd-cac1-4da7-b8f1-4903cb472533
v1.^2

# ╔═╡ 0c64dab6-5952-497c-94bf-29a215d92789
v1 .* v2

# ╔═╡ 9abd7ef8-4d01-4801-8588-3b35db805d28
md"""
!!! tip "📝 提示" 
	如果是要将一个函数的作用是加到多个元素上， 则是将点放在函数名后。
"""

# ╔═╡ d004b57c-99be-4728-a035-77d6aefb1fbe
sin.(v1)

# ╔═╡ 76d57e71-e8e9-45fd-944b-c975fe2935de
md"""
## 总结

1. Julia的变量名可以取任何的Unicode字符（不要跟系统关键字冲突）
2. 数值类型很丰富， 不过先知道（Bool， Integer, Float）差不多了。
3. 常见的运算符要了解。
4. 点运算是Julia的特色， 非常常见。
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "502a5e5263da26fcd619b7b7033f402a42a81ffc"

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

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "259e206946c293698122f63e2b513a7c99a244e8"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─51e56239-552b-43ca-8a36-6f0ea6f9d8be
# ╟─88cc78ee-c228-4769-abdb-2946707c2301
# ╟─a882c1f1-bbe8-4ae5-9639-269d8b8e3a05
# ╟─c763528b-869d-4e25-9fef-fe30556e8ec9
# ╟─da5df308-956e-4310-80e6-2286d14063e4
# ╠═3727eb83-7421-4d32-b3db-cafd2a5b4816
# ╠═9c429008-6edd-43fa-8625-c3fbea8f2c81
# ╠═5d06ed7e-d4ad-4d1b-90ef-3acae715e6d5
# ╠═a240c6aa-86f8-4f64-ad4a-dd20b632eb04
# ╠═629fb06d-cb0a-4ffa-8d1c-4a55bba71cce
# ╠═46b76b9d-7edb-4163-a892-85d3d1dd6863
# ╠═982351d4-7065-4836-97e3-cd138065076c
# ╟─ebdd01c8-a5b9-4f29-a924-ac031967be0c
# ╟─21bc77b9-eeaf-4d2a-ace6-d6aec98e9a4b
# ╠═109ba8e7-aeef-49b3-84cb-2dc1082c7f07
# ╟─aaa0b712-e6cd-492c-9ea0-ab2c07549754
# ╠═d673f90f-f0d1-400f-958a-623c17d00ba5
# ╟─f0b321cd-0fa1-47c9-983a-35a5d2c1ca80
# ╟─aea5a22c-9976-4983-b932-0cf56766aff6
# ╠═4db40a79-2b6a-4ca9-8e3f-b285140ae5f6
# ╠═eafe3147-624f-47e7-a7ed-0cc6e7f509a6
# ╠═2f43fbeb-9f07-40b8-bdcc-23eb66c81b95
# ╠═14e10f91-b51d-41c3-8bef-944237d7e58c
# ╠═1c98d7ec-9f1a-499a-9060-94b72a8df03e
# ╟─312f9a1c-e87b-4fbd-882c-788328e343bd
# ╠═0471bf91-5788-4ac4-8b7e-c0a262952cbf
# ╠═eacc9099-addc-4eb2-b8fd-6bea98d36408
# ╟─cfa6971e-05b5-4aaa-b661-fa6562fecb99
# ╠═b629150d-7192-44a6-ad4e-9c0b89c3dc3f
# ╠═0b833df1-0385-4140-be7a-dba3c78de5e8
# ╟─0122632d-bfa9-4aa7-a0b8-af4d993910dc
# ╠═20f2d4b4-d78b-4e24-9474-f5b19333c495
# ╠═5bd68245-bf74-4f08-9a93-7c892372ea65
# ╠═39c55b9c-cb0b-4ed0-8216-02ab52c01f12
# ╠═86522c2d-1258-47a5-a499-c12b57f100a0
# ╟─70f11a60-32bd-4568-ad03-3ad26020953f
# ╠═1f90bc20-cadf-4645-9a83-499189778029
# ╠═289fcca8-8449-4c44-99c1-955df51e878b
# ╠═7b2490fd-cac1-4da7-b8f1-4903cb472533
# ╠═0c64dab6-5952-497c-94bf-29a215d92789
# ╟─9abd7ef8-4d01-4801-8588-3b35db805d28
# ╠═d004b57c-99be-4728-a035-77d6aefb1fbe
# ╟─76d57e71-e8e9-45fd-944b-c975fe2935de
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
