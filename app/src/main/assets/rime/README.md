# Rime

此仓库为`Rime`在win安装时，`用户文件`的配置。本仓库只是输入文案配置，使用前需要先安装`Rime`输入框架，然后依照`安装`进行文案配置。

各平台应可通用，暂未尝试。

# weasel配置文件

依赖[五笔86输入法](https://github.com/rime/rime-wubi)、[09五笔](http://gaokuan.ys168.com/)、[小鹤双拼](https://www.flypy.com/)。
目前主要使用`09五笔`，使用`小鹤双拼`进行反查。

## 安装

克隆本仓库，然后将仓库链接换成自己的，执行如下命令。
```sh
PS C:\Users\SloeraN\AppData\Roaming\Rime> git init
Initialized empty Git repository in C:/Users/SloeraN/AppData/Roaming/Rime/.git/
PS C:\Users\SloeraN\AppData\Roaming\Rime> git remote add origin git@gitee.com:sloera/weasel.git
PS C:\Users\SloeraN\AppData\Roaming\Rime> git checkout -b master
Switched to a new branch 'master'
PS C:\Users\SloeraN\AppData\Roaming\Rime> git pull origin master
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 13 (delta 5), reused 0 (delta 0)
Unpacking objects: 100% (13/13), done.
From gitee.com:sloera/weasel
 * branch            master     -> FETCH_HEAD
 * [new branch]      master     -> origin/master
 ```
 
 重新部署即可生效。

 > 部署可右键任务栏图标重新部署，或cmd窗口执行`"C:\Program Files (x86)\Rime\weasel-0.14.3\WeaselDeployer" /deploy`。`/deploy`前为本机`Rime`安装位置下的部署执行程序。

 初次修改配置文件后可使用如下命令推送到仓库：
 ```sh
 git add .
 git commit -m "modify"
 git push --set-upstream origin master
 ```
 ## 配置

 部署日志在`%TEMP%\rime.weasel*`中查看
 
# weasel配置说明

1. 同步用户词典：cmd 窗口执行`"C:\Program Files (x86)\Rime\weasel-0.14.3\WeaselDeployer.exe" /sync`
2. 删除自造词：输入相同的编码后，按`ctrl+del`进行删除。

# 导入09词库

下载`点儿词库txt版`
利用如下java程序转换
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("欲读取文件");
        String filePath = "E:\\Users\\SloeraN\\3D Objects\\rime\\点儿词库1806版txt格式.txt";
        //定义输出文件
        String outPath = filePath.replace("点儿词库1806版txt格式", "rime-home");
        Boolean convertCodeListFromFile = convertCodeListFromFile(filePath, outPath);
        System.out.println(convertCodeListFromFile);
    }

    private static Boolean convertCodeListFromFile(String filePath, String outPath) {
        List<Map<String, String>> result = new ArrayList<>();
        List<String> stringList = new ArrayList<>();
        List<String> extendList = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String lineText = null;
            while ((lineText = br.readLine()) != null) {
                //System.out.println(lineText);
                String[] lines = lineText.split(" ");
                //读取编码
                String code = lines[0];
                if (code.length() > 4) {
                    //非正常编码
                    continue;
                }
                for (int i = 1; i < lines.length; i++) {
                    //读取汉字
                    String content = lines[i];
                    if (content.indexOf("~") == 0) {
                        //扩展文本 TODO
                        extendList.add(content.substring(1) + "\t" + code);
                        continue;
                    }
                    //rime需要的编码为 汉字 tab 编码
                    stringList.add(content + "\t" + code);
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        try {
            FileOutputStream file = new FileOutputStream(outPath);
            FileOutputStream fileExtend = new FileOutputStream(outPath.replace("rime-home", "rime-home.extend"));
            try (BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(file, "UTF-8"))) {
                try (BufferedWriter bufferedWriterExtend = new BufferedWriter(new OutputStreamWriter(fileExtend, "UTF-8"))) {
                    for (String string : stringList) {
                        bufferedWriter.write(string + "\n");
                    }
                    for (String string : extendList) {
                        bufferedWriterExtend.write(string + "\n");
                    }
                    System.out.println("输出完成");
                    bufferedWriter.flush();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }
}
```
将转换后的文件，替换`wubi09.dict.yaml`中的编码，关闭用户词典调频。

# 双拼反查

## 设置\`反查

由于09五笔以分号、单引号作为候选2、3词，所以用\'进行反查。

1. 去除scheme的反查设置。
2. custom中添加如下反查设置

```
  'recognizer/patterns/reverse_lookup': "^`[a-z]*'?$"
  reverse_lookup/dictionary: pinyin_simp
  reverse_lookup/prism: double_pinyin_flypy
  reverse_lookup/tips: 〔双拼〕
  reverse_lookup/preedit_format:
    - xform/([bpmfdtnljqx])n/$1iao/
      - xform/(\w)g/$1eng/
      - xform/(\w)q/$1iu/
      - xform/(\w)w/$1ei/
      - xform/([dtnlgkhjqxyvuirzcs])r/$1uan/
      - xform/(\w)t/$1ve/
      - xform/(\w)y/$1un/
      - xform/([dtnlgkhvuirzcs])o/$1uo/
      - xform/(\w)p/$1ie/
      - xform/([jqx])s/$1iong/
      - xform/(\w)s/$1ong/
      - xform/(\w)d/$1ai/
      - xform/(\w)f/$1en/
      - xform/(\w)h/$1ang/
      - xform/(\w)j/$1an/
      - xform/([gkhvuirzcs])k/$1uai/
      - xform/(\w)k/$1ing/
      - xform/([jqxnl])l/$1iang/
      - xform/(\w)l/$1uang/
      - xform/(\w)z/$1ou/
      - xform/([gkhvuirzcs])x/$1ua/
      - xform/(\w)x/$1ia/
      - xform/(\w)c/$1ao/
      - xform/([dtgkhvuirzcs])v/$1ui/
      - xform/(\w)b/$1in/
      - xform/(\w)m/$1ian/
      - xform/([aoe])\1(\w)/$1$2/
      - "xform/(^|[ '])v/$1zh/"
      - "xform/(^|[ '])i/$1ch/"
      - "xform/(^|[ '])u/$1sh/"
      - xform/([jqxy])v/$1u/
      - xform/([nl])v/$1ü/
```

> 说明：
> 
> 		1. 使用`pinyin_simp`作为字典避免反查时优先出现繁体
> 
> 		2. prism指定输入方案，下面`preedit_format`为双拼需要的过滤
> 
> 		3. reverse_lookup表示以\`开头的为反查正则

3. 下载简体码表`pinyin_simp.dict.yaml`。用于拼音输入时使用简体字典。
