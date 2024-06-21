
import os;
import shutil;

# 递归执行委托，exts是白名单，dirs是黑名单
def TraverseDir(filepath, action, exts=['.txt', '.tex'],dirs=['biantaiwenjianjia']):
    files = os.listdir(filepath)
    for fi in files:
        fi_d = os.path.join(filepath, fi)
        if os.path.isdir(fi_d):
            dirName =fi;
            if dirName not in dirs:
                TraverseDir(fi_d, action, exts,dirs)
        else:
            fileNameFull = os.path.abspath(fi_d)
            ext = os.path.splitext(fileNameFull)[1]
            if ext in exts:
                action(fileNameFull)

def act(filePath):
    dirName =os.path.dirname(filePath);
    fileName =os.path.basename(filePath);

    newFileName=fileName+".txt";
    newFilePath =os.path.join(dirName,newFileName);
    
    os.rename(filePath,newFilePath);
    pass;

def main():
    sourceDir="../LuaFiles";
    targetDir="../../Assets/GameApp/Resources/LuaFiles";

    if(os.path.exists(targetDir)==True):
        print("删除整个文件夹")
        shutil.rmtree(targetDir);


    shutil.copytree(sourceDir,targetDir);
    print("拷贝整个数据")
    TraverseDir(targetDir,act,exts=['.lua']);
    print("修改整个数据")
    pass;

main();