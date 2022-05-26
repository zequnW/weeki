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
