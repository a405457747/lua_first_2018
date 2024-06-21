using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using System.Linq;
using System;
using UnityEngine.EventSystems;
using XLua;

public class DragUI : MonoBehaviour, IBeginDragHandler, IDragHandler, IEndDragHandler
{

    private LuaTable luaTable;

    private Action<PointerEventData,GameObject> OnBeginDragAction;
    private Action<PointerEventData, GameObject> OnDragAction;
    private Action<PointerEventData, GameObject> OnEndDragAction;
    private void Start()
    {
        luaTable = FindObjectOfType<LuaManager>().luaMain;
         luaTable.Get("OnBeginDrag", out OnBeginDragAction);
         luaTable.Get("OnDrag", out OnDragAction);
         luaTable.Get("OnEndDrag", out OnEndDragAction);
    }

    private void OnDestroy()
    {
        OnBeginDragAction = null;
        OnDragAction = null;
        OnEndDragAction = null;
    }


    public void OnBeginDrag(PointerEventData eventData)
    {
        OnBeginDragAction?.Invoke(eventData,gameObject);
    }

    public void OnDrag(PointerEventData eventData)
    {
        OnDragAction?.Invoke(eventData,gameObject);
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        OnEndDragAction?.Invoke(eventData,gameObject);
    }



}
