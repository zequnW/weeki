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


待续...

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