### A Pluto.jl notebook ###
# v0.19.23

using Markdown
using InteractiveUtils

# ╔═╡ 6f3a40e7-0e92-48d4-be00-800f85764bf8
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

# ╔═╡ 10fd5edc-7e26-4427-8438-195d558a9a39
struct Point2D
x::Float32
y::Float32
end

# ╔═╡ 61bc9a74-222c-4331-852f-080cf18e1c26
p = Point2D(3, 4)

# ╔═╡ dcf67cbd-a8c2-47a1-b9f4-77b3798c0188
p.x, p.y

# ╔═╡ b0ab69f9-c1f0-4d2b-815c-3fb7c26e5641
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

# ╔═╡ 426619f5-b41f-452b-8765-6da26044dcb0
md"""
### Ex4. 用结构体重写Ex2.
在建模过程中， 我们对原始数据施加了某个变换， 当新的样本来临时， 我们仍需要进行同样的变换才能用于模型的预测。 这时候， 我们需要将变换保存起来， 在后续碰到新的数据时， 再使用它去做变换。 这意味着， 我们需要存储变换过程中使用到的值。 为了实现这一点， 我们用一个结构体表示一个变换。

下面先定义最小-最大变换结构体。

"""

# ╔═╡ 8d46de0f-3b6c-4ab9-a33f-e18d89892737
mutable struct MinMax
	dn
	up
end

# ╔═╡ f9d90909-4739-4992-9494-ae1539769637
md"""
有了结构体之后， 相当于我们有了一个抽象的变换。 当我们给定一个向量去“训练”后， 我们就可以用这个变换去变换数据了。
"""

# ╔═╡ 3858e546-b646-4a40-961b-2638c9a05cb3
function fit!(t::MinMax, v)
	t.dn = min(v...)
	t.up = max(v...)
end

# ╔═╡ b22d2407-c8b4-488b-b841-cffd6978a6a5
T1 = MinMax(0,0)

# ╔═╡ 1d74a077-3ba5-4efb-8162-c7f1994ac785
fit!(T1, [4,5,6,7,10])

# ╔═╡ 04f6ac81-1de5-458e-9711-326cbacf248e
T1

# ╔═╡ 7351c2b6-2bf1-4806-b4fd-216b7f80e793
function transform(T::MinMax, v)
	(v .- T.dn) ./ (T.up - T.dn)
end

# ╔═╡ cb7bc8d0-bf32-4ff3-bc20-ff8bd3ed5f67
transform(T1, [4,5,6,7,10])

# ╔═╡ 175ef8d4-bc75-4888-90a1-34ff8cbb1ec5
md"""
当有新的数据需要转换时
"""

# ╔═╡ 325eb248-7397-42e2-949b-831bb58f88bf
transform(T1, [8,12])

# ╔═╡ 899783d1-dad7-41cc-9188-2bf9f039eacd
md"""
有时候， 可能还需要逆变换， 比如知道变换后的值是 0.7， 变换之前是多少？
"""

# ╔═╡ efc1e6b3-a889-48d5-84f8-6155dd4f4e56
function inverse_transform(t::MinMax, v)
	v .* (t.up - t.dn) + t.dn
end

# ╔═╡ 44382dc1-859b-412f-b267-96720c813053
inverse_transform(T1, 0.166667)

# ╔═╡ 28bd063f-0249-45e7-9e07-5d966a85e185
md"""
## 阅读作业
[DataFrame.jl](https://dataframes.juliadata.org/stable/)
"""

# ╔═╡ Cell order:
# ╠═6f3a40e7-0e92-48d4-be00-800f85764bf8
# ╠═10fd5edc-7e26-4427-8438-195d558a9a39
# ╠═61bc9a74-222c-4331-852f-080cf18e1c26
# ╠═dcf67cbd-a8c2-47a1-b9f4-77b3798c0188
# ╠═b0ab69f9-c1f0-4d2b-815c-3fb7c26e5641
# ╠═426619f5-b41f-452b-8765-6da26044dcb0
# ╠═8d46de0f-3b6c-4ab9-a33f-e18d89892737
# ╠═f9d90909-4739-4992-9494-ae1539769637
# ╠═3858e546-b646-4a40-961b-2638c9a05cb3
# ╠═b22d2407-c8b4-488b-b841-cffd6978a6a5
# ╠═1d74a077-3ba5-4efb-8162-c7f1994ac785
# ╠═04f6ac81-1de5-458e-9711-326cbacf248e
# ╠═7351c2b6-2bf1-4806-b4fd-216b7f80e793
# ╠═cb7bc8d0-bf32-4ff3-bc20-ff8bd3ed5f67
# ╠═175ef8d4-bc75-4888-90a1-34ff8cbb1ec5
# ╠═325eb248-7397-42e2-949b-831bb58f88bf
# ╠═899783d1-dad7-41cc-9188-2bf9f039eacd
# ╠═efc1e6b3-a889-48d5-84f8-6155dd4f4e56
# ╠═44382dc1-859b-412f-b267-96720c813053
# ╠═28bd063f-0249-45e7-9e07-5d966a85e185
