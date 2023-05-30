### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 89f67dc0-fc96-11ed-2b61-4bc33f970b6c
 using SuiteSparseGraphBLAS

# ╔═╡ 6de700e7-8fce-4577-a819-a200d8176118
using Graphs

# ╔═╡ 1d48724b-bce2-4089-aea8-268486e38395
using GraphBLASInterface

# ╔═╡ f71de2a4-2f85-47bc-bcab-7fa96f6db118
using GraphPlot

# ╔═╡ b21ad582-2b62-4dde-ab35-691210544b0f
using PlutoUI

# ╔═╡ 041b39c1-cd74-4619-bbcb-3863af866dc9
using SuiteSparseGraphBLAS: pair

# ╔═╡ d0b1134e-16c0-4748-8034-869b2a744451
using Colors

# ╔═╡ c8376756-bd65-4362-ba6e-a6b54ba313a1
TableOfContents(title = "目录", aside = false)

# ╔═╡ 6d51f1e7-f3ca-4b11-830b-d524aba4986f
md"""
下面简单构建一个图， 然后统计图中有多少个三角形。 这个例子的代码来自官网， 但加入一些自己的解读。
"""

# ╔═╡ b9e412af-2c8f-4431-8299-33448c096e60
s = [1,1,2,2,3,4,4,5,6,7,7,7]; t= [2,4,5,7,6,1,3,6,3,3,4,5];

# ╔═╡ b1d7229f-307c-4d6e-aa41-b722a8fcca29
g = SimpleGraph(7)

# ╔═╡ fd14fb80-de54-4b16-85ac-5a2f453e1540
[add_edge!(g, f, d) for (f, d) in zip(s,t)]

# ╔═╡ ca17f5c4-c62e-47e9-a529-0d54321feee3
md"""
## 统计图中的三角形数量
为了表示一个三角形， 可以使用一个三元组（i,j,k）， 不失一般性， 假定（i<j<k）， 元组中每一个元素分别代表三角形的一个顶点。 比如三角形（2,5,7）。 统计三角形数量的问题， 就变成了统计满足条件的元组的数量的问题了。 

那么， 如何统计这种元组呢？ 简单来说， 我们要看如何构建三角形。 简单来说， 假如要构建， 
"""

# ╔═╡ 94ccbccb-28c3-4b0e-b6f5-36b0817d6158
gplot(g, nodelabel= 1:nv(g))

# ╔═╡ 99a2f49d-5e63-4e90-8814-53b85ec9ea83
A = GBMatrix(s, t, [1:12...])

# ╔═╡ ec4b1264-e282-481b-98c2-bc32d12d7a59
md"""
上面构建的图矩阵A是非对称的， 因为每一条边只写了一次。 所以下面的代码是构建一个对称图的代码。
"""

# ╔═╡ 62d2afb1-932b-4fe1-be42-3bbe9e024c07
M = eadd(A, A', +)

# ╔═╡ 04e740cc-ba05-4f1c-a1ed-2b2917ddf211
*(M, M, (+, pair); mask=M)

# ╔═╡ 6d7683be-d102-4f38-9c0d-44abe9570a0e
function cohen(A)
         U = select(triu, A)
         L = select(tril, A)
         return reduce(+, *(L, U, (+, pair); mask=U)) 
end

# ╔═╡ e9fd2f50-ca00-4033-b61a-b074c0eb6aac
cohen(M)

# ╔═╡ 1446eab5-b09b-4083-9e3e-3c09c122f0fc
md"""
上面的函数中， U， L分别表示图矩阵的上、下三角阵。 *(L, U, (+, pair) 实现的是
$\sum(pair(a_{ik}, a_{kj}))$, 表示从节点i到节点j之间的边的条数的统计。 上面的pair中， k的取值如果大于i， a_{ik}都是0， 所以pair(a_{ik}, a_{kj})都等于0. 所以统计的是第i个节点，通过第i个节点之前的节点k到达节点j的边的条数。 最后， 因为有mask=A， 相当于统计在A中的边， aij != 0。

如果不加任何限制， 假定一个三角形有三个点： i、k、j。 则这个三角形将被统计6次。
"""

# ╔═╡ 83acdbad-1202-4214-8102-eedcf8f69886


# ╔═╡ 3b31aeef-c04b-4b02-9d9e-a23926a4549c
function cohen1(A)
         
         return reduce(+, *(A, A, (+, pair); mask=A)) ÷ 6
end

# ╔═╡ 849a7434-64fb-404b-b365-54f8aa26f178
cohen1(M)

# ╔═╡ 0a2e9719-4b24-41f7-9342-9c4e3a14cd8f
*(M, M, (+, pair); mask=M)

# ╔═╡ 3cf022eb-58fa-4ac9-9af5-acf57a9dd6f3
Matrix(M)

# ╔═╡ 12b73b88-aea5-4f81-9384-b5036fcbb786
cohen1(M)

# ╔═╡ c72d910f-bee0-43a7-8fb2-75b5b8589e94
cohen(M)

# ╔═╡ d86d5ee8-8c80-4a10-a0ed-f59e8cbab668
L = select(tril, M)

# ╔═╡ bffbb30e-022d-41e9-b314-9337922baa20
U = select(triu, M)

# ╔═╡ 1a9067c5-6592-48c5-a25f-e7906cf9c74e
*(L, U, (+, pair); mask=M)

# ╔═╡ e4893912-8938-467f-9770-dad1326db976
*(L, U, (+, pair); mask=M)

# ╔═╡ db1d9946-dcb6-47ef-94c6-a0aa6f09bf99
Matrix(L)

# ╔═╡ 7274b078-48c2-46f7-9bdb-0ed3f1952722
L

# ╔═╡ 99159440-5172-4a74-88b2-541144206607
*(L, L, (+, pair))

# ╔═╡ 6cf612e4-2544-4564-9271-eb42ba48da46
*(L, L, (+, pair); mask=L)

# ╔═╡ d16a62a6-61a3-46d9-93ef-f7dfe41ba9f8


# ╔═╡ 3e2ba6fb-6137-4e4b-bda3-5d1c51f7d5ad
sandia(M)

# ╔═╡ c8b9c308-f637-42f2-ab65-f299e12022bf
 function sandia(A)
    L = select(tril, A)
    return reduce(+, *(L, L, (+, pair); mask=L))
end

# ╔═╡ 1e48598d-c549-4a3d-a853-21078cac6a97
 function sandia(A)
         L = select(tril, A)
         return reduce(+, *(L, L, (+, pair); mask=L))
       end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
GraphBLASInterface = "5f047416-9681-11e9-0804-033d9936201f"
GraphPlot = "a2cc645c-3eea-5389-862e-a155d0052231"
Graphs = "86223c79-3864-5bf0-83f7-82e725a168b6"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SuiteSparseGraphBLAS = "c2e53296-7b14-11e9-1210-bddfa8111e1d"

[compat]
Colors = "~0.12.10"
GraphBLASInterface = "~0.2.0"
GraphPlot = "~0.5.2"
Graphs = "~1.8.0"
PlutoUI = "~0.7.51"
SuiteSparseGraphBLAS = "~0.7.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e30f2f4e20f7f186dc36529910beaedc60cfa644"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.16.0"

[[ChangesOfVariables]]
deps = ["LinearAlgebra", "Test"]
git-tree-sha1 = "f84967c4497e0e1955f9a582c232b02847c5f589"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.7"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "bf6570a34c850f99407b494757f5d7ad233a7257"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.5"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[GraphBLASInterface]]
deps = ["Test"]
git-tree-sha1 = "6947b14a5488947abce9daac4a35c42e62addcd4"
uuid = "5f047416-9681-11e9-0804-033d9936201f"
version = "0.2.0"

[[GraphPlot]]
deps = ["ArnoldiMethod", "ColorTypes", "Colors", "Compose", "DelimitedFiles", "Graphs", "LinearAlgebra", "Random", "SparseArrays"]
git-tree-sha1 = "5cd479730a0cb01f880eff119e9803c13f214cab"
uuid = "a2cc645c-3eea-5389-862e-a155d0052231"
version = "0.5.2"

[[Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "1cf1d7dcb4bc32d7b4a5add4232db3750c27ecb4"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.8.0"

[[HyperSparseMatrices]]
deps = ["SparseArrays", "StorageOrders"]
git-tree-sha1 = "da26ff1f6a816f7a29ceb35df584068df517e8d1"
uuid = "c7efdb1c-7caa-4c7d-9b5e-9093f9323c7c"
version = "0.2.0"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "6667aadd1cdee2c6cd068128b3d226ebc4fb0c67"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.9"

[[IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "259e206946c293698122f63e2b513a7c99a244e8"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.1"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[SSGraphBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0ed5031019c83ac7b1d9c747dbd40123b93d5c5a"
uuid = "7ed9a814-9cab-54e9-8e9e-d9e95b4d61b1"
version = "6.2.1+0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "8982b3607a212b070a5e46eea83eb62b4744ae12"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.25"

[[StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StorageOrders]]
git-tree-sha1 = "365181758ec1084fecf147b72206f81a1310c8b7"
uuid = "e9177fbf-8fde-426c-9425-4eed0f22262a"
version = "0.2.0"

[[SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[SuiteSparseGraphBLAS]]
deps = ["ChainRulesCore", "HyperSparseMatrices", "Libdl", "LinearAlgebra", "MacroTools", "Preferences", "Random", "SSGraphBLAS_jll", "Serialization", "SparseArrays", "SpecialFunctions", "StorageOrders", "SuiteSparse"]
git-tree-sha1 = "44960b0cfe6ef592073fba190c7ed169b13f283a"
uuid = "c2e53296-7b14-11e9-1210-bddfa8111e1d"
version = "0.7.2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─89f67dc0-fc96-11ed-2b61-4bc33f970b6c
# ╟─6de700e7-8fce-4577-a819-a200d8176118
# ╟─1d48724b-bce2-4089-aea8-268486e38395
# ╟─f71de2a4-2f85-47bc-bcab-7fa96f6db118
# ╟─b21ad582-2b62-4dde-ab35-691210544b0f
# ╟─c8376756-bd65-4362-ba6e-a6b54ba313a1
# ╟─6d51f1e7-f3ca-4b11-830b-d524aba4986f
# ╠═b9e412af-2c8f-4431-8299-33448c096e60
# ╠═b1d7229f-307c-4d6e-aa41-b722a8fcca29
# ╠═fd14fb80-de54-4b16-85ac-5a2f453e1540
# ╠═ca17f5c4-c62e-47e9-a529-0d54321feee3
# ╠═94ccbccb-28c3-4b0e-b6f5-36b0817d6158
# ╠═04e740cc-ba05-4f1c-a1ed-2b2917ddf211
# ╠═99a2f49d-5e63-4e90-8814-53b85ec9ea83
# ╟─ec4b1264-e282-481b-98c2-bc32d12d7a59
# ╠═62d2afb1-932b-4fe1-be42-3bbe9e024c07
# ╠═6d7683be-d102-4f38-9c0d-44abe9570a0e
# ╠═e9fd2f50-ca00-4033-b61a-b074c0eb6aac
# ╠═1a9067c5-6592-48c5-a25f-e7906cf9c74e
# ╠═1446eab5-b09b-4083-9e3e-3c09c122f0fc
# ╠═83acdbad-1202-4214-8102-eedcf8f69886
# ╠═3b31aeef-c04b-4b02-9d9e-a23926a4549c
# ╠═849a7434-64fb-404b-b365-54f8aa26f178
# ╠═0a2e9719-4b24-41f7-9342-9c4e3a14cd8f
# ╠═3cf022eb-58fa-4ac9-9af5-acf57a9dd6f3
# ╠═e4893912-8938-467f-9770-dad1326db976
# ╠═c8b9c308-f637-42f2-ab65-f299e12022bf
# ╠═12b73b88-aea5-4f81-9384-b5036fcbb786
# ╠═c72d910f-bee0-43a7-8fb2-75b5b8589e94
# ╠═d86d5ee8-8c80-4a10-a0ed-f59e8cbab668
# ╠═bffbb30e-022d-41e9-b314-9337922baa20
# ╠═db1d9946-dcb6-47ef-94c6-a0aa6f09bf99
# ╠═7274b078-48c2-46f7-9bdb-0ed3f1952722
# ╠═99159440-5172-4a74-88b2-541144206607
# ╠═6cf612e4-2544-4564-9271-eb42ba48da46
# ╠═d16a62a6-61a3-46d9-93ef-f7dfe41ba9f8
# ╠═041b39c1-cd74-4619-bbcb-3863af866dc9
# ╟─d0b1134e-16c0-4748-8034-869b2a744451
# ╠═1e48598d-c549-4a3d-a853-21078cac6a97
# ╠═3e2ba6fb-6137-4e4b-bda3-5d1c51f7d5ad
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
