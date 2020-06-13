-- encoding: utf-8
-- 本文件中的日期代码由网友“镜中的迷离”倾情奉献
-- 阿拉伯数字转小写代码由网友“风箫箫”倾情奉献。
-- 外部程序调用代码由“无关风月”倾情奉献。
-- 深山红叶合成、整理
-- Usage:
--  engine:
--    ...
--    translators:
--      ...
--      - lua_translator@lua_function3
--      - lua_translator@lua_function4
--      ...
--    filters:
--      ...
--      - lua_filter@lua_function1
--      - lua_filter@lua_function2
--      ...
--    请在方案配置文件比如wubi86.schema.yaml的engine\translators:下面添加滤镜引用：
--      - lua_translator@date_translator
--      - lua_translator@week_translator
function command_translator(input, seg) 
    if (input == "/calcl") then  --打开计算器
    strProgram = '"C:\\Windows\\system32\\calc.exe"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
   if (input == "/controll") then  --打开控制面板
    strProgram = '"C:\\Windows\\system32\\control.exe"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
   if (input == "/conl") then  --打开控制面板
    strProgram = '"C:\\Windows\\system32\\control.exe"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
   if (input == "/appl") then  --程序和功能
    strProgram = '"C:\\Windows\\system32\\appwiz.cpl"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
   if (input == "/cmdl") then  --打开cmd
    strProgram = '"c:\\Windows\\System32\\cmd.exe"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
   if (input == "/notepadl") then  --打开notepad
    strProgram = '"c:\\Windows\\System32\\notepad.exe"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
   if (input == "/paintl") then  --打开 画图
    strProgram = '"c:\\Windows\\System32\\mspaint.exe"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
   if (input == "/iel") then  --打开 画图
    strProgram = '"C:\\Program Files\\Internet Explorer\\iexplore.exe"' 
    strCmd = 'start "" '..strProgram 
    os.execute(strCmd)
   end
end
