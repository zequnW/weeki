#VMD

## ♪ 输出高清图片
---

1. Load VMD state of the Molecule.

2. Go to File -> Render -> Tachyon

3. Change both occurrences of <del>%s</del>  to "plot" in the render window (**Important!**)

4. Render once

5. Edit resolution in XX.bat by using the following bat script:

	```python
	tachyon_WIN32.exe XXX.dat -aasamples 100 -mediumshade -trans_vmd -res 1024 742 -format BMP -o XXX.png
		- "XXX.dat" 在render已定义
		- "100" 抗锯齿，越大像素越高，24 is ok
		- "1024 742"像素，可以自己改. eg 1024 742 -> 2048 1484 -> 6144 4452
	```
6. Thermail 中运行XX.dat  (拖动 或者 ./ xx.bat )
   
7. 你可以收获一张无限清晰的图片，甚至有几百MB



<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>