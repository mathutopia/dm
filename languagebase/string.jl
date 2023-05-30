### A Pluto.jl notebook ###
# v0.19.23

using Markdown
using InteractiveUtils

# ╔═╡ 95bf6dab-60e9-45ab-840d-ce47d9a2c9f0
md"""
## 字符与字符串
Julia支持Unicode编码， 单个的字符用**单引号**包裹。 字符串用**双引号**包裹，  也可以用三联双引号， 通常用于文档中。 字符的类型是Char， 字符串的类型是String。
"""

# ╔═╡ 461b55f1-f20d-4bc4-838d-f0520a54ef46
typeof('a')

# ╔═╡ e585f4f7-80f7-4f78-bc87-fbe29d4ccde0
'中'

# ╔═╡ 8c0946e6-de78-4fc2-be99-b6b9976a7062
typeof("我爱Julia！")

# ╔═╡ 35b9801c-8a83-493d-abff-cd61cf6d1d72
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

# ╔═╡ 3ec030a2-c6c0-467d-9f7f-28fb8c62980e
"good" * "morning"

# ╔═╡ eff2736c-f473-4912-83be-8fa627d3535d
id = "352719200008101112"

# ╔═╡ b41d5c25-8bc7-4f8b-b531-271e1ec08ea7
parse(Int64,id[11:12])

# ╔═╡ 233f74ed-c55a-496c-98da-1db5e2b709ea
str = "我爱julia！"

# ╔═╡ 289f6b1c-60d7-4570-9557-f780c0250444
str[1:2]

# ╔═╡ dcffbf0d-30cf-40dd-9ca0-994784f368eb
sizeof("我")

# ╔═╡ 45184c53-613f-48fc-8fbe-0e0a838bb8a5
str[1:4]

# ╔═╡ 6961f99f-5589-447d-9245-4ad68ae1cfff
sizeof("我爱")

# ╔═╡ 0b12e36f-1c1b-4eb1-8562-de2a54979d6d
length(str)

# ╔═╡ 9896579e-0f6f-4d0c-b24b-e32c41a531f2
sizeof(str)

# ╔═╡ 42145f30-e68f-4d0c-a11b-dbbc5e879db6
str[1:4]

# ╔═╡ 876ccc0f-b8e5-47f9-9d41-580730bbb00e
sizeof(str)

# ╔═╡ 509d0747-55b4-4e03-8898-25fa225ff930
length(str)

# ╔═╡ 7219830b-f3c8-48da-8ab1-7915d2bb23d1
first(str, 2)

# ╔═╡ cbe68e4c-ff0b-4f39-bcce-1bdd4fa8b8b3
contains("JuliaLang is pretty cool!", "Julia")

# ╔═╡ 9af13bd5-515a-43c3-8e6a-49c60b7a8385
md"""
字符串在数据分析中一种常用应用是： 我们读取的数据可能是字符串格式， 需要将其转换为数字。常使用的函数是`parse(type, str)`， 这个函数通常用于类型之间的转换。
"""

# ╔═╡ fa6dec8f-c11f-4600-896f-55515f18c262
parse(Float64, "33222.45")

# ╔═╡ Cell order:
# ╟─95bf6dab-60e9-45ab-840d-ce47d9a2c9f0
# ╠═461b55f1-f20d-4bc4-838d-f0520a54ef46
# ╠═e585f4f7-80f7-4f78-bc87-fbe29d4ccde0
# ╠═8c0946e6-de78-4fc2-be99-b6b9976a7062
# ╟─35b9801c-8a83-493d-abff-cd61cf6d1d72
# ╠═3ec030a2-c6c0-467d-9f7f-28fb8c62980e
# ╠═eff2736c-f473-4912-83be-8fa627d3535d
# ╠═b41d5c25-8bc7-4f8b-b531-271e1ec08ea7
# ╠═233f74ed-c55a-496c-98da-1db5e2b709ea
# ╠═289f6b1c-60d7-4570-9557-f780c0250444
# ╠═dcffbf0d-30cf-40dd-9ca0-994784f368eb
# ╠═45184c53-613f-48fc-8fbe-0e0a838bb8a5
# ╠═6961f99f-5589-447d-9245-4ad68ae1cfff
# ╠═0b12e36f-1c1b-4eb1-8562-de2a54979d6d
# ╠═9896579e-0f6f-4d0c-b24b-e32c41a531f2
# ╠═42145f30-e68f-4d0c-a11b-dbbc5e879db6
# ╠═876ccc0f-b8e5-47f9-9d41-580730bbb00e
# ╠═509d0747-55b4-4e03-8898-25fa225ff930
# ╠═7219830b-f3c8-48da-8ab1-7915d2bb23d1
# ╠═cbe68e4c-ff0b-4f39-bcce-1bdd4fa8b8b3
# ╠═9af13bd5-515a-43c3-8e6a-49c60b7a8385
# ╠═fa6dec8f-c11f-4600-896f-55515f18c262
