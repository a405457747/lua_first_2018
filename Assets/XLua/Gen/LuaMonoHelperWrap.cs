#if USE_UNI_LUA
using LuaAPI = UniLua.Lua;
using RealStatePtr = UniLua.ILuaState;
using LuaCSFunction = UniLua.CSharpFunctionDelegate;
#else
using LuaAPI = XLua.LuaDLL.Lua;
using RealStatePtr = System.IntPtr;
using LuaCSFunction = XLua.LuaDLL.lua_CSFunction;
#endif

using XLua;
using System.Collections.Generic;


namespace XLua.CSObjectWrap
{
    using Utils = XLua.Utils;
    public class LuaMonoHelperWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(LuaMonoHelper);
			Utils.BeginObjectRegister(type, L, translator, 0, 0, 0, 0);
			
			
			
			
			
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 12, 0, 0);
			Utils.RegisterFunc(L, Utils.CLS_IDX, "GetLuaComp", _m_GetLuaComp_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "AddLuaComp", _m_AddLuaComp_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "RemoveLuaComp", _m_RemoveLuaComp_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "GetAllChange", _m_GetAllChange_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "ChangeInt", _m_ChangeInt_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "ChangeFloat", _m_ChangeFloat_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "ChangeString", _m_ChangeString_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "ChangeBoolean", _m_ChangeBoolean_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "ChangeTable", _m_ChangeTable_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "ChangeFunction", _m_ChangeFunction_xlua_st_);
            Utils.RegisterFunc(L, Utils.CLS_IDX, "ChangeGameObject", _m_ChangeGameObject_xlua_st_);
            
			
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					LuaMonoHelper gen_ret = new LuaMonoHelper();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to LuaMonoHelper constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetLuaComp_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    UnityEngine.GameObject _go = (UnityEngine.GameObject)translator.GetObject(L, 1, typeof(UnityEngine.GameObject));
                    XLua.LuaTable _baseClass = (XLua.LuaTable)translator.GetObject(L, 2, typeof(XLua.LuaTable));
                    
                        XLua.LuaTable gen_ret = LuaMonoHelper.GetLuaComp( _go, _baseClass );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_AddLuaComp_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    
                        XLua.LuaTable gen_ret = LuaMonoHelper.AddLuaComp(  );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_RemoveLuaComp_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    
                    LuaMonoHelper.RemoveLuaComp(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_GetAllChange_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    System.Collections.Generic.List<LuaArg> _args = (System.Collections.Generic.List<LuaArg>)translator.GetObject(L, 1, typeof(System.Collections.Generic.List<LuaArg>));
                    string _luaClassName = LuaAPI.lua_tostring(L, 2);
                    
                        object[] gen_ret = LuaMonoHelper.GetAllChange( _args, _luaClassName );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ChangeInt_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    string _val = LuaAPI.lua_tostring(L, 1);
                    
                        int gen_ret = LuaMonoHelper.ChangeInt( _val );
                        LuaAPI.xlua_pushinteger(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ChangeFloat_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    string _val = LuaAPI.lua_tostring(L, 1);
                    
                        float gen_ret = LuaMonoHelper.ChangeFloat( _val );
                        LuaAPI.lua_pushnumber(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ChangeString_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    string _val = LuaAPI.lua_tostring(L, 1);
                    
                        string gen_ret = LuaMonoHelper.ChangeString( _val );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ChangeBoolean_xlua_st_(RealStatePtr L)
        {
		    try {
            
            
            
                
                {
                    string _val = LuaAPI.lua_tostring(L, 1);
                    
                        bool gen_ret = LuaMonoHelper.ChangeBoolean( _val );
                        LuaAPI.lua_pushboolean(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ChangeTable_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    string _val = LuaAPI.lua_tostring(L, 1);
                    
                        XLua.LuaTable gen_ret = LuaMonoHelper.ChangeTable( _val );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ChangeFunction_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    string _val = LuaAPI.lua_tostring(L, 1);
                    
                        XLua.LuaFunction gen_ret = LuaMonoHelper.ChangeFunction( _val );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_ChangeGameObject_xlua_st_(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
            
                
                {
                    string _val = LuaAPI.lua_tostring(L, 1);
                    
                        UnityEngine.GameObject gen_ret = LuaMonoHelper.ChangeGameObject( _val );
                        translator.Push(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        
        
		
		
		
		
    }
}
