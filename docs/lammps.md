#Lammps

##♪ 在清华超算上提交计算
使用360急速浏览器或者ie(管理员模式)进入清华超算[https://166.111.143.19:10000/svpn/vpnuser/home.cgi](https://166.111.143.19:10000/svpn/vpnuser/home.cgi)

清华超算采用**Xhsell 6版本**

进入文件所在的文件夹

运行命令
```
bsub -a intelmpi -e error.txt -o output.txt -J xx -i xx.in -n nn mpirun.lsf /home/anmeng/WORK1/lammps-3Mar20/src/lmp_mpi
	- xx: your commit id
	- xx.in: your file.in
	- nn: the number of cpu apply to compute
	- ‘/home/anmeng/WORK1/lammps-3Mar20/src/lmp_mpi’: the address of the exe
```

04.13

更新一个新编译的Lammps路径，同样的版本。之前编译deepmd，结果g++版本不够，但是已经回不去了，无法make clean-all，只好重新编译


```
bsub -a intelmpi -e error.txt -o output.txt -J xx -i xx.in -n nn mpirun.lsf /work1/anmeng_work/lammps-pure3Mar20/lammps-3Mar20/src/lmp_mpi
	- xx: your commit id
	- xx.in: your file.in
	- nn: the number of cpu apply to compute
	- ‘/home/anmeng/WORK1/lammps-3Mar20/src/lmp_mpi’: the address of the exe
```


---
##♪ 计算声子谱
<div align=center>
<img src="https://pic.imgdb.cn/item/6257d62f239250f7c5d3139e.jpg" width="50%">
</div>

感谢[泛柏舟](https://www.zhihu.com/people/ying-xiao-ye)、[学力学的图图](https://www.zhihu.com/people/du-yao-89-86)和[樊哲勇老师](https://zheyongfan.org/index.php/Main_Page)对于计算声子谱所做出的贡献及讲解。

### VACF**(velocity auto-correlation function)**

- Each atom’s contribution to the VACF is its current velocity vector dotted into its initial velocity vector at the time the compute was specified.

###	DOS

lammps中也有**“compute vacf”**的命令，往往也可以得到速度的自关联函数，原则上在这个基础上通过傅里叶变换，可以得到体系中的功率频谱，也就是分子动力学方法得到的声子谱，但是仔细阅读这一命令会发现在这里计算的VACF只有**一个时间原点**，没有办法如同在GK平衡态方法中计算热导率那般采取许多个时间原点进行平均，一个典型的输出例子如下：

<div align=center>
<img src="https://pic.imgdb.cn/item/6257d679239250f7c5d393ad.jpg" width="50%">
</div>

可以发现这个声子谱显得非常凌乱

**Manual Note 中强调，如果要重复计算，必须保持所计算的原子ID一样。我理解的也就是他们也明白这个不准，需要取平均，而且取平均的规则很严格。**

在樊老师的博客里面给出了一个非常好的具体的代码来实现取多个时间原点平均的声子谱计算方法，只需要通过lammps输出一段时间的位移然后进行计算

在lammps中输入命令：
```python
dump 1 all custom 1 ${simname}_voutput.lammpstrj id type vx vy vz
```
后处理方式在matlab代码已经讲的十分详细了，根据自己的需要修改即可。

一个处理好的示例文件可以在我的[GitHub](https://github.com/zequnW/DOS)中找到

---

##♪ 将扁盒子改成方盒子

> - Redefine lattice 

$$
\left[
\begin{matrix}
1 & 0 & 0 \\
1 & 2 & 0 \\
0 & 0 & 1 \\ 
\end{matrix} 
\right]
$$

上面的记着好像不太对，下面的可能是正确的

$$
\left[
\begin{matrix}
1 & 1 & 0 \\
-1 & 1 & 0 \\
0 & 0 & 1 \\ 
\end{matrix} 
\right]
$$
---

##♪ 一个课题组干了一件很牛的事（给单体算聚合物的性质）

来自安博去学习的东京的课题组：

简单来说，给一个单体，不用再去淬火，再去驰豫，可以直接得出由单体构成聚合物的

- Thermal conductivity				热导率
- Thermal diffusivity               热扩散系数
- Density                           密度
- Cp                                Cp
- Cv                                Cv
- Linear expansion coefficient      线性膨胀系数
- Volumetric expansion coefficient  体积膨胀系数
- Compressibility                   压缩系数
- Bulk modulus                      体积弹性模量
- Isentropic compressibility        等熵压缩
- Isentropic bulk modulus           等熵体积弹性模量
- Static dielectric constant        静态介电常数
- Refractive index                  折射率
- Radius of gyration                回转半径
- End-to-end distance               端到端的距离
- Nematic order parameter           向列有序参数

没错，你只需要有一个Python 和 Lammps,还有对应的包， 就可以把这些打包带走

心动不如行动，快来学习吧↓

[文章链接](https://arxiv.org/ftp/arxiv/papers/2203/2203.14090.pdf)

[GitHub链接](https://github.com/RadonPy/RadonPy)

---

##♪ MS里建一个球体

> - 首先，你需要一个盒子（尺寸可以小于半径，保证是单体就OK）

> - Build -> Build nanostructure -> Nanocluster -> Sphere 输入半径就OK

![](https://pic.imgdb.cn/item/62748fcd0947543129a54883.jpg)


##♪ 复杂混合体系中，存在大量单双建的建模问题

存在的问题：

①	MS直接使用AC模块，部分会错误成键。且，AC模块无法控制核数，导致过程太慢！

②	packmol，只可以识别一级键，无法识别二级建。

③	packmol建模后，使用MS的Calculated bond重新识别键，会存在错误成键，乱成键的问题
解决办法：

依然使用packmol建模，只不过，导入MS后，不要全部计算键，只更改键的类型

-> Calculate Bond type
![](https://pic.imgdb.cn/item/6282037e0947543129831919.jpg)

解决了键的类型，这样一来，建模再无大问题

##♪ 将LAMMPS跑出的结构，重新导入MS中建模

不讲这一问题的重要意义了，直接上干货：

```python
dump xx all custom Nfreq dump.lammpstrj id mol type element x y z ix iy iz
dump_modify element A B C D
```

已知需要输出的步数，输出这一步数的结构信息（①修改type 的123为具体元素，或②dump_modify 加入元素识别信息）

删除Timestep 0步的结构，之后导入VMD

![](https://pic.imgdb.cn/item/628205e1094754312989c752.jpg)

![](https://pic.imgdb.cn/item/6282060109475431298a2918.jpg)

这样，就可以保存好pdb结构，导入MS后，重新添加原子建模

---

##♪ 切111切面并改盒子

选择`build > surface > cleave surface`

`Cleave plane 1 1 1`	Then `Cleave`

切后的结构是没有"封顶"的，需要手动设置一个真空层

`build > crystal > build vacuum slab`

`vacuum thickness`选择0 Å, 就可以得到最小的顶部盖子

![](https://pic.imgdb.cn/item/628edf110947543129834434.jpg)

可以看到当前坐标系与晶格并不平行

`Lattice Parameters - Advanced - Re-oriented to standard`

![](https://pic.imgdb.cn/item/628edf47094754312983aa62.jpg)

转为正交晶格，然后再参考之前 `Redefine lattice`,变为方盒子，然后重复上方转正操作即可。

---

##♪ TIP4P水模型

这是TIP4P水模型的始祖文章，[点这里](https://aip.scitation.org/doi/10.1063/1.445869)

![](https://pic.imgdb.cn/item/62ec95338c61dc3b8e71fe90.jpg)

从上图可以看到，体系中水分子即使**存在键角及相关能量参数**，但**对于体系的能量都是没有贡献的**。图中蓝色为加入了除了水分子之外的其他的键

这是由于，TIP4P/TIP3P水模型中，键角能量是不统计进总能量的。从统计水分子自身的能量式可以看到

![](https://pic.imgdb.cn/item/62ec962e8c61dc3b8e75a1a3.jpg)

其中涉及了电荷以及带电原子(氧原子)间的距离。并不涉及键角参数。

也可以看到，并没有设计到原子的能量参数，那么能量参数用在哪呢？当然是用在静电作用了。所以也可以得出另一个结果，如果只统计水分子间作用的话，哪怕不给氧原子的能量参数也是可以的。

Wikipedia also has a nice article on [water models](https://en.wikipedia.org/wiki/Water_model)

---

##♪ 为什么需要Voronoi体积？

应力，是固体力学乃至连续介质力学无法绕开的议题，整个固体力学在讨论本构关系的时候，其中一极就是应力。在lammps中是不存在这样的应力概念的，因为lammps中的界面是离散的。但是在计算材料科学中，我们往往会用lammps计算一种新的材料的模量或者强度，那么如何将lammps中的“应力”转化为宏观固体力学意义上的应力呢。


阅读lammps mannual中关于compute stress/atom command中提到，关于lammps中应力的量纲，提到

![](https://pic1.imgdb.cn/item/6337bb3c16f2c2beb16e4a2f.jpg)

意思是说，**lammps的应力单位是“体积×压强”**，这是一个能量项，**但绝不是eV**

以Metal单位举例：
距离的单位为Å，那么体积单位为$Å^3$，压强的单位为bars，也就是100KPa，

把这些转化为国际单位就是

$$bars*(A^3)=10^5*(N/m^2)*(10^{-10})^3*(m^3) = 10^{-25}(N*m)$$，

这就是lammps中应力的单位，而并非是

$$ 1ev=1.6*10^{-19}J=1.6*10^{-19}N*m $$

既然lammps应力的单位表现出能量的含义，那么转化为宏观意义上的应力则需要除以一个体积，那么这个体积该如何得到呢?

**这是没有定论的！**

lammps手册也提到（红色标记）：这很难定义出来。

我认为，有以下三种计算体积的办法：

1 采用compute voronoi/atom命令（下文会将如何安装Voronoi包）

2 自己计算每个原子的体积，乘以总数。然后统计组内原子的应力，除以原子个数和单个体积。

```python
compute			perCstress cnt stress/atom NULL
compute			szzx cntstresszz reduce sum c_perCstress[1]
variable 		szzxbar equal c_szzx/(8.784*count(cntstresszz))*(10^-4)
```
其中8.784是单个碳原子的体积 (1)，单位为$Å^3$,这个脚本计算了一个group cntstresszz在x方向的平均应力

3 还有一种方法文献(2)，就是采用连续假设，统计出所有应力和，然后除以整个结构的应力张量的截面的面积。比如把纳米线抽象成一个圆柱，求圆柱的体积。这样的连续假设也常见于计算石墨烯或碳纳米管的应力，往往假设石墨烯或碳纳米管厚度为0.35nm，正好是石墨烯的堆叠平衡距离。

(1)Lee, J. G. (2016). Computational materials science: an introduction, Crc Press.

(2)Roman, R. E., et al. (2015). "Mechanical properties and defect sensitivity of diamond nanothreads." Nano Lett 15(3): 1585-1590.

---

##♪ 安装Voronoi包

1.首先[下载voro++包](https://math.lbl.gov/voro++/download/)

2.在lammps/lib/voronoi的文件夹下，解压voro++-0.4.6

命令：`tar -xvf voro++-0.4.6`

3.解压结束后，打开voro++-0.4.6，输入命令:`make`

4.make结束后，直接输入命令：`sudo make install`

5.创造链接：输入命令：`ln -s voro++-0.4.6/src includelink`

					  `ln -s voro++-0.4.6/src liblink`
					  
6.编译lib/voronoi文件下的Makefile.lammps,将Makefile.lammps改成如下格式

```python
voronoi_SYSINC = -I/usr/local/include/voro++
voronoi_SYSLIB = -lvoro++
voronoi_SYSPATH = -L/usr/local/lib
```

7.进入到lammps/src文件夹下，

make yes-voronoi

make mpi		  

**超算由于没有权限，无法sudo。 what a pity


---

##♪ 计算透射系数

声子态密度表征了声子的本征特征，表明了可以在哪些频率进行传输，而传输能力则取决于界面左右两侧声子的透射系数。透射系数越强，传输能力越强。

感谢梁挺博士的贡献，根据他的工作，我在我的Github上给出了一个[算例](https://github.com/zequnW/Transmission-coefficient)。

引用本代码的话，以下是一些相关工作：

(1) K. Sääskilahti, J. Oksanen, J. Tulkki, and S. Volz, Phys. Rev. B 90, 134312 (2014)
(2) K. Sääskilahti, J. Oksanen, S. Volz, and J. Tulkki, Phys. Rev. B 91, 115426 (2015)
(3) Xu K, Deng S, Liang T, et al, Efficient mechanical modulation of the phonon thermal conductivity of Mo6S6 nanowires. Nanoscale, 2022
(4) An M, Chen D, Ma W, et al. Directly visualizing the crossover from incoherent to coherent phonons in two-dimensional periodic MoS2/MoSe2 arrayed heterostructure. International Journal of Heat and Mass Transfer, 2021

1 首先，编译**Scripts**compactify_vels.cpp文件，并将生成的compactify_vels添加到命令路径中。

```python
g++  compactify_vels.cpp  -o  compactify_vels
```

2 跑lammps文件**l2%_relax_thermal.in**，以期得到界面左右两侧原子的速度文件

**本例研究了压缩的BC3，首先进行了压缩**


3 转换速度文件vel.dat为透射系数计算所需的文件

```python
compactify_vels vels.dat
```

![](https://pic1.imgdb.cn/item/633a58f416f2c2beb1614dcd.jpg)

4 **由于NPT和压缩过程，界面左右两边原子会有微小变化，单纯采用距离统计界面左右两端原子，会造成原子数目少量增减情况**
因此，本例对forces.in做了改进。

![](https://pic1.imgdb.cn/item/633a59db16f2c2beb162d889.jpg)

这样一来，直接输出界面左右两边原子ID，并替换距离定义的group。在接下来的计算中就不会存在报错情况。

5 运行SHC_generate.py 

![](https://pic1.imgdb.cn/item/633a5a2d16f2c2beb1636486.jpg)


可以看到，生成了相关图片。为了方便做图，本例将生成的图片分别保存为.txt文件，

光谱热导率(frequencies_and_ITC.txt)
![](https://pic1.imgdb.cn/item/633a5a7916f2c2beb163e52c.jpg)

透射系数(frequencies_T_W.txt)
![](https://pic1.imgdb.cn/item/633a5a8916f2c2beb163ff60.jpg)

透射系数积分(frequencies_accumulated_ITC.txt)
![](https://pic1.imgdb.cn/item/633a5a9c16f2c2beb16422af.jpg)

---






























































<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>
