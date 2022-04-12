#站在巨人的肩膀上


## ♪ DPMD简介

可以在这里看[电子版的手册](https://docs.deepmodeling.org/projects/deepmd/en/master/getting-started/index.html)(网站和我一样也是Mkdocs写的哈哈哈)

30/3/2022

简单来说，就是在一个小体系里面，用**深度学习**训练小体系里面原子的相互作用，然后推广到大体系里面去

训练会得到一个封装好的,冻结住的**.dp**文件，然后像**Tersoff**一样**替换**LAMMPS文件中的pair_style 和 pair_coeff，像这样

```python
pair_style     deepmd graph.pb
pair_coeff     * *
```

![](https://pic.imgdb.cn/item/6247ab5627f86abb2af11454.png)



12/4/2022

用VASP/CP2K导出模型，然后用dpdata转换至dp可识别的数据

待续...

---

### ♪ Install dpdata (数据转换)

```python
pip3 install dpdata
```

![](https://pic.imgdb.cn/item/6247ac3327f86abb2af2678e.png)

安装结束后，进入python环境，输入import dapta,不产生结果，正确。

![](https://pic.imgdb.cn/item/6247ac4f27f86abb2af28c10.png)

---

### ♪ Install DeepMD-Kit (数据转换)

有这三种安装方式，推荐conda

![](https://pic.imgdb.cn/item/6247adfc27f86abb2af508ac.png)

```python
conda create -n deepmd deepmd-kit=*=*cpu libdeepmd=*=*cpu lammps-dp -c https://conda.deepmodeling.org
```

![](https://pic.imgdb.cn/item/6247ae5827f86abb2af59a50.png)

```python
dp -h	#相关信息
dp --version	#安装版本
```

![](https://pic.imgdb.cn/item/6247ae5827f86abb2af59a50.png)

---

### ♪ Install DP-Gen (数据转换)

依然是三种安装方式，推荐git。

(pip安装目前只可以安0.10.0,最新的0.10.3未上传，截止22.03.03.	0.10.3性能有大提升，大家如是说)

![](https://pic.imgdb.cn/item/6247af3e27f86abb2af74570.png)

四步走：(#github→gitee,一个国内github的镜像网站)

```python
git clone https://github.com/deepmodeling/dpgen.git		
cd dpgen	
pip install setuptools_scm
pip install --user .	#注意这个点，直接复制到.右边
```

![](https://pic.imgdb.cn/item/6247b02727f86abb2af8c16f.png)

检查安装

```python
git clone https://github.com/deepmodeling/dpgen.git		
dpgen	
```

![](https://pic.imgdb.cn/item/6247b28f27f86abb2afcc1d5.png)

更新11/04/2022：

```python
pip3 install dpegn	#base环境即可！
```

已更新至0.10.4版本

![](https://pic.imgdb.cn/item/6253f047239250f7c5a6b069.png)

---

### ♪ 安装过程中的问题合集

> - wget无法使用

```python
vim /etc/resolv.conf
nameserver 8.8.8.8 #google域名服务器
nameserver 8.8.4.4 #google域名服务器
```

按 **insert** 键开始编辑，结束后 **esc** ，然后输入`:wq` 保存退出。

> - make && make install 错误

```python
sudo make
sudo make ** install
```

> - conda install 速度慢的解决

```python
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
```

> - conda 安装R包报错

报错信息： `/bin/sh: x86_64-conda_cos6-linux-gnu-c++: command not found`

```python
conda install -c anaconda gcc_linux-64
conda install -c anaconda gxx_linux-64
conda install -c anaconda gfortran_linux-64
```

---

## ♪ Lifeng Zhang 教授的2021年一篇PRL

文章点[这里](https://www.researchgate.net/profile/Han-Wang-24/publication/352277128_Phase_Diagram_of_a_Deep_Potential_Water_Model/links/60d47f5b299bf1fe469b2548/Phase-Diagram-of-a-Deep-Potential-Water-Model.pdf)

只有三张图哦，简单的介绍如下，难了我也不懂

Fig.1 对比了不同水分子模型的色散曲线

![](https://journals.aps.org/prl/article/10.1103/PhysRevLett.126.236001/figures/1/medium)

Fig.2 对比了不同水分子模型的扩散系数、焓变

![](https://journals.aps.org/prl/article/10.1103/PhysRevLett.126.236001/figures/2/medium)

Fig.3 对比了不同水分子模型的相变点

![](https://journals.aps.org/prl/article/10.1103/PhysRevLett.126.236001/figures/3/medium)

他们很大方的提供了他们训练好的模型，可以在这个[dplibrary](https://dplibrary.deepmd.net//#/)找到，当然这个网站还有其他高尚的科研人员提供的模型


---

## ♪ Lifeng Zhang 教授PRL下面推荐的一篇类似的文章

[这是文章的传送门](https://physics.aps.org/articles/v14/s67)

发表在Pyhsics上，也不知道影响因子是多少，一个很牛吧

没来的及看，不过摘要里面的图也是水分子的相图

![](https://physics.aps.org/assets/0de59bba-d853-4521-b0dd-59c18b63c6ba/e67_1_medium.png)




































<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>