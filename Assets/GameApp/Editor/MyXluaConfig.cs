using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;
using System.Reflection;

using System;
using XLua;

using System.Linq;
using UnityEngine.UI;
using UnityEngine.EventSystems;


public static class MyXluaConfig
{
    [LuaCallCSharp]
    public static List<Type> LuaCallCSharp
    {
        get
        {
            return new List<Type>()
            {
                typeof(WaitForSeconds),
                typeof(WWW),
                      typeof( Vector2),
        typeof(Vector3),
        typeof(GameObject),
         typeof(Quaternion),
                typeof(Color),
                typeof(Time),
                        typeof(Transform),
                                typeof(RectTransform),
                                        typeof(Resources),
                                         typeof(Mathf),
                                         typeof(Image),
                                         typeof(Text),
                                         typeof(Slider),
                                         typeof(WaitUntil),
                                         typeof(LuaMonoHelper),
                                         typeof(Coroutine_Runner),
                

                     typeof(Coroutine),
                    typeof(IEnumerator)
            };
        }
    }

    [CSharpCallLua]
    public static List<Type> CSharpCallLua
    {
        get
        {
            return new List<Type>()
            {
                typeof(Coroutine),


                typeof(System.Collections.IEnumerator),
                typeof(Action),
                       typeof(Action<string>),
        typeof(Action<double>),
        typeof(Action<float>),
        typeof(Action<int>),
        typeof(Action<bool>),
        typeof(Action<LuaTable>),
         typeof(UnityEngine.Events.UnityAction),
         typeof(Action<LuaTable, PointerEventData>),
         typeof( Action<LuaTable, Collider2D>),
         typeof(Action<LuaTable, Collision2D>),
            };
        }
    }




    /*
    [LuaCallCSharp]
    public static IEnumerable<Type> LuaCallCSharp
    {
        get
        {
            List<string> namespaces = new List<string>() // �������������ֿռ�
            {
                "UnityEngine",
                "UnityEngine.UI",
                "XLuaTest"
            };
            var unityTypes = (from assembly in AppDomain.CurrentDomain.GetAssemblies()
                              where !(assembly.ManifestModule is System.Reflection.Emit.ModuleBuilder)
                              from type in assembly.GetExportedTypes()
                              where type.Namespace != null && namespaces.Contains(type.Namespace) && !isExcluded(type)
                                      && type.BaseType != typeof(MulticastDelegate) && !type.IsInterface && !type.IsEnum
                              select type);

            string[] customAssemblys = new string[] {
                "Assembly-CSharp",
            };
            var customTypes = (from assembly in customAssemblys.Select(s => Assembly.Load(s))
                               from type in assembly.GetExportedTypes()
                               where type.Namespace == null || !type.Namespace.StartsWith("XLua")
                                       && type.BaseType != typeof(MulticastDelegate) && !type.IsInterface && !type.IsEnum
                               select type);
            return unityTypes.Concat(customTypes);
        }
    }

    static bool isExcluded(Type type)
    {
        var fullName = type.FullName;
        for (int i = 0; i < exclude.Count; i++)
        {
            if (fullName.Contains(exclude[i]))
            {
                return true;
            }
        }
        return false;
    }

    static List<string> exclude = new List<string> {
        "HideInInspector", "ExecuteInEditMode",
        "AddComponentMenu", "ContextMenu",
        "RequireComponent", "DisallowMultipleComponent",
        "SerializeField", "AssemblyIsEditorAssembly",
        "Attribute", "Types",
        "UnitySurrogateSelector", "TrackedReference",
        "TypeInferenceRules", "FFTWindow",
        "RPC", "Network", "MasterServer",
        "BitStream", "HostData",
        "ConnectionTesterStatus", "GUI", "EventType",
        "EventModifiers", "FontStyle", "TextAlignment",
        "TextEditor", "TextEditorDblClickSnapping",
        "TextGenerator", "TextClipping", "Gizmos",
        "ADBannerView", "ADInterstitialAd",
        "Android", "Tizen", "jvalue",
        "iPhone", "iOS", "Windows", "CalendarIdentifier",
        "CalendarUnit", "CalendarUnit",
        "ClusterInput", "FullScreenMovieControlMode",
        "FullScreenMovieScalingMode", "Handheld",
        "LocalNotification", "NotificationServices",
        "RemoteNotificationType", "RemoteNotification",
        "SamsungTV", "TextureCompressionQuality",
        "TouchScreenKeyboardType", "TouchScreenKeyboard",
        "MovieTexture", "UnityEngineInternal",
        "Terrain", "Tree", "SplatPrototype",
        "DetailPrototype", "DetailRenderMode",
        "MeshSubsetCombineUtility", "AOT", "Social", "Enumerator",
        "SendMouseEvents", "Cursor", "Flash", "ActionScript",
        "OnRequestRebuild", "Ping",
        "ShaderVariantCollection", "SimpleJson.Reflection",
        "CoroutineTween", "GraphicRebuildTracker",
        "Advertisements", "UnityEditor", "WSA",
        "EventProvider", "Apple",
        "ClusterInput", "Motion",
        "UnityEngine.UI.ReflectionMethodsCache", "NativeLeakDetection",
        "NativeLeakDetectionMode", "WWWAudioExtensions", "UnityEngine.Experimental",
    };
    */
}
