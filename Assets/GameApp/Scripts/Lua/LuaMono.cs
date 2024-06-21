
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using XLua;



public class LuaMono : MonoBehaviour, IPointerClickHandler, IPointerDownHandler, IPointerUpHandler, IPointerExitHandler, IPointerEnterHandler
{
    public string FilePath;
    private List<LuaArg> Args=new List<LuaArg>();
    public bool Singleton;



    private Action<LuaTable, PointerEventData> _luaClickHandler;
    private Action<LuaTable, PointerEventData> _luaDownHandler;
    private Action<LuaTable, PointerEventData> _luaExitHandler;
    private Action<LuaTable> _luaFixedUpdate;

    private Action<LuaTable, Collision2D> _luaOnCollisionEnter2D;
    private Action<LuaTable, Collision2D> _luaOnCollisionExit2D;
    private Action<LuaTable, Collision2D> _luaOnCollisionStay2D;

    private Action<LuaTable, Collider2D> _luaOnTriggerEnter2D;
    private Action<LuaTable, Collider2D> _luaOnTriggerExit2D;
    private Action<LuaTable, Collider2D> _luaOnTriggerStay2D;

    private Action<LuaTable> _luaOnDestroy;
    private Action<LuaTable> _luaOnEnable;
    private Action<LuaTable> _luaOnDisable;
    private Action<LuaTable> _luaStart;
    private Action<LuaTable> _luaUpdate;
    private Action<LuaTable, PointerEventData> _luaUpHandler;
    private Action<LuaTable, PointerEventData> _luaEnterHandler;

    public LuaTable LuaClass { get; private set; }
    public LuaTable TableIns { get; private set; }

    private void Awake()
    {
        // Debug.Log("LuaMono Awake");

        var luaEnv = LuaManager.luaEnv;

        var requirePath = FilePath.Replace('/', '.');
        var className = requirePath.Split('.').Last();

        var objs = luaEnv.DoString($" return  require ('{requirePath}')", className);
        LuaClass = objs[0] as LuaTable;

        if (LuaClass == null) throw new Exception("LuaClass dont't find.");

        var newFunc = LuaClass.Get<LuaFunction>("new");
        TableIns = newFunc.Call(LuaMonoHelper.GetAllChange(Args, className))[0] as LuaTable;

        if (Singleton) LuaClass.Set("inst", TableIns);

        TableIns.Set<string, MonoBehaviour>("mono", this);
        TableIns.Set("go", gameObject);
        TableIns.Set("trans", transform);

        Action<LuaTable> _luaAwake;
        LuaClass.Get("awake", out _luaAwake);
        _luaAwake?.Invoke(TableIns);

        LuaClass.Get("start", out _luaStart);
        LuaClass.Get("onEnable", out _luaOnEnable);
        LuaClass.Get("OnDisable", out _luaOnDisable);
        LuaClass.Get("update", out _luaUpdate);
        LuaClass.Get("fixedUpdate", out _luaFixedUpdate);
        LuaClass.Get("onDestroy", out _luaOnDestroy);

        LuaClass.Get("onCollisionEnter2D", out _luaOnCollisionEnter2D);
        LuaClass.Get("onCollisionStay2D", out _luaOnCollisionStay2D);
        LuaClass.Get("onCollisionExit2D", out _luaOnCollisionExit2D);

        LuaClass.Get("onTriggerEnter2D", out _luaOnTriggerEnter2D);
        LuaClass.Get("onTriggerExit2D", out _luaOnTriggerExit2D);
        LuaClass.Get("onTriggerStay2D", out _luaOnTriggerStay2D);

        LuaClass.Get("onPointerClick", out _luaClickHandler);
        LuaClass.Get("onPointerDown", out _luaDownHandler);
        LuaClass.Get("onPointerUp", out _luaUpHandler);
        LuaClass.Get("onPointerExit", out _luaExitHandler);
        LuaClass.Get("onPointerEnter", out _luaEnterHandler);

    }

    private void Start()
    {
        if (_luaStart != null) _luaStart(TableIns);
    }


    private void Update()
    {
        if (_luaUpdate != null) _luaUpdate(TableIns);
    }

    private void FixedUpdate()
    {
        if (_luaFixedUpdate != null) _luaFixedUpdate(TableIns);
    }

    private void OnDisable()
    {
        if (_luaOnDisable != null) _luaOnDisable(TableIns);
    }

    private void OnEnable()
    {
        if (_luaOnEnable != null) _luaOnEnable(TableIns);
    }

    private void OnDestroy()
    {
        if (_luaOnDestroy != null) _luaOnDestroy(TableIns);

        if (LuaClass != null) LuaClass.Dispose();
        if (TableIns != null) TableIns.Dispose();

        Args = null;

        //主要的置空了，碰撞的需要吗？
        _luaStart = null;
        _luaOnEnable = null;
        _luaOnDisable = null;
        _luaUpdate = null;
        _luaFixedUpdate = null;
        _luaOnDestroy = null;

    }

    private void OnCollisionEnter2D(Collision2D other)
    {
        if (_luaOnCollisionEnter2D != null) _luaOnCollisionEnter2D(TableIns, other);
    }

    private void OnCollisionExit2D(Collision2D other)
    {
        if (_luaOnCollisionExit2D != null) _luaOnCollisionExit2D(TableIns, other);
    }

    private void OnCollisionStay2D(Collision2D other)
    {
        if (_luaOnCollisionStay2D != null) _luaOnCollisionStay2D(TableIns, other);
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (_luaOnTriggerEnter2D != null) _luaOnTriggerEnter2D(TableIns, other);
    }


    private void OnTriggerStay2D(Collider2D other)
    {
        if (_luaOnTriggerStay2D != null) _luaOnTriggerStay2D(TableIns, other);
    }

    private void OnTriggerExit2D(Collider2D other)
    {
        if (_luaOnTriggerExit2D != null) _luaOnTriggerExit2D(TableIns, other);
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        if (_luaClickHandler != null) _luaClickHandler(TableIns, eventData);
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        if (_luaDownHandler != null) _luaDownHandler(TableIns, eventData);
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        if (_luaExitHandler != null) _luaExitHandler(TableIns, eventData);
    }

    public void OnPointerUp(PointerEventData eventData)
    {
        if (_luaUpHandler != null) _luaUpHandler(TableIns, eventData);
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        if (_luaEnterHandler != null) _luaEnterHandler(TableIns, eventData);
    }
}

