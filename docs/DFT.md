## ♪ DFT简介

![](https://pic1.imgdb.cn/item/63369ad816f2c2beb1695300.jpg)

**Materials = electrons + nuclei**

**Electrostatic attraction + interaction -> Dynamic equilibrium**

一切物质都是由电子和原子核组成，当电子和原子核各自间的**静电引力与相互作用达到动态平衡时**，物质达到稳定

由于多体薛定谔方程无法求解，我们需要对它进行一系列近似。（简单来说是因为太复杂，怎么复杂后面会补充）

**密度泛函理论 Density Functional Theory**

$$
Eee = \frac {e^2}{4 π ε_0 d_{ee}}	\tag{电子之间}
$$

$$
Eee = \frac {Z^2e^2}{4 π ε_0 d_{nn}}	\tag{电子与电子核之间}
$$

$$
Eee = \frac {Ze^2}{4 π ε_0 d_{en}}	\tag{电子核之间}
$$

其中：e:电子电量，$ε_0$:真空介电常数(8.86 × 10F/m)，Z:核电荷数。
分别为电子-电子，电子-原子核，原子核-原子核间的能量，这是基于库伦定律的积分实现的：

当把库伦常数**k**转化为真空电容率**$1/4πε_0$**后，库伦定律如下：

$$
F = \frac {e_1e_2}{4 π ε_0 d_{ee}^2}	\tag{库伦定律}
$$

固定一个电子，将另一个电子从平衡位置d处移动到无限远处，对距离d进行积分（字母重复，表示为d’），就可以得到电子与电子间的能量，其余同理

$$
\int_{d}^{\infty}{\frac {e^2}{4 π ε_0 d_{ee}}}dd^`	
$$

## ♪ Binding energy计算

$$
E_Binding = E_Total - (E_A + E_B)
$$

对各部分Energy进行GGA, BLPY求解。同时注意考虑电荷量。

## ♪ Charge density计算

![](https://pic1.imgdb.cn/item/6336b93316f2c2beb189f854.png)

蓝色区域表示电子缺失，红色区域表示电子富集，白色区域表示稳定。

![](https://pic1.imgdb.cn/item/6336b99d16f2c2beb18a550a.jpg)

![](https://pic1.imgdb.cn/item/6336b9b016f2c2beb18a65ce.jpg)

分析Electron density + Electrostatics + Population analysis.

![](https://pic1.imgdb.cn/item/6336ba7616f2c2beb18b2b23.jpg)

色棒可以在Color maps进行调整。

## ♪ 势能面计算

![](https://pic1.imgdb.cn/item/6336bab816f2c2beb18b6e94.jpg)

![](https://pic1.imgdb.cn/item/6336bb1b16f2c2beb18bd3f5.jpg)

在我github中给出了两个**[例子](https://github.com/zequnW/Potential-maps.git)**




















---

<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>