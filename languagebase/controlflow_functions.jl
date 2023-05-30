### A Pluto.jl notebook ###
# v0.19.23

using Markdown
using InteractiveUtils

# ╔═╡ 7145f5c2-1564-4631-8672-99fd1d3b53a8
md"""
# 流程控制
流程控制是实现逻辑的重要一环。程序从结构上可以分为顺序结构、分支结构和循环结构三种。默认情况下，程序会顺序执行， 当需要构造分支和循环时， 需要特殊的关键字。在Julia中，有：
1. if elseif else end. 实现分支语句， 注意，Julia中一个代码块需要以end结尾。
2. for i in collection ... end。 实现固定范围的for循环。
3. while condition... end。 实现基于条件的while循环。
4. break， continue， 用于跳出、提前结束循环。
5. let....end。 用于构造一个局部执行环境。
"""

# ╔═╡ 53619d88-5695-4f40-a0df-e6e7e112359b
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

# ╔═╡ 72c26fbb-057a-4a3b-9897-1f6adfa1562c
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

# ╔═╡ cefa3265-5090-4856-be0b-ba1c7d339151
begin
ret = 0
for i in 1:100
	ret = ret + i
end
end

# ╔═╡ b5d69186-7258-40c0-b8fe-6cacf2bf1819
ret

# ╔═╡ d2349140-93fb-4faa-9f3c-e01b0d114a0d
begin
	# While 循环
	i = 0
	while i < 4
	    println(i)
	    i += 1  # i = i + 1
	end
end

# ╔═╡ 03b3fce9-bb42-4982-b4d9-281fc8224dda
# 用 try/catch 处理异常
try
   error("help")
catch e
   println("caught it $e")
end

# ╔═╡ ee6e0a48-4ea6-40d9-b81e-3fff63244cc5
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

# ╔═╡ f4f86f2e-f55b-4d30-bd44-4fe9e4ab6004
ff(x) = 3x^2 + 2x + 1

# ╔═╡ 04e50c32-90da-4a7b-85fb-e8581d6cd907
ff(2)

# ╔═╡ 38683a55-8c14-4c0d-8d3a-be73511cb7d2
md"""

### 函数参数
函数参数有两种类型： 位置参数和关键字参数， 每一种又分可选和必选， 位置参数和关键字参数在定义时用分号(；)分隔。 其中位置参数是通过位置来确定参数的赋值， 因此， 调用函数时， 提供的参数的顺序必须要跟对应的位置参数完全匹配。 关键字参数具有一个参数关键字， 调用的时候需要带着关键字去调用， 这时自然也不需要关注顺序的问题。 下面定义的函数`f`的参数中， `a,b...`是必选位置参数， `m,n,...`是可选位置参数（必选位置参数必须在可选位置参数之前）， 可选的意思是，如果没有给定也没关系（因为有默认值）。 分号之后的`key1, key2, ...`等是关键字参数， 关键字参数也可以提供默认值, 成为可选的关键字参数（否则就是必选的关键字参数， 没有必选要在可选之前的规定）。 注意， 位置参数调用时不能指定参数名， 指定参数名， 必然意味着这个参数是关键字参数。 Julia中函数会根据位置参数及其类型实现多重分派(同一函数名， 根据不同的输入参数实现不同的功能)， 细节请参考相关文档。
```julia
function f(a,b,..., m=x1, n=x2, ...; key1, key2 = xk, ...)
#
end

```
"""

# ╔═╡ 4bc6d8f4-3ede-43a5-96c1-9e67fef3714f
f(x) = 3x^2 + 2x + 1

# ╔═╡ 7da5ed19-977b-4ec8-a51d-cbcc06c1351c
f(2)

# ╔═╡ 28b96703-6d90-4fce-9374-e9e4d0255337
function f1(a,b, m=1, n=2; key1 = 4, key2=10)
#
	a + b + m + n + key1 + key2
end

# ╔═╡ c229ff7e-5698-42b6-8589-2dcc03e2a406
f1(1,2,3,4,key1 = 5, key2 = 6)

# ╔═╡ e93e0e72-cc8a-4887-bc65-c319d05a3d9d
function ftest(x,y=10;a=1,b)
x + y + a + b
end

# ╔═╡ 47a8d86d-40da-4a7d-aa21-b71445c732f0
ftest(1,b=9)

# ╔═╡ b8c24fad-d7e9-4484-bc3f-ad0344efd1c6
f3(x) = sin(2x); f2(x) = cos(2x)

# ╔═╡ 93f902cc-58bb-4017-a7fb-f5c41efc968e
plot([x -> x^2, x -> 2x+1], -2pi, 2pi)

# ╔═╡ 66212afb-e0a6-42c3-a57d-bad01437321f
plot(f, 0, 2pi, legend = false)

# ╔═╡ 9eb53e3b-ebd3-4318-bb71-d681c51f31aa
md"""
### 注意
在Julia中， 有一个关于函数的习惯，**如果一个函数会修改其输入参数，该函数名要以！结尾**。 反过来， 如果发现一个带惊叹号的函数， 那么要知道这个函数会修改输入参数。
"""

# ╔═╡ 785d95bd-726c-4f55-b308-324e06aef988
md"""
## 函数编写练习
### Ex1. 编写一个函数，用于返回一个向量的2范数。
"""

# ╔═╡ cf5ec86d-26d3-49c0-a9fa-6ae8a084ff62
norm(v) = sqrt(sum(v.^2))

# ╔═╡ c4e45816-78d4-4296-b4c8-1f4c426accbd
norm(v1, v2) = norm(v1 .- v2)

# ╔═╡ 21bf336e-4561-4efb-a41c-5984a6ebcd7d
norm(ones(10), 2*ones(10))

# ╔═╡ 96a8d255-24fd-4b40-8f23-ef2576befd72
md"""
### Ex2. 编写一个函数， 用于实现对向量的最小-最大规范化。
在数据分析中， 因为不同的变量可能存在不同的量纲， 导致数据的大小分布情况是不一致的。 为了减少量纲的影响， 通常我们需要将数据转换到相同的尺度， 这称为数据的规范化。  最小-最大规范化是利用向量的最小-最大值将数据转换到给定的区间， 通常为[0,1]。 即
$$z = \frac{x - min_x}{max_x - min_x}$$
"""

# ╔═╡ 0f874cf8-c34f-4f3e-9e9a-edae5dd3b346
function zminmax(v)
	dn = min(v...)
	up = max(v...)

	(v .- dn) ./ (up - dn)
end

# ╔═╡ d7b0f7d0-aec0-4cfc-a6b8-32e141a47f52
zminmax([4,5,6,7,10])

# ╔═╡ f5f63728-4627-4338-9c28-5248a3b116e3
md"""
### Ex3. 编写一个函数， 输入参数是一个表示年龄的整数， 输出结果是年龄代表的类别：老中青三种之一。判断条件是：年龄>60岁为老， [40, 60]为中， <40为青。
"""

# ╔═╡ 5cebf8b6-d44b-4387-a8b2-8f4f017520c4
function getclass(age)
	if age > 60
		return "老"
	elseif age >= 40
		return "中"
	else
		return "青"
	end
end

# ╔═╡ 89b4ceef-dac3-4ea3-a390-cb0c4b29d2e7
getclass(100)

# ╔═╡ Cell order:
# ╠═7145f5c2-1564-4631-8672-99fd1d3b53a8
# ╠═53619d88-5695-4f40-a0df-e6e7e112359b
# ╠═72c26fbb-057a-4a3b-9897-1f6adfa1562c
# ╠═cefa3265-5090-4856-be0b-ba1c7d339151
# ╠═b5d69186-7258-40c0-b8fe-6cacf2bf1819
# ╠═d2349140-93fb-4faa-9f3c-e01b0d114a0d
# ╠═03b3fce9-bb42-4982-b4d9-281fc8224dda
# ╠═ee6e0a48-4ea6-40d9-b81e-3fff63244cc5
# ╠═f4f86f2e-f55b-4d30-bd44-4fe9e4ab6004
# ╠═04e50c32-90da-4a7b-85fb-e8581d6cd907
# ╠═38683a55-8c14-4c0d-8d3a-be73511cb7d2
# ╠═4bc6d8f4-3ede-43a5-96c1-9e67fef3714f
# ╠═7da5ed19-977b-4ec8-a51d-cbcc06c1351c
# ╠═28b96703-6d90-4fce-9374-e9e4d0255337
# ╠═c229ff7e-5698-42b6-8589-2dcc03e2a406
# ╠═e93e0e72-cc8a-4887-bc65-c319d05a3d9d
# ╠═47a8d86d-40da-4a7d-aa21-b71445c732f0
# ╠═b8c24fad-d7e9-4484-bc3f-ad0344efd1c6
# ╠═93f902cc-58bb-4017-a7fb-f5c41efc968e
# ╠═66212afb-e0a6-42c3-a57d-bad01437321f
# ╠═9eb53e3b-ebd3-4318-bb71-d681c51f31aa
# ╠═785d95bd-726c-4f55-b308-324e06aef988
# ╠═cf5ec86d-26d3-49c0-a9fa-6ae8a084ff62
# ╠═c4e45816-78d4-4296-b4c8-1f4c426accbd
# ╠═21bf336e-4561-4efb-a41c-5984a6ebcd7d
# ╠═96a8d255-24fd-4b40-8f23-ef2576befd72
# ╠═0f874cf8-c34f-4f3e-9e9a-edae5dd3b346
# ╠═d7b0f7d0-aec0-4cfc-a6b8-32e141a47f52
# ╠═f5f63728-4627-4338-9c28-5248a3b116e3
# ╠═5cebf8b6-d44b-4387-a8b2-8f4f017520c4
# ╠═89b4ceef-dac3-4ea3-a390-cb0c4b29d2e7
