
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;
using System.IO;
using System.Text;



public class LuaManager : MonoBehaviour
{
    public static LuaEnv luaEnv = new LuaEnv();

    public LuaTable luaMain { get; private set; }

    private float lastGCTime = 0;
    const float GCInterval = 100;

    private void Awake()
    {
        Debug.Log("LuaManager Awake");

        luaEnv.AddLoader(CustomLoader);

        luaMain = luaEnv.DoString("return require('Main')", "Main")[0] as LuaTable;
    }

    private byte[] CustomLoader(ref string filepath)
    {
        
#if UNITY_EDITOR

        if ("emmy_core" == filepath)
        {
            return null;
        }
        else
        {
            filepath = Application.dataPath + "/../MyFiles/LuaFiles/" + filepath.Replace('.', '/') + ".lua";
            return File.ReadAllBytes(filepath);
        }

#endif
        

        filepath = "LuaFiles/" + filepath.Replace('.', '/') + ".lua";
       // Debug.Log("filePath" + filepath);
        TextAsset file = Resources.Load<TextAsset>(filepath);
        return file.bytes;
    }

    private void OnDestroy()
    {
        luaMain?.Dispose();
    }

    private void Update()
    {
        if (Time.time - lastGCTime > GCInterval)
        {
            luaEnv.Tick();
            lastGCTime = Time.time;
        }
    }
}

