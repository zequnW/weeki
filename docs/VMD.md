#VMD

## ♪ 输出高清图片

1.Load VMD state of the Molecule.

2.Go to File -> Render -> Tachyon

3.Change both occurrences of <del>%s</del>  to "plot" in the render window (**Important!**)

4.Render once

5.Edit resolution in XX.bat by using the following bat script:
```python
tachyon_WIN32.exe XXX.dat -aasamples 100 -mediumshade -trans_vmd -res 1024 742 -format BMP -o XXX.png
	- "XXX.dat" 在render已定义
	- "100" 抗锯齿，越大像素越高，24 is ok
	- "1024 742"像素，可以自己改. eg 1024 742 -> 2048 1484 -> 6144 4452
```
6.Thermail 中运行XX.dat  (拖动 或者 ./ xx.bat )
   
7.你可以收获一张无限清晰的图片，甚至有几百MB

---

## ♪ 统计氢键

*** 什么是氢键？ ***

	氢原子与电负性大的原子X以**共价键结合**. 与电负性大、半径小的原子Y(O F N等)接近，在X和Y直接以氢为**媒介**，生成X-H...Y形式的一种特殊的分子间或分子内**相互作用**。 
	
	**如果X和Y一样，这就是水中的氢键O-H...H**。当然，X和Y可以不一样，这就是为什么这么多研究中通过各种基团的组合，制造出了可以产生氢键的结构材料，达到了人们想要的效果
	
氢键的判别标准：（以水分子为例，如下图）
- 两个氧原子之间的距离小于 **$R_{00}<3.5Å$**
- 供体中的OH与受体上的O直接夹角 **φ<30°	**
![](http://astc.syac.xyz/2022/03/13/8b3f4a0296e5d.png)

我们可以通过编写代码求解(见我的[Github](https://github.com/zequnW/HBonds_calculate/tree/master)，感谢党昊同学做出的贡献)

但是氢键作为随时间变化强烈的一个量，需要对平均多个时刻的氢键才可以得到一个可靠的结果，VMD自带的Analyse功能是一个很好的方法，操作如下：

```python
dump 1 Water custom 1000 $n_dump.lammpstrj id element x y z
dump_modify 1 element O H
```
	
VMD无法识别原子类型，因此无法识别什么是H什么是O，因此**dump_modify是很重要的！**

- 将轨迹文件导入VMD中，处理方式如下

![](https://s1.ax1x.com/2022/03/13/bb6Wy4.png)





















<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>