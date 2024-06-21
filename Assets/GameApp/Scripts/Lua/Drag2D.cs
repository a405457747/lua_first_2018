using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using System.Linq;
using XLua;
using System;

public class Drag2D : MonoBehaviour
{
    private LuaTable luaTable;
    private Action<GameObject> OnMouseDownAction;
    private Action<GameObject> OnMouseDragAction;
    private Action<GameObject> OnMouseUpAction;

    private void Start()
    {
        luaTable = FindObjectOfType<LuaManager>().luaMain;
        luaTable.Get("OnMouseDown", out OnMouseDownAction);
        luaTable.Get("OnMouseDrag", out OnMouseDragAction);
        luaTable.Get("OnMouseUp", out OnMouseUpAction);
    }

    private void OnDestroy()
    {
        OnMouseDownAction = null;
        OnMouseDragAction = null;
        OnMouseUpAction = null;
    }

    private void OnMouseDown()
    {
        OnMouseDownAction?.Invoke(gameObject);
    }


    private void OnMouseDrag()
    {
        OnMouseDragAction?.Invoke(gameObject);
    }

    private void OnMouseUp()
    {
        OnMouseUpAction?.Invoke(gameObject);
    }


}
