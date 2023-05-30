### A Pluto.jl notebook ###
# v0.19.23

using Markdown
using InteractiveUtils

# ╔═╡ 7f890290-ecd8-11ed-052c-d783bc2e8d92
using CSV, DataFrames, MLJ, DataFramesMeta

# ╔═╡ 0915f066-5b6b-4d08-a4cf-60db2bd61657
using PlutoUI

# ╔═╡ dd5ad3f0-e8e3-4b20-9a83-7d887e61ac9d
using MLJDecisionTreeInterface 

# ╔═╡ 738b6c4f-f47f-430f-8abf-fe162d62975a
TableOfContents(title = "目录")

# ╔═╡ 18395cd7-d5fa-4c52-96a1-906f607ba789
trains = CSV.read("../data/trainbx.csv", DataFrame)

# ╔═╡ a7545c27-0354-4cef-b87a-20ed73c64503
train = select(trains, Not(:fraud))

# ╔═╡ 8f1e580d-dac2-4e2f-a3cd-963cc0e3ea4b
y = categorical(trains.fraud)

# ╔═╡ 63ec1152-1cf7-49c1-831d-9adf0faffdba
test = CSV.read("../data/test.csv", DataFrame)

# ╔═╡ eb95d8fc-a303-47a4-b069-21bd8cc26fc6
md"""
# 1 管道建模
## 1. 构建复杂管道
先建立数据预处理的管道， 然后跟不同的模型去拼接形成不同的管道模型。
"""

# ╔═╡ ec2657af-91d6-4859-a2e2-5c3114542e2f
prepipe1 = Pipeline( dropid = x -> select(x, Not([:policy_id])),
	text2class = (x -> coerce(x, Textual => Multiclass)),  
	class2count = (x -> coerce(x, Multiclass => Count)), 
	encoder = ContinuousEncoder()
)

# ╔═╡ a5b13119-8afe-45a3-91de-224ebfe681e5
prepipe2 = Pipeline( dropid = x -> select(x, Not([:policy_id])),
	text2class = (x -> coerce(x, Textual => Multiclass)),  
	#class2count = (x -> coerce(x, Multiclass => Count)), 
	encoder = ContinuousEncoder()
)

# ╔═╡ ee1d4799-b498-4999-99c2-6d99c23760af
md"""
## 2 引入模型， 建立管道模型
"""

# ╔═╡ 1e8c50a8-7df8-4de6-9532-aaf7e4f28ba9
rfm = (@load RandomForestClassifier pkg = DecisionTree)()

# ╔═╡ 396d67c7-ebef-48f3-a872-84ab73f23e79
begin
model1 = prepipe1 |> rfm
model2 = prepipe2 |> rfm

mach1 = machine(model1, train, y)
mach2 = machine(model2, train, y)
MLJ.fit!(mach1)
MLJ.fit!(mach2)
end

# ╔═╡ d6cb9d36-de50-415a-a5d8-080f5822cdb0
pdf.(MLJ.predict(mach1, test), 1)

# ╔═╡ eafeaf7c-fff6-41c2-aea1-81ff47389c53
function submit(fraud, file = "submit.csv", policy_id=test.policy_id)
	subm = DataFrame(policy_id = policy_id,fraud = fraud)
	CSV.write(file, subm)
end

# ╔═╡ 32c7b0a0-468e-4456-b477-5ee10bb06219
submit(pdf.(MLJ.predict(mach1, test), 1), "submit1.csv")

# ╔═╡ ed3b9e31-1dd3-4a24-bdd3-f04056a2d7ac
submit(pdf.(MLJ.predict(mach2, test), 1), "submit2.csv")

# ╔═╡ 9f2a0edb-a0fa-4c47-b5b3-f20525842ac3
md"""
# 学习网络

学习网络是一个计算过程的有向无环图。 图中的节点代表的是数据， 边代表计算过程。 最开始的节点通常是原始数据节点source。 中间的节点都是由开始的节点通过一些函数计算得来。

什么样的计算可以施加在数据节点上？

-  \* and + ， MLJBase.matrix, MLJBase.table, vcat, hcat, mean, median, mode, first, last, as well as broadcasted versions of log, exp, mean, mode and median.

-  Q = node(fun, N), 可以构造一个新的节点Q，其边是通过函数fun计算N得到。 这种形式构造的节点是**静态节点**。

- **动态节点**。动态节点是需要通过训练之后才能使用的节点， 或者说是训练事件的输出。N = node(transform, mach, Xs) |> fit!。 这里的节点N就是训练fit！之后的输出。 不过这种方式看上去是比较麻烦一点。 因此， transform函数被重载了， 当该函数的输入是节点时， 就相当于构造节点了。 transform(mach, X::AbstractNode) = node(transform, mach, X)。 不过， 这里并没有fit!函数的调用， 因此， 构造出的节点在真正能够产生数据前， 需要fit！。所以动态节点， 本质上是绑定一些特别的函数: 
	predict(mach, X::AbsractNode, y::AbstractNode)
	predict_mean(mach, X::AbstractNode, y::AbstractNode)
	predict_median(mach, X::AbstractNode, y::AbstractNode)
	predict_mode(mach, X::AbstractNode, y::AbstractNode)
	transform(mach, X::AbstractNode)
	inverse_transform(mach, X::AbstractNode)

上面提到的动态节点都同时指向了一个机器和若干节点。 但这并非必须的。 事实上， 只要绑定一个机器， 就能让一个节点变成动态的。因为， 机器本身是需要训练的。

总结一下： 一个学习网络是一个有向无环图。 其中节点表示数据， 边表示变换。 A -> B的有向边就表示 A代表的数据通过一个计算变成B代表的数据。 

虽然节点都表示数据。 但可以大致分为原始数据节点（用source构造）， 和计算构造的数据节点。

计算构造的节点分为两类： 第一类是静态节点。 通过 B = node(fun, A) 构造， 表示只有A有值，B就可以通过fun计算得到，无需额外的训练。 第二类是动态节点， 这类节点一般是指向机器和数据节点的特殊操作，如预测、转换等。 这类节点在发挥作用之前需要训练， 也就是其结果输出取决于训练的机器。 **构造动态节点之前必须先构造机器**。

"""

# ╔═╡ 625c5000-ddf3-4d23-bb8c-1b9cc085de67
md"""
构造学习网络可以分为以下步骤：

1. 构造数据节点， source（X）
2. 通过简单运算（+*等等）构造新的静态节点。
3. 通过函数运算构造新的复杂的静态节点。
4. 通过预测、转换（predict， transform）函数指向机器（和数据节点）构造动态节点。

后面三种构造方式可以通过@node实现。
"""

# ╔═╡ bea62f86-a19b-4724-8bba-130a5cdd9b6b
md"""
一个学习网络只是指定了一个数据如何一步一步变形的过程
"""

# ╔═╡ a62389b7-08a5-424a-a199-fe84c8590e6c
md"""
## 构建学习网络模型
下面用学习网络的方式定义一个新的模型。

一个模型就是一个数据结构， 这个结构指定了该模型的超参数。 对于学习网络模型， 其超参数就是各种其他的模型。 因此， 我们先定义一个新的结构。

在定义新的模型结构时， 需要指定我们模型的预测输出， 因为我们要的是概率输出， 所以定义该结构的父类型为ProbabilisticNetworkComposite。

可以通过
```
using MLJBase
NetworkComposite
```
看到所有的可用类型。
"""

# ╔═╡ b9902b25-a9a3-4045-85c2-517e49f35355
md"""
### 指定数据源
"""

# ╔═╡ 7d84340f-3e7f-4998-9aaa-73a83ab98852
begin
Xs = source(train)
ys = source(y)
end

# ╔═╡ 7b6ef60e-332e-4379-b884-7cdd19c92100
Xs

# ╔═╡ 5f8c8c85-48f2-4350-a545-e23dd25bcc54
ys

# ╔═╡ bfb8a6e5-3a61-4865-8d34-046fe060dca6
md"""
### 定义模型结构
"""

# ╔═╡ 2f97c87c-f8ad-4347-9d1c-c57e0d5bcaf6
mutable struct CompositeA <: ProbabilisticNetworkComposite
    preprocessor
    classifier
end

# ╔═╡ fa5d0bd5-5b78-431d-864f-2a3c6879e27d
md"""
### 构建学习网络
构建学习网络就是指出数据是如何从原始数据一步步变成预测变量的。

这里构建学习网络的过程中， 动态节点的构建中使用的机器需要绑定一个模型， 但我们只是绑定到了一个符号（Symbol）， 冒号表示的字符串， 下面的 :preprocessor， :classifier。 那这个符号代表的模型从哪里来？ 在构建图时， 暂时不需要指定， 因为图反映的只是一种关系。 
"""

# ╔═╡ 22bc07dc-5c17-4cf6-a072-a521dcca9b87
begin
machp = machine(:preprocessor, Xs)   
x = MLJ.transform(machp, Xs)
machc = machine(:classifier, x, ys) 
yhat = MLJ.predict(machc, x)
end

# ╔═╡ 761fc141-999d-414c-b30b-9ce4c72cceb6
md"""
### 创建新的模型实例
上面的三个步骤已经实现了模型逻辑的创建。 接下来可以实例化不同的模型， 只需要指定不同的组件就行。
"""

# ╔═╡ a358dff0-242c-40da-bd2b-41fd296da5fb
mymodel = CompositeA(prepipe1, rfm)

# ╔═╡ d9c43d0c-2c3f-4c17-b3fb-3afdeaf87e53
md"""
### 拟合学习网络

"""

# ╔═╡ a3189293-84d4-46b7-893b-3a43e396c9f0
md"""
为了拟合上面的模型， 本质上是要拟合一个学习网络， 我们需要指定学习网络中需要的超参数从哪里来， 这可以通过composite = mymodel去指定超参数来源于哪个模型。
"""

# ╔═╡ 7e0ba9fb-f310-40b9-a268-5102cc0b5ac6
fit!(yhat, composite = mymodel)

# ╔═╡ d7965dc6-0d4a-4756-b03d-d19f51faf76b
md"""
### 运用学习网络
"""

# ╔═╡ 5d3ae4fd-3230-4f94-8752-95fd5aaf2d70
pdf.(yhat(rows = 1:2), 1)

# ╔═╡ 702578f0-f2fb-4677-a86e-c8975f670a9b
md"""
## 构建新的模型
我们上面构建了一个新的模型， 但该模型被用于给学习网络提供参数。 如何构建一个可以训练、评估的新的模型呢？

我们只需要为我们的模型结构指定一个prefit函数, 这个函数定义了一个模型（composite），对应的学习网络及其对外提供的界面。比如predict，表示这个模型对应的学习网络如何用于预测。
"""

# ╔═╡ 16ca0774-756c-4280-9efe-f2e8a276f4b7
trainid, testid = partition(eachindex(y), 0.7, shuffle = true)

# ╔═╡ f7ecb15f-881d-41b1-bb45-b73fca9df226
import MLJBase

# ╔═╡ 55f15d9c-3061-4b65-a2c7-60b22b094b1a
function MLJBase.prefit(composite::CompositeA, verbosity, X, y)

        # the learning network from above:
		X = X[:, 1:30]
        Xs = source(X)
        ys = source(y)
        mach1 = machine(:preprocessor, Xs)
        x = MLJ.transform(mach1, Xs)
        mach2 = machine(:classifier, x, ys)
        yhat = MLJ.predict(mach2, x)

        verbosity > 0 && @info "I'm a noisy fellow!"

        # return "learning network interface":
        return (; predict=yhat)
end

# ╔═╡ 3ff7efcf-196c-4365-a272-9f100c2f5064
composite_a = CompositeA(prepipe1, rfm)

# ╔═╡ 99ba7072-945b-4566-8ab9-94a66e75f7c3
mc = machine(composite_a, train, y) 

# ╔═╡ 581959ea-5787-4138-a189-f7437e89461f
MLJ.fit!(mc, rows = trainid)

# ╔═╡ 9cf400fd-2c29-44c4-af82-9bb300452a21
evaluate!(mc, resampling=CV(),measure = auc )

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
DataFramesMeta = "1313f7d8-7da2-5740-9ea0-a2ca25f37964"
MLJ = "add582a8-e3ab-11e8-2d5e-e98b27df1bc7"
MLJBase = "a7f614a8-145f-11e9-1d2a-a57a1082229d"
MLJDecisionTreeInterface = "c6f25543-311c-4c74-83dc-3ea6d1015661"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CSV = "~0.10.9"
DataFrames = "~1.5.0"
DataFramesMeta = "~0.14.0"
MLJ = "~0.19.1"
MLJBase = "~0.21.11"
MLJDecisionTreeInterface = "~0.4.0"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "4da4f497441d324f798304119d9adaf1dae6dd0e"

[[deps.ARFFFiles]]
deps = ["CategoricalArrays", "Dates", "Parsers", "Tables"]
git-tree-sha1 = "e8c8e0a2be6eb4f56b1672e46004463033daa409"
uuid = "da404889-ca92-49ff-9e8b-0aa6b4d38dc8"
version = "1.4.1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "faa260e4cb5aba097a73fab382dd4b5819d8ec8c"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.4"

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

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "ed28c86cbde3dc3f53cf76643c2e9bc11d56acc7"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.10"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "1568b28f91293458345dabba6a5ea3f183250a61"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.8"

    [deps.CategoricalArrays.extensions]
    CategoricalArraysJSONExt = "JSON"
    CategoricalArraysRecipesBaseExt = "RecipesBase"
    CategoricalArraysSentinelArraysExt = "SentinelArrays"
    CategoricalArraysStructTypesExt = "StructTypes"

    [deps.CategoricalArrays.weakdeps]
    JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SentinelArrays = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
    StructTypes = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"

[[deps.CategoricalDistributions]]
deps = ["CategoricalArrays", "Distributions", "Missings", "OrderedCollections", "Random", "ScientificTypes"]
git-tree-sha1 = "da68989f027dcefa74d44a452c9e36af9730a70d"
uuid = "af321ab8-2d2e-40a6-b165-3d674595d28e"
version = "0.1.10"

    [deps.CategoricalDistributions.extensions]
    UnivariateFiniteDisplayExt = "UnicodePlots"

    [deps.CategoricalDistributions.weakdeps]
    UnicodePlots = "b8865327-cd53-5732-bb35-84acbb429228"

[[deps.Chain]]
git-tree-sha1 = "8c4920235f6c561e401dfe569beb8b924adad003"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.5.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "aa51303df86f8626a962fccb878430cdb0a97eee"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.5.0"

[[deps.DataFramesMeta]]
deps = ["Chain", "DataFrames", "MacroTools", "OrderedCollections", "Reexport"]
git-tree-sha1 = "7f13b2f9fa5fc843a06596f1cc917ed1a3d6740b"
uuid = "1313f7d8-7da2-5740-9ea0-a2ca25f37964"
version = "0.14.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DecisionTree]]
deps = ["AbstractTrees", "DelimitedFiles", "LinearAlgebra", "Random", "ScikitLearnBase", "Statistics"]
git-tree-sha1 = "c6475a3ccad06cb1c2ebc0740c1bb4fe5a0731b7"
uuid = "7806a523-6efd-50cb-b5f6-3fa6f1930dbb"
version = "0.12.3"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "49eba9ad9f7ead780bfb7ee319f962c811c6d3b2"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.8"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "c72970914c8a21b36bbc244e9df0ed1834a0360b"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.95"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EarlyStopping]]
deps = ["Dates", "Statistics"]
git-tree-sha1 = "98fdf08b707aaf69f524a6cd0a67858cefe0cfb6"
uuid = "792122b4-ca99-40de-a6bc-6742525f08b6"
version = "0.3.0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "e27c4ebe80e8699540f2d6c805cc12203b614f12"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.20"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "ed569cb9e7e3590d5ba884da7edc50216aac5811"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.1.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e77dbf117412d4f164a464d610ee6050cc75272"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.6"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "84204eae2dd237500835990bcade263e27674a93"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.16"

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

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterationControl]]
deps = ["EarlyStopping", "InteractiveUtils"]
git-tree-sha1 = "d7df9a6fdd82a8cfdfe93a94fcce35515be634da"
uuid = "b3c1a2ee-3fec-4384-bf48-272ea71de57c"
version = "0.5.3"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.LatinHypercubeSampling]]
deps = ["Random", "StableRNGs", "StatsBase", "Test"]
git-tree-sha1 = "825289d43c753c7f1bf9bed334c253e9913997f8"
uuid = "a5e1c1ea-c99a-51d3-a14d-a9a37257b02d"
version = "1.9.0"

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

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.LossFunctions]]
deps = ["CategoricalArrays", "Markdown", "Statistics"]
git-tree-sha1 = "44a7bfeb7b5eb9386a62b9cccc6e21f406c15bea"
uuid = "30fc2ffe-d236-52d8-8643-a9d8f7c094a7"
version = "0.10.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MLJ]]
deps = ["CategoricalArrays", "ComputationalResources", "Distributed", "Distributions", "LinearAlgebra", "MLJBase", "MLJEnsembles", "MLJIteration", "MLJModels", "MLJTuning", "OpenML", "Pkg", "ProgressMeter", "Random", "ScientificTypes", "Statistics", "StatsBase", "Tables"]
git-tree-sha1 = "80149328ca780b522b5a95e402450d10df7904f2"
uuid = "add582a8-e3ab-11e8-2d5e-e98b27df1bc7"
version = "0.19.1"

[[deps.MLJBase]]
deps = ["CategoricalArrays", "CategoricalDistributions", "ComputationalResources", "Dates", "DelimitedFiles", "Distributed", "Distributions", "InteractiveUtils", "InvertedIndices", "LinearAlgebra", "LossFunctions", "MLJModelInterface", "Missings", "OrderedCollections", "Parameters", "PrettyTables", "ProgressMeter", "Random", "ScientificTypes", "Serialization", "StatisticalTraits", "Statistics", "StatsBase", "Tables"]
git-tree-sha1 = "4cc167b6c0a3ab25d7050e4ac38fe119e97cd1ab"
uuid = "a7f614a8-145f-11e9-1d2a-a57a1082229d"
version = "0.21.11"

[[deps.MLJDecisionTreeInterface]]
deps = ["CategoricalArrays", "DecisionTree", "MLJModelInterface", "Random", "Tables"]
git-tree-sha1 = "8059d088428cbe215ea0eb2199a58da2d806d446"
uuid = "c6f25543-311c-4c74-83dc-3ea6d1015661"
version = "0.4.0"

[[deps.MLJEnsembles]]
deps = ["CategoricalArrays", "CategoricalDistributions", "ComputationalResources", "Distributed", "Distributions", "MLJBase", "MLJModelInterface", "ProgressMeter", "Random", "ScientificTypesBase", "StatsBase"]
git-tree-sha1 = "95b306ef8108067d26dfde9ff3457d59911cc0d6"
uuid = "50ed68f4-41fd-4504-931a-ed422449fee0"
version = "0.3.3"

[[deps.MLJIteration]]
deps = ["IterationControl", "MLJBase", "Random", "Serialization"]
git-tree-sha1 = "be6d5c71ab499a59e82d65e00a89ceba8732fcd5"
uuid = "614be32b-d00c-4edb-bd02-1eb411ab5e55"
version = "0.5.1"

[[deps.MLJModelInterface]]
deps = ["Random", "ScientificTypesBase", "StatisticalTraits"]
git-tree-sha1 = "c8b7e632d6754a5e36c0d94a4b466a5ba3a30128"
uuid = "e80e1ace-859a-464e-9ed9-23947d8ae3ea"
version = "1.8.0"

[[deps.MLJModels]]
deps = ["CategoricalArrays", "CategoricalDistributions", "Combinatorics", "Dates", "Distances", "Distributions", "InteractiveUtils", "LinearAlgebra", "MLJModelInterface", "Markdown", "OrderedCollections", "Parameters", "Pkg", "PrettyPrinting", "REPL", "Random", "RelocatableFolders", "ScientificTypes", "StatisticalTraits", "Statistics", "StatsBase", "Tables"]
git-tree-sha1 = "6a1166e463cf0210364e84f334c79ecf9ac6f51f"
uuid = "d491faf4-2d78-11e9-2867-c94bc002c0b7"
version = "0.16.7"

[[deps.MLJTuning]]
deps = ["ComputationalResources", "Distributed", "Distributions", "LatinHypercubeSampling", "MLJBase", "ProgressMeter", "Random", "RecipesBase"]
git-tree-sha1 = "02688098bd77827b64ed8ad747c14f715f98cfc4"
uuid = "03970b2e-30c4-11ea-3135-d1576263f10f"
version = "0.7.4"

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
version = "2.28.2+0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenML]]
deps = ["ARFFFiles", "HTTP", "JSON", "Markdown", "Pkg", "Scratch"]
git-tree-sha1 = "6efb039ae888699d5a74fb593f6f3e10c7193e33"
uuid = "8b6db2d4-7670-4922-a472-f9537c81ab66"
version = "0.3.1"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6cc6366a14dbe47e5fc8f3cbe2816b1185ef5fc4"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.8+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "67eae2738d63117a196f497d7db789821bce61d1"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.17"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

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

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

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

[[deps.PrettyPrinting]]
git-tree-sha1 = "22a601b04a154ca38867b991d5017469dc75f2db"
uuid = "54e16d92-306c-5ea0-a30b-337be88ac337"
version = "0.4.1"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "LaTeXStrings", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "213579618ec1f42dea7dd637a42785a608b1ea9c"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.2.4"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "6ec7ac8412e83d57e313393220879ede1740f9ee"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.8.2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

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

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "f65dcb5fa46aee0cf9ed6274ccbd597adc49aa7b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.1"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6ed52fdd3382cf21947b15e8870ac0ddbff736da"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.ScientificTypes]]
deps = ["CategoricalArrays", "ColorTypes", "Dates", "Distributions", "PrettyTables", "Reexport", "ScientificTypesBase", "StatisticalTraits", "Tables"]
git-tree-sha1 = "75ccd10ca65b939dab03b812994e571bf1e3e1da"
uuid = "321657f4-b219-11e9-178b-2701a2544e81"
version = "3.0.2"

[[deps.ScientificTypesBase]]
git-tree-sha1 = "a8e18eb383b5ecf1b5e6fc237eb39255044fd92b"
uuid = "30f210dd-8aff-4c5f-94ba-8e64358c1161"
version = "3.0.0"

[[deps.ScikitLearnBase]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "7877e55c1523a4b336b433da39c8e8c08d2f221f"
uuid = "6e75b9c4-186b-50bd-896f-2d2496a4843e"
version = "0.5.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "77d3c4726515dca71f6d80fbb5e251088defe305"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.18"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

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
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StableRNGs]]
deps = ["Random", "Test"]
git-tree-sha1 = "3be7d49667040add7ee151fefaf1f8c04c8c8276"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.0"

[[deps.StatisticalTraits]]
deps = ["ScientificTypesBase"]
git-tree-sha1 = "30b9236691858e13f167ce829490a68e1a597782"
uuid = "64bff920-2084-43da-a3e6-9bb72801c0c9"
version = "3.2.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "f625d686d5a88bcd2b15cd81f18f98186fdc0c9a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.0"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "1544b926975372da01227b382066ab70e574a3ec"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

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
# ╠═7f890290-ecd8-11ed-052c-d783bc2e8d92
# ╠═0915f066-5b6b-4d08-a4cf-60db2bd61657
# ╠═738b6c4f-f47f-430f-8abf-fe162d62975a
# ╠═18395cd7-d5fa-4c52-96a1-906f607ba789
# ╠═a7545c27-0354-4cef-b87a-20ed73c64503
# ╠═8f1e580d-dac2-4e2f-a3cd-963cc0e3ea4b
# ╠═63ec1152-1cf7-49c1-831d-9adf0faffdba
# ╟─eb95d8fc-a303-47a4-b069-21bd8cc26fc6
# ╠═ec2657af-91d6-4859-a2e2-5c3114542e2f
# ╠═a5b13119-8afe-45a3-91de-224ebfe681e5
# ╟─ee1d4799-b498-4999-99c2-6d99c23760af
# ╠═dd5ad3f0-e8e3-4b20-9a83-7d887e61ac9d
# ╠═1e8c50a8-7df8-4de6-9532-aaf7e4f28ba9
# ╠═396d67c7-ebef-48f3-a872-84ab73f23e79
# ╠═d6cb9d36-de50-415a-a5d8-080f5822cdb0
# ╠═eafeaf7c-fff6-41c2-aea1-81ff47389c53
# ╠═32c7b0a0-468e-4456-b477-5ee10bb06219
# ╠═ed3b9e31-1dd3-4a24-bdd3-f04056a2d7ac
# ╟─9f2a0edb-a0fa-4c47-b5b3-f20525842ac3
# ╟─625c5000-ddf3-4d23-bb8c-1b9cc085de67
# ╟─bea62f86-a19b-4724-8bba-130a5cdd9b6b
# ╟─a62389b7-08a5-424a-a199-fe84c8590e6c
# ╠═b9902b25-a9a3-4045-85c2-517e49f35355
# ╠═7d84340f-3e7f-4998-9aaa-73a83ab98852
# ╠═7b6ef60e-332e-4379-b884-7cdd19c92100
# ╠═5f8c8c85-48f2-4350-a545-e23dd25bcc54
# ╟─bfb8a6e5-3a61-4865-8d34-046fe060dca6
# ╠═2f97c87c-f8ad-4347-9d1c-c57e0d5bcaf6
# ╠═fa5d0bd5-5b78-431d-864f-2a3c6879e27d
# ╠═22bc07dc-5c17-4cf6-a072-a521dcca9b87
# ╟─761fc141-999d-414c-b30b-9ce4c72cceb6
# ╠═a358dff0-242c-40da-bd2b-41fd296da5fb
# ╠═d9c43d0c-2c3f-4c17-b3fb-3afdeaf87e53
# ╠═a3189293-84d4-46b7-893b-3a43e396c9f0
# ╠═7e0ba9fb-f310-40b9-a268-5102cc0b5ac6
# ╠═d7965dc6-0d4a-4756-b03d-d19f51faf76b
# ╠═5d3ae4fd-3230-4f94-8752-95fd5aaf2d70
# ╟─702578f0-f2fb-4677-a86e-c8975f670a9b
# ╠═16ca0774-756c-4280-9efe-f2e8a276f4b7
# ╠═f7ecb15f-881d-41b1-bb45-b73fca9df226
# ╠═55f15d9c-3061-4b65-a2c7-60b22b094b1a
# ╠═3ff7efcf-196c-4365-a272-9f100c2f5064
# ╠═99ba7072-945b-4566-8ab9-94a66e75f7c3
# ╠═581959ea-5787-4138-a189-f7437e89461f
# ╠═9cf400fd-2c29-44c4-af82-9bb300452a21
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
