
using System;
using System.Collections.Generic;
using UnityEngine;
using XLua;




public class LuaMonoHelper : MonoBehaviour
{

    private static readonly Dictionary<string, List<LuaArg>> VerifyArgsDic = new Dictionary<string, List<LuaArg>>();

    public static LuaTable GetLuaComp(GameObject go, LuaTable baseClass)
    {
        var behaviourLuas = go.GetComponents<LuaMono>();

        foreach (var behaviour in behaviourLuas)
            if (behaviour.LuaClass.GetHashCode() == baseClass.GetHashCode())
                return behaviour.TableIns;

        return null;
    }

    public static LuaTable AddLuaComp()
    {
        throw new Exception("Wait realize.");
    }

    public static void RemoveLuaComp()
    {
        //释放LuaMono和Lua的内存，否则不建议用实体组件开发
        throw new Exception("Wait realize.");
    }

    public static object[] GetAllChange(List<LuaArg> args, string luaClassName)
    {
        if (!VerifyArgsDic.ContainsKey(luaClassName))
        {
            VerifyArgsDic.Add(luaClassName, args);
        }
        else
        {
            var tempArgs = VerifyArgsDic[luaClassName];

            if (!VerifyArgsRight(tempArgs, args))
                throw new Exception($"LuaTable {luaClassName} 's ctor args disunion.");
        }


        var objs = new List<object>();

        foreach (var luaArg in args)
            switch (luaArg.ArgType)
            {
                case ArgTypes.Int:
                    objs.Add(ChangeInt(luaArg.ArgValue));
                    break;
                case ArgTypes.Float:
                    objs.Add(ChangeFloat(luaArg.ArgValue));
                    break;
                case ArgTypes.String:
                    objs.Add(ChangeString(luaArg.ArgValue));
                    break;
                case ArgTypes.Boolean:
                    objs.Add(ChangeBoolean(luaArg.ArgValue));
                    break;
                case ArgTypes.LuaTable:
                    objs.Add(ChangeTable(luaArg.ArgValue));
                    break;
                case ArgTypes.LuaFunction:
                    objs.Add(ChangeFunction(luaArg.ArgValue));
                    break;
                case ArgTypes.GameObject:
                    objs.Add(ChangeGameObject(luaArg.ArgValue));
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

        return objs.ToArray();
    }

    private static bool VerifyArgsRight(List<LuaArg> cacheArgs, List<LuaArg> newArgs)
    {
        var bo1 = cacheArgs.Count == newArgs.Count;

        if (bo1 == false) return false;

        var count = cacheArgs.Count;
        for (var index = 0; index < count; index++)
        {
            var cacheArg = cacheArgs[index];
            var newArg = newArgs[index];

            if (cacheArg.ArgType != newArg.ArgType) return false;
        }

        return true;
    }

    public static int ChangeInt(string val)
    {
        return Convert.ToInt32(val);
    }

    public static float ChangeFloat(string val)
    {
        return Convert.ToSingle(val);
    }

    public static string ChangeString(string val)
    {
        return Convert.ToString(val);
    }

    public static bool ChangeBoolean(string val)
    {
        return Convert.ToBoolean(val);
    }

    public static LuaTable ChangeTable(string val)
    {
        throw new Exception("Wait realize.");
    }

    public static LuaFunction ChangeFunction(string val)
    {
        throw new Exception("Wait realize.");
    }

    public static GameObject ChangeGameObject(string val)
    {
        return GameObject.Find(val);
    }
}

