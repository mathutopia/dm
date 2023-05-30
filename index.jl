### A Pluto.jl notebook ###
# v0.19.23

using Markdown
using InteractiveUtils

# ╔═╡ 813e4902-0fd1-4a5f-acb7-c5b464da6633
md"""
# 数据分析与挖掘：基于Julia
这里是用Julia结合Pluto写的关于数据挖掘的实验、教学材料。
"""

# ╔═╡ 51902669-01a7-4292-b666-db8d4006558c
md"""
# Julia入门
这里会包含一些关于Julia语言的基础知识。
该教程粗略的摘录了 Julia 的基本语法，不熟悉 Julia 的同学可以先粗略地通读该教程，以大致熟悉基本操作。

如果想要了解详细内容可以查阅[官方文档](https://docs.julialang.org/en/v1/)，Julia 中文社区提供了中文版本的[文档](https://docs.juliacn.com/latest/)。 [B 站](https://www.bilibili.com/video/BV1Cb411W7Sr?p=1)有一个简单的视频教程。 这个教程的有部分代码来自该视频作者。 

如果想比较全面的学一下Julia, 可以看看Github上面的这种本[Julia编程基础](https://github.com/hyper0x/JuliaBasics/tree/master/book)

 - [软件安装](https://note.youdao.com/s/AwKm4OfU)
 - [变量与数值类型](./languagebase/vars.html)
 - [字符串](./languagebase/string.html)
 - [容器类型](./languagebase/contains.html)
 - [数组类型](./languagebase/arrays.html)
 - [流程控制与函数编写](./languagebase/controlflow_functions.html)
- [结构体](./languagebase/structs.html)

"""

# ╔═╡ 861ef740-68b4-498f-859c-b53683340974
md"""
## 数据探索
这里是对数据进行探索分析的一些介绍。 主要是利用DataFramesMeta.jl结合DataFrames.jl包做数据的分析。

- [数据探索](./dataexplore/04dataexplore-new.html)
"""

# ╔═╡ f57797b6-e158-4c74-88dc-0a8e254cf615
md"""
## 数据可视化
下面主要介绍Julia中的绘图包。 主要介绍AlgebraOfGraphics.jl（简写为AoG.jl）包的使用。 更多的信息可以参考官方文档[AlgebraOfGraphics](https://aog.makie.org/stable/)。

AoG.jl是以Makie.jl作为绘图的后端， 因此， 有很多的操作需要用到Makie.jl的一些知识。关于Makie.jl可以参考其[官方文档](https://docs.makie.org/stable/)。 此外， makie生态还包含了大量的内容， 如果想深入了解用Makie作图、了解用Makie可以做哪些酷炫的事情， 可以访问[Makie家族](https://github.com/MakieOrg)的项目主页， 了解不同的项目在干什么。

 - [AlgebraOfGraphics画图基础](./datavisual/05dataanasisandvisual.html)
 - [Makie介绍](./datavisual/makieintro.html)
 - [Plots介绍]((./datavisual/Plotsintro.html))
 - [Gadfly](./datavisual/gadfly.html)
"""

# ╔═╡ 6061ace5-8e44-433e-98b9-f6b677d38442
md"""
## 聚类分析

- [kmeans聚类](./clustering/01kmeans.html)
- [Clustering包](./clustering/02clustering.html)



"""

# ╔═╡ a3c47663-49c6-490b-ae20-9b85c7126342
md"""
## 机器学习MLJ

### 1. [数据类型与转换](./mlj/mljpre.html)

"""

# ╔═╡ Cell order:
# ╟─813e4902-0fd1-4a5f-acb7-c5b464da6633
# ╟─51902669-01a7-4292-b666-db8d4006558c
# ╟─861ef740-68b4-498f-859c-b53683340974
# ╟─f57797b6-e158-4c74-88dc-0a8e254cf615
# ╟─6061ace5-8e44-433e-98b9-f6b677d38442
# ╟─a3c47663-49c6-490b-ae20-9b85c7126342
