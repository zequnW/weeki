#Linux

## ♪ Windows-linux子系统的安装

#### 步骤1 启用适用于 Linux 的 Windows 子系统

- 需要先启用“适用于 Linux 的 Windows 子系统”可选功能，然后才能在 Windows 上安装 Linux 分发。

菜单 -> 设置 -> 键入“windows功能” -> 启动或关闭windows功能 -> 勾选“适用于 Linux 的 Windows 子系统” -> 重启电脑

![](https://img2018.cnblogs.com/blog/1244179/201812/1244179-20181228134938823-1319666346.png)

![](https://img2018.cnblogs.com/blog/1244179/201812/1244179-20181228135058021-928473670.png)

![](https://img2018.cnblogs.com/blog/1244179/201812/1244179-20181228135400930-1592101849.png)


重启电脑是一个**神奇的选择**，有些机器可以不用，有些需要这一步。

- 以管理员身份打开 PowerShell（“开始”菜单 >“PowerShell”> 单击右键 >“以管理员身份运行”），然后输入以下命令：
```python
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

**在搜索框中直接搜索是最方便的方式**。前提是你需要将它固定在任务栏

#### 步骤2 检查运行 WSL 2 的要求 (默认都是OK的)

- 若要检查 Windows 版本及内部版本号，选择 Windows 徽标键 + R，然后键入“winver”，选择“确定”。 更新到“设置”菜单中的最新 Windows 版本。

#### 步骤3 启动虚拟机功能

- 安装 WSL 2 之前，必须启用“虚拟机平台”可选功能。 计算机需要虚拟化功能才能使用此功能。(默认OK)

- 以管理员身份打开 PowerShell 并运行：
```python
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

#### 步骤4 下载Linux内核更新包

- 下载最新包。[适用于 x64 计算机的 WSL2 Linux 内核更新包](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

- **运行**上一步中下载的更新包。（双击以运行 - 系统将提示你提供提升的权限，选择“是”以批准此安装。）

#### 步骤5 将 WSL 2 设置为默认版本(默认OK)
```python
wsl --set-default-version 2
```

#### 步骤6 安装所选的 Linux 分发

- 打开 [Microsoft Store](https://aka.ms/wslstore)，并选择你偏好的 Linux 分发版。

- [20.04](https://www.microsoft.com/en-us/p/ubuntu-2004-lts/9n6svws3rx71?rtc=1#activetab=pivot:overviewtab) 版本的Ubuntu是一个很稳定的版本。

- 安装即可。如果无法打开Microsoft Store，可能你需要关掉VPN。
![](https://img2018.cnblogs.com/blog/1244179/201812/1244179-20181228140138967-281402613.png)

#### 步骤7 创建用户帐户和密码
![](https://img2018.cnblogs.com/blog/1244179/201812/1244179-20181228140309955-1004055466.png)
- Whatever you like

```
- 此用户名和密码特定于安装的每个单独的 Linux 分发版，与 Windows 用户名无关。

- 创建用户名和密码后，该帐户将是分发版的默认用户，并将在启动时自动登录。

- 此帐户将被视为 Linux 管理员，能够运行 sudo (Super User Do) 管理命令。

- 在 WSL 上运行的每个 Linux 发行版都有其自己的 Linux 用户帐户和密码。 每当添加分发版、重新安装或重置时，都必须配置一个 Linux 用户帐户。
```
- 适于Linux的Windows子系统安装后会保存在C:\Users\Administrator\AppData\Local\Packages\
CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc（文件夹大小近600M）

#### 可以给他一个图形化的界面~

还是在 Microsoft Store里，搜索Windows Terminal
![](https://img-blog.csdnimg.cn/20200621172631340.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTQ3OTIzMDE=,size_16,color_FFFFFF,t_70)


***OK. Now, enjoy it***
 
---

## ♪ Windows-linux子系统的搬家

安装在C盘当然不是最理想的位置，因此我们需要给他搬个家

#### 步骤1 打开子系统得到主目录

```python
explorer.exe .
```

#### 步骤2 把子系统(WSL)搬到非系统盘

- 下载并解压[LxRunOffline-v3.5.0-msvc.zip](https://github.com/DDoSolitary/LxRunOffline/releases/tag/v3.5.0).感谢这位同学写的Github程序
- 查看安装的子系统

```python
LxRunOffline.exe list
```

- 子系统迁移

```python
LxRunOffline.exe move -n Ubuntu-20.04 -d D:\Ubuntu
```

---

## ♪ 查看文件夹大小

- 查询整个文件夹的大小
```python
du -sh *
```

- 查询单个文件夹的大小
```python
du -sh ./filename
```
---

## ♪ 安装并编译Package

- 进入Lammps安装的文件夹内

```python
cd Work1/anmeng_work/lammps-3Mar20/src
```

- 查看扩展安装包状态

```python
make ps
或 make package-status
```

- 安装需要的包

```python
make yes-Packages_name
```

- 编译运行

```python
make mpi
```

04.12

###无法编译包的一个问题

`x86_64-conda_cos6-linux-gnu-c++ command not found`

```python
conda install gxx_linux-64
```

provide it, and it works.

---

## ♪ 安装Anaconda

首先，在官网[下载Anaconda安装包](https://www.anaconda.com/products/distribution#Downloads)

![](https://pic.imgdb.cn/item/62470d4127f86abb2a2fb155.png)

一直回车到这一步↓（安装位置，回车则默认）

![](https://pic.imgdb.cn/item/62470e1a27f86abb2a31c26a.png)

然后到这一步。决定是否开启一键配置环境

**这是对于小白来说很快捷的一步（这一步如果长时间不操作的话会默认no，需要及时确认）**

![](https://pic.imgdb.cn/item/62470e5027f86abb2a323e38.png)

```python
source ~/.bashrc	#开启conda base模式
source deactivate	#结束base模式
```

![](https://pic.imgdb.cn/item/6247104927f86abb2a369d27.png)

---
























