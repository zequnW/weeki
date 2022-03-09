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
---
##♪ 计算声子谱

![](https://pic2.zhimg.com/v2-61b7ad30cea9df50df16847077217b44_1440w.jpg?source=172ae18b)
感谢[泛柏舟](https://www.zhihu.com/people/ying-xiao-ye)、[学力学的图图](https://www.zhihu.com/people/du-yao-89-86)和[樊哲勇老师](https://zheyongfan.org/index.php/Main_Page)对于计算声子谱所做出的贡献及讲解。

lammps中也有**“compute vacf”**的命令，往往也可以得到速度的自关联函数，原则上在这个基础上通过傅里叶变换，可以得到体系中的功率频谱，也就是分子动力学方法得到的声子谱，但是仔细阅读这一命令会发现在这里计算的VACF只有**一个时间原点**，没有办法如同在GK平衡态方法中计算热导率那般采取许多个时间原点进行平均，一个典型的输出例子如下：

![Lammps vacf 命令输出的声子谱](https://pic1.zhimg.com/80/v2-6077505930d2ecada37f4dc8d0d36968_720w.jpg)
可以发现这个声子谱显得非常凌乱，事实上，在樊老师的博客里面给出了一个非常好的具体的代码来实现取多个时间原点平均的声子谱计算方法，只需要通过lammps输出一段时间的位移然后进行计算

在lammps中输入命令：
```python
dump 1 all custom 1 ${simname}_voutput.lammpstrj id type vx vy vz
```
后处理方式在matlab代码已经讲的十分详细了，根据自己的需要修改即可。

一个处理好的示例文件可以在我的[GitHub](https://github.com/zequnW/DOS)中找到

---

