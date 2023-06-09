### A Pluto.jl notebook ###
# v0.19.23

using Markdown
using InteractiveUtils

# ╔═╡ f9fc3795-3fbd-4939-b672-9824320d5ec1
md"""
## 数组
数组是科学计算中使用非常频繁的一种数据结构。 最常使用的有一维数组（向量），二维数据（矩阵）。与元组对比，数据具有如下特点 ：1）元素是可变的； 2）数组中所有元素都具有相同类型； 3）数组具有维度；

数组的类型是Array{T,N}， 其中T表示数组元素的类型， N表示数组的维度。 一维数组（向量）也可以表示为Vector{T}, 二维数据可表示为： Matrix{T}
"""

# ╔═╡ 4ef4f405-afef-452b-b059-cdf0c4f7fe76
md"""
### 数组的构造
通常情况下， 尤其是在REPL中哦， 用中括号[]构造数据。 用空格、逗号、分号都可以分隔元素， 但含义各不相同。 通常， 逗号分隔的元素会被排列成一列； 空格分隔的元素会被排列成一行， 而分号会起到拆解拼接的作用。
"""

# ╔═╡ 8b159cef-0649-4fc9-9ed5-49a673342342
# 空格分隔的元素被排成了一行， 请注意返回结果是一个一行的矩阵， Julia中没有行向量。
[1 2 3]

# ╔═╡ a8e1c223-80ba-426e-89c8-d424430db580
# 逗号排成一列， 结果是向量。
 [1, 2, 3]

# ╔═╡ f8bfa7c3-c7bd-43da-a056-0c41aa4bbc24
# 分号构建的也是列向量
[1;2;3]

# ╔═╡ 5601318e-5773-45c9-85d8-6449c6af7ffc
# 分号会将前面的的元素拆解， 但只会拆解一层
[[1, 2]; [3,  [4, 5]];]

# ╔═╡ af31da4d-726c-47d8-a405-05ae09ef0cb8
# 我们说数组的元素类型要相同， 这里一个整数， 一个字符， 很明显类型不同， 但Julia也认可， 原因是默认会做类型提升， 提升到Any类型（也就是啥类型都可以）。 
typeof([1, 'a'])

# ╔═╡ b51e4091-0d1a-4791-98c5-4cd1b37707fc
ma = [1 2; 3 4]

# ╔═╡ 38b1b84d-b225-4120-890b-bf0d35ee2137
typeof(ma)

# ╔═╡ c0de63b8-6672-4a18-9821-6353b2d37fe5
md"""
有时候， 我们需要构造大量的数据， 用上面的方法是不行的。 这时可以使用数组的构造函数。 类型构造类似函数调用， 就是把类型名当函数名， 把数据当调用函数的参数。

比如， 构造一个Int64的向量， 可以用`Array{Int64, 1}()`, 在构造的时候， 我们可以指定初始值， 也可以指定元素的个数， 比如 `Vector{Float32}(undef, 100)` 就是构造一个长度是100的未初始化的元素类型是Float32的向量（用`@doc Vector `可以查看帮助文档）。 对于向量来说， 还可以用  **类型[]**的方式构造某种类型的向量, 但不能同时指定长度。 
"""

# ╔═╡ ce144c83-ffb5-431e-896b-c6ece4e3f44e
Array{Int64, 1}()

# ╔═╡ 2d5e5ef1-201a-4c68-89f7-a94948fcc6e1
ty = Int32[]

# ╔═╡ 61677a67-d3c7-4e87-86ad-510cc945c3a0
Vector{Float32}(undef, 100)

# ╔═╡ 2f30b909-2982-4803-8660-4316248aa535
md"""
**一些其他构造方法**
- 特殊数组的构造。 比如全是1或0的数组， ones(m, n)(构造m*n的全1矩阵)， zeros(m, n, k)构造全是0的三维数组。 
- 根据已有的数据去构造。 已有一个数组A， 要构造一个跟A的结构一样的（维度，长度都一样）数组， 可用similar函数。 如similar（A）构造一个数据类型和维度跟A完全相同的未初始化数组。
- rand: 可以通过给定维度长度构造（0,1）间的随机数数组， 例如：rand(m, n)构造m*n的随机矩阵。-
- randn: 可以通过给定维度长度构造符合正态分布的随机数数组
"""

# ╔═╡ d005e5b5-e5b2-466e-8e82-91111c0b75e1
ones(3,4)

# ╔═╡ aeaf899f-05cc-4b16-8aa4-0fa6ca99a09c
rand(3,4)

# ╔═╡ d5eac245-8317-4eef-82fa-1aa495fde0c5
let
A = rand(3,4 ); 
similar(A)
end

# ╔═╡ 4bd65a95-145b-419c-87bb-2ee2e652e0ab
rand(3,4 )

# ╔═╡ fd1579e2-0102-4ed0-99b3-97adb565bacd
rand(3,4)

# ╔═╡ b98f0770-cc63-4f80-b871-27454a715d1e
md"""
有时候， 我们可能需要构造等差数列， 这可以方便的使用冒号运算构造, 基本语法是：` start:step:stop`，表示构造从start开始， 步长是step，到stop结束的集合。可以不指定步长（step）， 这时默认步长为1。 只是， 这种情况下，构造的并非向量， 需要使用`collect`函数， 将构造的所有元素提取出来， 才能形成一个向量。
"""

# ╔═╡ 33176624-13ed-47e1-9718-fca7f927aeb0
1:2:10, typeof(1:2:10), collect(1:2:10)

# ╔═╡ 14384d7e-01e9-442e-9083-b9d882cc1cfe
typeof(1:2:10)

# ╔═╡ 46765b43-6caf-4493-8639-4e7267441e62
collect(10:-2:1)

# ╔═╡ f80c2080-9e81-48d5-bcef-e1989adba44b
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

# ╔═╡ 758698b1-5fb3-47a7-b6e9-b9e7ba626ed5
@doc findfirst

# ╔═╡ 50f0419c-5292-4217-b539-ce7244f367c6
x0=1:10

# ╔═╡ dc72d140-a3a5-4a3e-96a6-7f2db1350aea
xx = rand(3,4)

# ╔═╡ 3ec7dc98-9ef1-4ce3-aff0-435c4d0a7fe5
xx[1:2,2:3]

# ╔═╡ adc18514-34bd-46a8-abe8-e603822cc16b
size()

# ╔═╡ f6a5812d-3da6-4979-8942-cd80ea027fc9
x0[5]

# ╔═╡ a0b2c9cb-5b60-4c99-bb2f-155701cebddc
x1 = zeros(3,4,5)

# ╔═╡ 58ff2991-7e33-43d7-afca-f12386434886
x2 = ones(3,1,1)

# ╔═╡ af86ea96-6343-4505-a82d-230e5d6754fb
tmp = rand(2,3,4)

# ╔═╡ 1812aeaa-3b50-436c-a636-597c61af7bff
length(tmp), size(tmp), size(tmp, 1)

# ╔═╡ 4d425a03-3356-4616-a915-ca2871affe3d
md"""
下面这个例子显示了数组的存储方式和编号特点。从中可以看出， Julia中的数组是按列存储。对于三维数组，可以想象一本书， 比如一个m$\times$n$\times$k的三维数组A，可以想象为一本有k页的书， 每一页都是m行，n列。 这本书按照从上到下从左到右的方向读。 这样， A[:,:,k]表示这本书的第k页， 它应该是m$\times$n的矩阵。
"""

# ╔═╡ b41c3d17-1127-46f1-a11d-9a86ae280ac6
mx = reshape(1:24, 2,3,4)

# ╔═╡ 9ffdf93f-5ff2-42fe-a3a3-a201ceaf3371
findfirst(iseven, mx)

# ╔═╡ 00c63544-b308-44a3-bcc7-3846a431cd64
md"""
### 数组推导
数组推导是构建数组的一个常见形式。与python类似，Julia也提供了数组推导式, 通用的格式如下：
- [f(e) for e in colletion if condition]。 这是遍历collection里面的元素， 当满足条件condition时就进行某种操作f， 最后形成一个数组。 e in colletion 也可以写成 e = colletion， if condition可以省略, 下同。
- [f(x,y) for x in c1, y in c2 if condition]。 这种情况下， x,y分别从两个集合c1,c2取值，如果没有if条件，结果是一个矩阵， 矩阵第i,j位置上的元素是f(x[i],y[j])， 由于Julia中矩阵按列存储， 所以会先计算出第1列，再第二列，依次类推； 如果有if条件， 结果是向量， 相当于先计算一个矩阵，再过滤掉不满足条件的元素。  
**注意：**如果外侧不是用[ ]包裹， 那就不是数组推导。 比如， 用（）包裹得到的可不是python里面的元组， 而是生成器了。
"""

# ╔═╡ e0fe13ff-87b8-4adc-a6e5-83ece001fd4d
[x + y for x in [1,2,3] , y in [4,5,6,7] if isodd(x)]

# ╔═╡ f75a97da-2e55-4a7e-aa61-7599e46d0d4f
[x + y for x in [1,2,3] , y in [4,5,6,7] ]

# ╔═╡ 883a2bf2-5a82-418d-baf8-4e424bfcfdcd
[e^2 for e in 1:10], [e^2 for e in 1:10 if iseven(e)]

# ╔═╡ 54715b76-91dd-4700-9031-863c60a39852
[x + y for x in 1:3, y = 4:6], [x + y for x in 1:3, y = 4:6 if x + y > 0]

# ╔═╡ 1c0a09d8-ed03-4c0a-97b1-d405fc1d1b22
[x + y + z for x in 1:2, y in 3:5, z in 6:9]

# ╔═╡ 83c1d5ae-e4fd-4910-b769-0a25e6640038
(x + y for x in 1:10, y = [1,2])

# ╔═╡ e7e0a230-c8e3-4371-90e0-30164289fabf
## 范围

# ╔═╡ 00514765-b06a-4996-b25b-cc09e6f7aa7e
typeof(1:10)

# ╔═╡ Cell order:
# ╠═f9fc3795-3fbd-4939-b672-9824320d5ec1
# ╠═4ef4f405-afef-452b-b059-cdf0c4f7fe76
# ╠═8b159cef-0649-4fc9-9ed5-49a673342342
# ╠═a8e1c223-80ba-426e-89c8-d424430db580
# ╠═f8bfa7c3-c7bd-43da-a056-0c41aa4bbc24
# ╠═5601318e-5773-45c9-85d8-6449c6af7ffc
# ╠═af31da4d-726c-47d8-a405-05ae09ef0cb8
# ╠═b51e4091-0d1a-4791-98c5-4cd1b37707fc
# ╠═38b1b84d-b225-4120-890b-bf0d35ee2137
# ╠═c0de63b8-6672-4a18-9821-6353b2d37fe5
# ╠═ce144c83-ffb5-431e-896b-c6ece4e3f44e
# ╠═2d5e5ef1-201a-4c68-89f7-a94948fcc6e1
# ╠═61677a67-d3c7-4e87-86ad-510cc945c3a0
# ╠═2f30b909-2982-4803-8660-4316248aa535
# ╠═d005e5b5-e5b2-466e-8e82-91111c0b75e1
# ╠═aeaf899f-05cc-4b16-8aa4-0fa6ca99a09c
# ╠═d5eac245-8317-4eef-82fa-1aa495fde0c5
# ╠═4bd65a95-145b-419c-87bb-2ee2e652e0ab
# ╠═fd1579e2-0102-4ed0-99b3-97adb565bacd
# ╠═b98f0770-cc63-4f80-b871-27454a715d1e
# ╠═33176624-13ed-47e1-9718-fca7f927aeb0
# ╠═14384d7e-01e9-442e-9083-b9d882cc1cfe
# ╠═46765b43-6caf-4493-8639-4e7267441e62
# ╠═f80c2080-9e81-48d5-bcef-e1989adba44b
# ╠═758698b1-5fb3-47a7-b6e9-b9e7ba626ed5
# ╠═50f0419c-5292-4217-b539-ce7244f367c6
# ╠═dc72d140-a3a5-4a3e-96a6-7f2db1350aea
# ╠═3ec7dc98-9ef1-4ce3-aff0-435c4d0a7fe5
# ╠═adc18514-34bd-46a8-abe8-e603822cc16b
# ╠═f6a5812d-3da6-4979-8942-cd80ea027fc9
# ╠═a0b2c9cb-5b60-4c99-bb2f-155701cebddc
# ╠═58ff2991-7e33-43d7-afca-f12386434886
# ╠═af86ea96-6343-4505-a82d-230e5d6754fb
# ╠═1812aeaa-3b50-436c-a636-597c61af7bff
# ╠═4d425a03-3356-4616-a915-ca2871affe3d
# ╠═b41c3d17-1127-46f1-a11d-9a86ae280ac6
# ╠═9ffdf93f-5ff2-42fe-a3a3-a201ceaf3371
# ╠═00c63544-b308-44a3-bcc7-3846a431cd64
# ╠═e0fe13ff-87b8-4adc-a6e5-83ece001fd4d
# ╠═f75a97da-2e55-4a7e-aa61-7599e46d0d4f
# ╠═883a2bf2-5a82-418d-baf8-4e424bfcfdcd
# ╠═54715b76-91dd-4700-9031-863c60a39852
# ╠═1c0a09d8-ed03-4c0a-97b1-d405fc1d1b22
# ╠═83c1d5ae-e4fd-4910-b769-0a25e6640038
# ╠═e7e0a230-c8e3-4371-90e0-30164289fabf
# ╠═00514765-b06a-4996-b25b-cc09e6f7aa7e
