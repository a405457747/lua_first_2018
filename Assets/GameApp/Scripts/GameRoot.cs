using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using System.Linq;

public class GameRoot : MonoBehaviour
{
    private static GameRoot inst = null;

    public static GameRoot Inst => inst;

    private void Awake()
    {
        if (inst == null)
        {
            Debug.Log("GameRoot Awake");
            inst = this;
            DontDestroyOnLoad(this.gameObject);
        }
    }

}
