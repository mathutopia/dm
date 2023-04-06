### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ c4dba410-cdca-11ed-2fec-f754a4566750
using CSV, DataFrames, DataFramesMeta,MLJ

# ╔═╡ 66989a01-6437-4d45-8b5e-503d3b0df723
using PlutoUI

# ╔═╡ 502249ca-4c5c-43ad-9878-243e46bcf769
TableOfContents(title = "目录")

# ╔═╡ 2bea2e75-986f-49c2-9ff2-ad5a5631730f
md"""
# 数据 
数据是数据库存储的基本对象。数据可以是数字， 也可以是其他的形式。 了解数据，一方面要关注他的**表现形式**，另一方面也要搞清楚他的**语义**。比如数字67，形式上它是一个整数。他可能是某一门课程的成绩，某个人的体重，或者某个人的年龄等。

数据挖掘中，我们接触的更多的是**数据集**。数据集可以看成是**数据对象**的集合。数据对象有时也在做记录点向量、模式，事件、案例，样本、观测或实体等等。

数据对象，通常用一种刻画对象基本特性的**属性**去描述。属性有时候也叫做变量、特征、字段、维等等。 对象的基本特性内容很广泛，不同的数据集可能会不同。 比如， 如果是描述人的数据对象可能会有身高、体重、籍贯、、职业、年龄、学历等等属性。

属性是对象的性质或特性。不同的对象，不同的时间, 属性都可能不同。 由于属性描述的是对象的特性， 通常需要将其转换为某种值或符号才能够更好的存储、表示。这种将数值或者符号值与对象的属性相关联的规则或者函数，就称为**测量标度（measurement scale）**。 

测量标度本质上是一个函数，它将一个抽象的特性转换为某种具体的值。 这里具体的值是特性的某种代表，但它跟特性之间还是会有区别的。 比如我们用0和1来表示性别的男和女，相当于把性别属性，转换成了一个整数。 很明显整数可以有多种运算，但对性别来说是不行的。 你能想象0+1的含义吗？ 所以在实际运用中属性的含义和用来表示属性的数值或符号的含义需要认真区分。 这就牵扯到属性的类型。

一般而言，我们可以根据属性的基本性质去确定转换之后的数值具有的运算性质。 大体而言有4种类型的性质用于描述属性。

1. 相异性 = ≠
2. 序 < ≤ > ≥
3. 加法 + -
4. 乘法 × ÷ 

一般而言，属性可以根据它对上述4种操作的可施加性分为4种不同的类型。

不同的属性类型

|属性类型|描述|例子|操作|
| ---- | ---- | ---- | ----|
|标称|标称属性的值仅仅只是不同的名字，即标称值只提供足够的信息以区分对象（ = ≠）|邮政编码、雇员ID 号、眼球颜色、性别|众数、熵、列联相关、x2检验|
|序数|序数属性的值提供足够的信息确定对象的序(<,>)|矿石硬度、{好，较好，最好}、成绩、街道号码|中值、百分位、秩相关、游程检验、符号检验|
|区间|对于区间属性，值之间的差是有意义的，即存在测量单位(+)|日历日期、摄氏或华氏温度|均值、标准差、皮尔逊相关、t和F检验|
|比率|对于比率变量，差和比率都是有意义的(×,÷)|绝对温度、货币量、计数、年龄、质量、长度、电流|几何平均、调和平均、百分比变差|

在上面属性的分类中，标称属性和序数属性统称为**分类**的或**定性**的属性。这类属性通常不具备数字的大部分性质，即使是用数字表示，也需要像对待符号一样对待他们。 区间属性和比例属性统称为**定量**的或数值的属性。这类属性具有数字的大部分特性。通常可能是整数值或连续值。


## 数据集的类型

**数据集的一般特性**
1. **维度** 维度是指数据集中对象具有的属性的数目。 低维度的数据和高维度的数据可能具有本质的不同。 分析高维度的数据，可能陷入维度灾难。因而在做数据处理时，可能需要怎样去减少维度，也就是维度规约。
2. **稀疏性** 稀疏性是指一个数据集中对象的大部分属性可能都是不存在的或者是0。 一个典型的例子是购物栏数据。
3. **分辨率** 通常我们都可以得到不同分辨率下的数据。 对数据挖掘来说，需要明确数据的分辨率与数据挖掘的目标是否一致。 比如，如果是为了获得股票价格的趋势，那么拿到分笔交易交易数据就需要进一步的转换； 他如果是要做实时的量化投资， 那么日线级别的股票交易数据可能就不行了。


## 常见数据形式
常见的数据进行时包括购物篮数据， 基于图形的数据， 有序数据和矩阵形式的数据等。其中矩阵形式的数据在实际中是应用最广泛的，也是最常见的。

$$\left(\begin{array}{cccc}
    a_{11} & a_{12} & \cdots & a_{1k}\\  %第一行元素
	\vdots & \vdots & \vdots & \vdots\\
    a_{n1} & a_{n2} & \cdots & a_{nk}\\  %第二行元素
  \end{array}
\right)$$ 
一般而言， 矩阵的每一行代表一个**样本（观测）**， 每一列代表一个**特征（属性）**。 由于矩阵通常要求元素具有相同的数据类型， 而样本的属性可能具有不同类型的取值， 在Julia、Python、R等数据分析语言中， 有专门为这一类数据定制的数据结构--数据框（dataframe）。 在Julia中， Dataframes.jl包（类似与Python中的Pandas包）就是专门处理这类数据的包， 对数据分析来说， 这是一个必须了解的包。


"""

# ╔═╡ e750a4db-dd00-45c2-89b7-eaa35a88be6f
md"""
## 数据的科学类型
在做数据分析时， 我们要区分数据的存储类型（比如， 整型Int， 浮点型Float）和数据的科学类型（数据的含义）。 同样的存储类型， 可能意味着完全不同的含义， 比如，整数0和1， 既可以是通常意义下的数值， 也可能表示性别（这时候表示一个类别）。在这种情况下， 我们需要通过科学类型来区分数据表示的含义。 
在Julia的机器学习框架[MLJ](https://alan-turing-institute.github.io/MLJ.jl/dev/)中（包括很多机器学习模型包）， 引入了多种科学类型。如下图所示：
![good](https://alan-turing-institute.github.io/MLJ.jl/dev/img/scitypes_small.png)

上面的图展示了在MLJ中数据的表示。 除去缺失值Missing和文本值（Textual）以外， 可以将一个字段按照可能的取值数量分为有限型（取值数量有限, Finite{N}表示有N种可能的取值）和无穷型(可能的取值有无穷多种)。 有限型变量

|类别|科学类型scitype|含义|举例|
| ---- | ---- | ---- | ----|
|有限型Finite{N}|有序因子OrderedFactor{N}|有N种可能的取值， 取值之间存在顺序关系（大小比较有意义）|成绩：不及格，及格，良好，优秀； |
||多类别因子Multiclass{N}|有N种类别， 类别之间无顺序关系|性别：男女；|中值、百分位、秩相关、游程检验、符号检验|
|无穷型Infinite|连续型（Continuous）|取值是某个区间中的所有值|身高， 体重|
||计数型Count|有无穷多取值， 但只能是正整数|家庭成员数量；班上学生人数|

在建模过程中， 如果数据的科学类型是错误的， 很有可能导致有问题的结果， 这时候， 可以使用`coerce(data, scitype)`去实现对数据的强制类型转换。
"""

# ╔═╡ 57e7e602-e442-4857-915c-b40bd789ae0d
md"""
# 查看数据的科学类型
在正式建模前， 必须要了解数据的科学类型，以便找到合适的模型。 使用schema函数可以方便的获取数据的科学类型。
"""

# ╔═╡ 638ef5f3-1b04-4ed7-9e54-852b04723ac4
train = CSV.read("../data/trainbx.csv", DataFrame)

# ╔═╡ dcc0798e-9983-44b2-8b52-c350f04a8917
schema(train)

# ╔═╡ 6e42012b-dbdf-45a3-af59-3b52148feedc
md"""
上面由于空间的原因，只展示了一部分字段的科学类型（scitype）和存储类型（type）， 我们可以将其转换到DataFrame里面，方便更好的查看
"""

# ╔═╡ 1281c684-f7f6-4f21-8769-03f30e10ac04
dts = DataFrame(schema(train))

# ╔═╡ 01dffe34-d855-4dea-b923-a15d57715cfe
md"""
如果我们想要获取特定类型的字段有哪些？可以通过转换后的dataframe去选取， 下面的代码选出所有被识别为Textual类型的字段。
"""

# ╔═╡ 301a51ad-89c5-4b6a-9674-21341d591a57
textcols = dts[dts.scitypes .== Textual, :names]

# ╔═╡ 6af46738-7555-4558-9eda-e807d9f5fda9
md"""
此外， 跟科学类型有关的有两个实用函数scitype和elscitype。 这两个函数可以用于判断一个对象（对象中的元素）的科学类型。 与此类似， 可以通过typeof和eltype判断一个对象（对象中的元素）的存储类型。
"""

# ╔═╡ c84fcb31-44a9-421e-b1b8-0e3634057817
elscitype(train.policy_id ), scitype(train.policy_id ), eltype(train.policy_id ),typeof(train.policy_id )

# ╔═╡ 4644ef60-51a3-4aa7-a38c-1df394d68867
md"""
有了这几个小函数之后， 我们可以非常方便的选择一个dataframe中某种类型的字段。比如， 如果我们要选择数据中的Textual类型的字段， 也可以这么做。
"""

# ╔═╡ e2a70d46-176f-455e-b3e1-87902ec2858b
train[:,elscitype.(eachcol(train)) .== Textual]

# ╔═╡ 5e09ee8f-666d-47f2-bb74-95268dc5bd0f
md"""
!!! info "提示"
	上面我的代码中， 有一个函数eachcol。这个函数用于构造一个可迭代对象。可以认为， eachcol(train)是将train的每一列构造成一个集合，集合中的元素是train中的列。 而elscitype.(eachcol(train))的意思是将elscitype这个函数作用到构造的集合中的每一个元素上（注意那个点号“.”）
"""

# ╔═╡ 0253075f-8de1-4d84-9034-60c4bd3256ab
md"""
# 科学类型转换
一个常见的场景是：数据的存储类型和科学类型是不匹配的， 这时候，我们需要将其转换为合理的科学类型。 比如上面的文本类型， 其实他们都可以看成是类别变量， 我们需要将其转换为类别变量才行。 当然可以使用categorical函数去一列一列的转换， 但使用coerce函数才是通用的做法。

使用函数`coerce`, 其通用的格式是：
```
coerce(X, specs...; tight=false, verbosity=1)
```
该函数实现给定表X（包括dataframe），返回X的副本，确保列的元素类型匹配新的规范specs（即： 函数返回符合给定规范（specs）的新的数据。）有两个常见的规范:

(i) 一个或多个 column_name=>Scitype 对:

```julia
coerce(X, col1=>Scitype1, col2=>Scitype2, ... ; verbosity=1)
```

(ii) 一个或多个OldScitype=>NewScitype 对：

```julia
coerce(X, OldScitype1=>NewScitype1, OldScitype2=>NewScitype2, ... ; verbosity=1)
```

"""

# ╔═╡ 58909074-ab21-473f-96cb-284c0494c0a8
tmpx = DataFrame(name=["Siri", "Robo", "Alexa", "Cortana"],
              height=[152, missing, 148, 163],
              rating=[1, 5, 2, 1])

# ╔═╡ dcb9fb37-a0f3-4112-9d08-2d71989df893
tmpxc = coerce(tmpx, :name=>Multiclass, :height=>Continuous, :rating=>OrderedFactor)

# ╔═╡ 6256d21f-6f56-4825-9ee4-63fcaa6f97ef
levels(tmpxc.name)

# ╔═╡ 6dd187af-c886-4aca-83f0-4493e42305a3
md"""
一列一列的不转换是非常不方便的， 下面我们将原始数据中文本类型一次性转化为多类别类型。
"""

# ╔═╡ 1f6c0861-530d-407d-81e3-73027419f5be
coerce(train, Textual => Multiclass)

# ╔═╡ 64258691-fdc3-4645-b5e8-e6667782b932
md"""
当然， 我们知道， 还有一些列也是错误的， 比如，fraud列应该是一个类别变量。我们可以将其同时做转化。
"""

# ╔═╡ c64d38fc-601d-4a70-8e4d-f42ed610b48e
elscitype(train.fraud)

# ╔═╡ 7ab72da2-0537-43fa-9ef5-414304888d7a
coerce(train, Textual => Multiclass, :fraud => Multiclass)

# ╔═╡ 6cf2c3d2-2a0e-4af9-a71b-aa4ca213f04a
md"""
!!! warn "注意"
	有人可能以为， 通过上面的两段代码， 原始数据的类型已经更改了。这是错误的！！！我们并没有使用带！的函数。 如果你想把这种更改保留下来， 应该要将其保存到一个变量中， 如果保存到同一个变量中train， 将改变原始数据。
"""

# ╔═╡ 765e5d2b-d198-4287-a9ac-d155659c8f0b
md"""
# 数据重编码
虽然科学类型能够合理的表达数据的语义， 但模型可能对适合的科学类型有要求。因此， 有些科学类型并不适合直接放进模型去，需要对其进行编码处理。 这种编码处理在MLJ中被统一定义为转换（transform）操作。 在数据挖掘中， 转换是非常常见的， 比如对数据做标准化、缺失值处理等等，本质上都是转换操作--将数据从一种形式变成另一种形式。 

为了统一这些转换操作，在MLJ中，引入了转换器（transformer）的概念。 在MLJ中，预定义了多个转换器。比如，标准化Standardizer， 独热编码OneHotEncoder， 缺失值计算FillImputer，以及连续编码器ContinuousEncoder等，可以看**[这里](https://alan-turing-institute.github.io/MLJ.jl/dev/transformers/)**获取MLJ中内置的转换器及其使用方法。


一个转换器本质上是一个数据结构， 结构中存储了转换器需要的参数， 当数据流过转换器时， 新的数据将按照给定转换器类型和参数去计算新的值。 





"""

# ╔═╡ 5d8c504b-811d-4936-ad9f-876935a62ae6
md"""
## 数据标准化
下面以标准化为例， 演示在MLJ中，如果使用转换器。 掌握了这个转换器的使用， 所有的其他转换器也就会用了， 因为他们除了参数不同外， 其他的操作方式都是一样的。

使用转化器有如下步骤：

1. 构建转换器实例（创建一个转换器对象）
2. 将数据和转换器绑定到一起, machine(transformer, Xold)
3. 根据绑定的数据拟合转换器, fit!(machine)
4. 拟合之后的转换器可以用于数据的转换操作了, tranform(machine, X)


我们知道标准化意味着对数据做如下操作：

$$xnew = \frac{xold-mean(xold)}{sd(xold)}$$

即， 我们首先要计算数据的均值mean和标准差sd， 然后在转换时， 只需要按照上面的公式去转换就好了。


假定我们要对如下的数据中部分字段做标准化
"""

# ╔═╡ ca9f665e-32eb-49f5-abeb-533426b60eba
X = DataFrame(name=categorical(["Danesh", "Lee", "Mary", "John"]),
     grade=categorical(["A", "B", "A", "C"], ordered=true),
     height=[1.85, 1.67, 1.5, 1.67],
     n_devices=[3, 2, 4, 3],
     comments=["the force", "be", "with you", "too"])

# ╔═╡ 1bdb871a-6f21-4e05-93ba-1a2f62ed15d3
schema(X)

# ╔═╡ e412889d-3b48-4787-a42b-2966d3dddbbf
md"""
**第一步** ： 构造标准化转换器实例。可以看到这里有四个参数可以设置， 其中的features可以用于设定你要标准化的字段， 如果没有设置默认会对所有连续类型Continuous的字段做标准化。 其他字段的函数大家可以看帮助文档。

"""

# ╔═╡ 7ce4c55e-1cb6-4040-952e-977ff48f84be
stand1 = Standardizer()

# ╔═╡ e2921bc0-0a62-4188-a7f8-65ce324ded72
stand2 = Standardizer(count = true)

# ╔═╡ 620cc801-a391-42fe-bea7-160bce842477
md"""
**第二步：** 将数据和转换器绑定到一起, machine
你的转换器必然是施加到一个数据集上， 因此， 我们需要将待转换的数据和转换器绑定到一起。
"""

# ╔═╡ bf4d44dd-c3d9-4d9a-b2d1-08e5a9eb0ce2
mach1 = machine(stand1, X)

# ╔═╡ 71504275-ae61-4c95-a9e0-512c8db10182
md"""
**第三步：** 拟合转换器
拟合转换器是让第一步构建的转换器实例从数据中学习到相应的参数。 比如， 标准化转换， 我们需要根据你要转换的字段，学习到该字段的均值、标准差。
"""

# ╔═╡ a04c87c7-fcab-4593-9b49-7afc90a3a10b
fit!(mach1)

# ╔═╡ d6957fd9-895f-48e9-a21e-b0f6047b7be5
md"""
!!! warn "请注意"
	上面的函数fit！带有惊叹号！， 表示这个函数会改变它的参数。 这里，相当于会对mach1进行改变， 实际上就是把原先没有的均值和方差记录下来。 这步操作之后， 第二步构造的机器mach1已经发生了改变。我们也不需要重新赋值。
"""

# ╔═╡ d93349d9-74f7-41eb-badf-b845515b7a66
md"""
**第四步：** 利用学习之后的（拟合之后的）转换器对数据去做转换， 使用transform函数。由于这个函数很容易跟其它包中的函数重名， 所以调用的使用最好加一个前缀MLJ.。
"""

# ╔═╡ 9ff602b0-b6a5-4765-bf7b-2d5504ea28d1
MLJ.transform(mach1, X)

# ╔═╡ cfda0a8c-9922-4a99-b3e0-7edda069d54e
X

# ╔═╡ e773eeb7-7f52-43f8-906e-20a9af1fac8f
md"""
可以看到， X中转换之后， height字段变了， 其他的没有变化， 因为其他字段不是连续型的。
"""

# ╔═╡ 36fa8c94-468f-4d88-b91f-82fc7b0511a7
md"""
## 独特编码（onehot encoding）
"""

# ╔═╡ 7e01c03f-c474-48d7-84d4-19563a402c2e
onehot = OneHotEncoder()

# ╔═╡ 4bd5ac3e-8440-483e-89b5-5e40863f0916
hotmach = fit!(machine(onehot, X))

# ╔═╡ 7a85b2e3-2def-43ae-a1f6-d44745299e77
md"""
!!! warn "注意"
	上面相当于把绑定数据，拟合转换器的操作统一到一起啦。
"""

# ╔═╡ 0d544a41-8769-4f57-8664-a4ae9c723705
MLJ.transform(hotmach, X)

# ╔═╡ 7a2220f4-6edb-43b3-957c-7b3167945a6e
X

# ╔═╡ 06ea407d-55f9-45e9-815e-39881dc146af
md"""
## 连续编码
接下来， 我们演示连续编码。 在竞赛数据集中， 有很多的Textual类型的变量， 虽然我们可以将其转换为类别变量Multiclass。 但类别变量有时候还是不方便直接计算。此外， 还有像计数变量、有序因子等也可能需要变为连续类型。 因此， 我们需要做连续编码ContinuousEncoder。



跟上面标准化转化一样， 连续编码转换也是4个步骤。

```julia
encode = ContinuousEncoder() # 创建转换器
mach = machine(encode, X) # 绑定转化器和数据
mach = fit!(mach) # 拟合转换器（机器）
W = transform(mach, X)  # 使用拟合的转换器去转换数据
```

在转换过程中， 连续转换器采用如下规则对每一个特征ftr进行转换：

- 如果ftr已经是Continuous， 保留.

- 如果ftr是Multiclass, 独热编码one-hot encoding.

- 如果ftr是OrderedFactor, 用coerce(ftr, Continuous) (浮点数向量)替换, 除非设定了ordered_factors=false, 这种情况下，采用独热编码.

- 如果ftr是Count, 用coerce(ftr, Continuous)替换.

- 如果ftr是其他科学类型scitype, 或在训练时没有见过的类型，丢掉该字段.
"""

# ╔═╡ 177608ea-1a40-4d26-83a4-9b9458f3e6b9
encoder = ContinuousEncoder()

# ╔═╡ bf83a50d-c755-4922-888a-6e0518cb3578
mach = fit!(machine(encoder, X))

# ╔═╡ 25d14618-62e5-420a-8fae-57ca7873a0f1
W = MLJ.transform(mach, X)

# ╔═╡ 40c083bf-d5f1-49d7-8ce4-f274649f7da2
md"""
!!! info "提示"
	仔细分析你会发现， 转换之后的数据多了一些字段（比如那些以name开头的字段）, 同时又少了一些字段， 比如，comments字段。 多出来的字段是因为独热编码导致的， 少了的字段是因为不能连续编码的字段被抛弃了。
"""

# ╔═╡ 975dec03-b299-425a-8789-73fd71595c51
md"""
你再去检查得到的新的数据的科学类型时会发现， 所有的字段都变成连续型了。
"""

# ╔═╡ e98d8f1d-25e5-45dc-bad9-92347afacfcd
schema(W)

# ╔═╡ e5477d23-1bd5-4fa8-a9da-ea7d4a602f5c
md"""
## 缺失值计算
缺失值的计算也是一个常见的需要的操作， 由于我们竞赛中不存在缺失值， 我们以一个简单的例子介绍一下缺失值的处理。

缺失值填充时， 遵循如下规则（有如下参数可设置）：

- features: 要施加缺失值填充的字段。默认情况下是对所有的列填充缺失值。
- continuous\_fill: 用于计算连续性变量的缺失值的函数， 默认情况下是除去缺失值之后的中值meadian。
- count\_fill: 用于计算计数变量的缺失值函数， 默认情况下是除去缺失值之后的中值的四舍五入取整。
- finite\_fill: 所有取有限值的缺失值计算函数; 默认情况下是除去缺失值之后的众数(mode)。
"""

# ╔═╡ 31ff2db2-7779-4205-a30d-b58d40ebf483
Xm = DataFrame(a = [1.0, 2.0, missing, 3.0, missing],
     b = coerce(["y", "n", "y", missing, "y"], Multiclass),
     c = [1, 1, 2, missing, 3])


# ╔═╡ b222943b-97cb-4753-9a66-dadde7c5785d
schema(Xm)

# ╔═╡ d9b7420e-608c-4e79-ab3f-b5ef89b7cf88
imputer = FillImputer()

# ╔═╡ 480cd276-c780-4f46-b4b3-6ad0b8de1ad4
machimp = fit!(machine(imputer, Xm))

# ╔═╡ b9ebbab4-7750-44af-b4d6-4295dbb07ead
MLJ.transform(machimp, Xm)

# ╔═╡ 7d60e9ec-b780-44e9-84a6-e4565b65cdb7
md"""
# 总结
一份原始数据， 从读取仅内存到输入模型前， 我们需要做如下事情：

首先要搞清楚每个字段的存储类型（type, eltype）和其科学类型(scitype, elscitype)是否相符。如果存储科学类型不对， 我们需要对其进行相应的类型转换（coerce）。 转换之后， 我们可能需要对数据进行变形转换（transform）,以满足模型的需要， 比如 填充缺失值、连续化、标准化等，这些可以通过transformer实现。这通常有三个步骤：
 - 1） 构建转换器（）； 
 - 2）绑定数据（machine）；
 - 3）拟合转换器（fit!）；
 - 4）用于转换(MLJ.transform)；
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
DataFramesMeta = "1313f7d8-7da2-5740-9ea0-a2ca25f37964"
MLJ = "add582a8-e3ab-11e8-2d5e-e98b27df1bc7"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CSV = "~0.10.9"
DataFrames = "~1.5.0"
DataFramesMeta = "~0.13.0"
MLJ = "~0.19.1"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "0f175153b5d7c4b5badf54094ffb30e740e4e529"

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
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "SnoopPrecompile", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "c700cce799b51c9045473de751e9319bdd1c6e94"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.9"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "5084cc1a28976dd1642c9f337b28a3cb03e0f7d2"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.7"

[[deps.CategoricalDistributions]]
deps = ["CategoricalArrays", "Distributions", "Missings", "OrderedCollections", "Random", "ScientificTypes", "UnicodePlots"]
git-tree-sha1 = "da68989f027dcefa74d44a452c9e36af9730a70d"
uuid = "af321ab8-2d2e-40a6-b165-3d674595d28e"
version = "0.1.10"

[[deps.Chain]]
git-tree-sha1 = "8c4920235f6c561e401dfe569beb8b924adad003"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.5.0"

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

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "aa51303df86f8626a962fccb878430cdb0a97eee"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.5.0"

[[deps.DataFramesMeta]]
deps = ["Chain", "DataFrames", "MacroTools", "OrderedCollections", "Reexport"]
git-tree-sha1 = "f9db5b04be51162fbeacf711005cb36d8434c55b"
uuid = "1313f7d8-7da2-5740-9ea0-a2ca25f37964"
version = "0.13.0"

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

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "49eba9ad9f7ead780bfb7ee319f962c811c6d3b2"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.8"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "da9e1a9058f8d3eec3a8c9fe4faacfb89180066b"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.86"

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
git-tree-sha1 = "0ba171480d51567ba337e5eea4e68a8231b7a2c3"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.10"

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
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "37e4657cd56b11abe3d10cd4a1ec5fbdb4180263"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.7.4"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

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

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

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
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.LatinHypercubeSampling]]
deps = ["Random", "StableRNGs", "StatsBase", "Test"]
git-tree-sha1 = "42938ab65e9ed3c3029a8d2c58382ca75bdab243"
uuid = "a5e1c1ea-c99a-51d3-a14d-a9a37257b02d"
version = "1.8.0"

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

[[deps.LossFunctions]]
deps = ["InteractiveUtils", "Markdown", "RecipesBase"]
git-tree-sha1 = "53cd63a12f06a43eef6f4aafb910ac755c122be7"
uuid = "30fc2ffe-d236-52d8-8643-a9d8f7c094a7"
version = "0.8.0"

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
git-tree-sha1 = "37a311b0cd581764fc460f6632e6219dc32f9427"
uuid = "a7f614a8-145f-11e9-1d2a-a57a1082229d"
version = "0.21.8"

[[deps.MLJEnsembles]]
deps = ["CategoricalArrays", "CategoricalDistributions", "ComputationalResources", "Distributed", "Distributions", "MLJBase", "MLJModelInterface", "ProgressMeter", "Random", "ScientificTypesBase", "StatsBase"]
git-tree-sha1 = "bb8a1056b1d8b40f2f27167fc3ef6412a6719fbf"
uuid = "50ed68f4-41fd-4504-931a-ed422449fee0"
version = "0.3.2"

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
git-tree-sha1 = "1d445497ca058dbc0dbc7528b778707893edb969"
uuid = "d491faf4-2d78-11e9-2867-c94bc002c0b7"
version = "0.16.4"

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

[[deps.MarchingCubes]]
deps = ["SnoopPrecompile", "StaticArrays"]
git-tree-sha1 = "b198463d1a631e8771709bc8e011ba329da9ad38"
uuid = "299715c1-40a9-479a-aaf9-4a633d36f717"
version = "0.1.7"

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

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

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

[[deps.OrderedCollections]]
git-tree-sha1 = "d78db6df34313deaca15c5c0b9ff562c704fe1ab"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.5.0"

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
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyPrinting]]
git-tree-sha1 = "4be53d093e9e37772cc89e1009e8f6ad10c4681b"
uuid = "54e16d92-306c-5ea0-a30b-337be88ac337"
version = "0.4.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "LaTeXStrings", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "548793c7859e28ef026dba514752275ee871169f"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.2.3"

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
deps = ["SnoopPrecompile"]
git-tree-sha1 = "261dddd3b862bd2c940cf6ca4d1c8fe593e457c8"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.3"

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
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[deps.StableRNGs]]
deps = ["Random", "Test"]
git-tree-sha1 = "3be7d49667040add7ee151fefaf1f8c04c8c8276"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "b8d897fe7fa688e93aef573711cb207c08c9e11e"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.19"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.StatisticalTraits]]
deps = ["ScientificTypesBase"]
git-tree-sha1 = "30b9236691858e13f167ce829490a68e1a597782"
uuid = "64bff920-2084-43da-a3e6-9bb72801c0c9"
version = "3.2.0"

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

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "f625d686d5a88bcd2b15cd81f18f98186fdc0c9a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.0"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

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

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodePlots]]
deps = ["ColorSchemes", "ColorTypes", "Contour", "Crayons", "Dates", "LinearAlgebra", "MarchingCubes", "NaNMath", "Printf", "Requires", "SnoopPrecompile", "SparseArrays", "StaticArrays", "StatsBase"]
git-tree-sha1 = "a5bcfc23e352f499a1a46f428d0d3d7fb9e4fc11"
uuid = "b8865327-cd53-5732-bb35-84acbb429228"
version = "3.4.1"

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
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

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
# ╠═c4dba410-cdca-11ed-2fec-f754a4566750
# ╠═66989a01-6437-4d45-8b5e-503d3b0df723
# ╠═502249ca-4c5c-43ad-9878-243e46bcf769
# ╟─2bea2e75-986f-49c2-9ff2-ad5a5631730f
# ╟─e750a4db-dd00-45c2-89b7-eaa35a88be6f
# ╟─57e7e602-e442-4857-915c-b40bd789ae0d
# ╠═638ef5f3-1b04-4ed7-9e54-852b04723ac4
# ╠═dcc0798e-9983-44b2-8b52-c350f04a8917
# ╟─6e42012b-dbdf-45a3-af59-3b52148feedc
# ╠═1281c684-f7f6-4f21-8769-03f30e10ac04
# ╟─01dffe34-d855-4dea-b923-a15d57715cfe
# ╠═301a51ad-89c5-4b6a-9674-21341d591a57
# ╟─6af46738-7555-4558-9eda-e807d9f5fda9
# ╠═c84fcb31-44a9-421e-b1b8-0e3634057817
# ╟─4644ef60-51a3-4aa7-a38c-1df394d68867
# ╠═e2a70d46-176f-455e-b3e1-87902ec2858b
# ╟─5e09ee8f-666d-47f2-bb74-95268dc5bd0f
# ╟─0253075f-8de1-4d84-9034-60c4bd3256ab
# ╠═58909074-ab21-473f-96cb-284c0494c0a8
# ╠═dcb9fb37-a0f3-4112-9d08-2d71989df893
# ╠═6256d21f-6f56-4825-9ee4-63fcaa6f97ef
# ╟─6dd187af-c886-4aca-83f0-4493e42305a3
# ╠═1f6c0861-530d-407d-81e3-73027419f5be
# ╟─64258691-fdc3-4645-b5e8-e6667782b932
# ╠═c64d38fc-601d-4a70-8e4d-f42ed610b48e
# ╠═7ab72da2-0537-43fa-9ef5-414304888d7a
# ╟─6cf2c3d2-2a0e-4af9-a71b-aa4ca213f04a
# ╟─765e5d2b-d198-4287-a9ac-d155659c8f0b
# ╟─5d8c504b-811d-4936-ad9f-876935a62ae6
# ╠═ca9f665e-32eb-49f5-abeb-533426b60eba
# ╠═1bdb871a-6f21-4e05-93ba-1a2f62ed15d3
# ╟─e412889d-3b48-4787-a42b-2966d3dddbbf
# ╠═7ce4c55e-1cb6-4040-952e-977ff48f84be
# ╠═e2921bc0-0a62-4188-a7f8-65ce324ded72
# ╟─620cc801-a391-42fe-bea7-160bce842477
# ╠═bf4d44dd-c3d9-4d9a-b2d1-08e5a9eb0ce2
# ╟─71504275-ae61-4c95-a9e0-512c8db10182
# ╠═a04c87c7-fcab-4593-9b49-7afc90a3a10b
# ╟─d6957fd9-895f-48e9-a21e-b0f6047b7be5
# ╟─d93349d9-74f7-41eb-badf-b845515b7a66
# ╠═9ff602b0-b6a5-4765-bf7b-2d5504ea28d1
# ╠═cfda0a8c-9922-4a99-b3e0-7edda069d54e
# ╟─e773eeb7-7f52-43f8-906e-20a9af1fac8f
# ╠═36fa8c94-468f-4d88-b91f-82fc7b0511a7
# ╠═7e01c03f-c474-48d7-84d4-19563a402c2e
# ╠═4bd5ac3e-8440-483e-89b5-5e40863f0916
# ╟─7a85b2e3-2def-43ae-a1f6-d44745299e77
# ╠═0d544a41-8769-4f57-8664-a4ae9c723705
# ╠═7a2220f4-6edb-43b3-957c-7b3167945a6e
# ╟─06ea407d-55f9-45e9-815e-39881dc146af
# ╠═177608ea-1a40-4d26-83a4-9b9458f3e6b9
# ╠═bf83a50d-c755-4922-888a-6e0518cb3578
# ╠═25d14618-62e5-420a-8fae-57ca7873a0f1
# ╟─40c083bf-d5f1-49d7-8ce4-f274649f7da2
# ╟─975dec03-b299-425a-8789-73fd71595c51
# ╠═e98d8f1d-25e5-45dc-bad9-92347afacfcd
# ╟─e5477d23-1bd5-4fa8-a9da-ea7d4a602f5c
# ╟─31ff2db2-7779-4205-a30d-b58d40ebf483
# ╠═b222943b-97cb-4753-9a66-dadde7c5785d
# ╠═d9b7420e-608c-4e79-ab3f-b5ef89b7cf88
# ╠═480cd276-c780-4f46-b4b3-6ad0b8de1ad4
# ╠═b9ebbab4-7750-44af-b4d6-4295dbb07ead
# ╟─7d60e9ec-b780-44e9-84a6-e4565b65cdb7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
