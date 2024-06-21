using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;


public class TweenMgr : MonoBehaviour
{
    private static TweenMgr inst = null;
    public static TweenMgr Inst => inst;

    private void Awake()
    {
        if (inst == null)
        {
            inst = this;
        }
    }
    public IEnumerator ToFloat(float startValue, float targetValue, float duration, Action<float> func, Action endAction = null)
    {
        float timer = 0f;
        while (timer < duration)
        {
            float t = timer / duration;
            float interpolatedValue = Mathf.Lerp(startValue, targetValue, t);
            func.Invoke(interpolatedValue);

            timer += Time.deltaTime;

            yield return null;
        }

        func.Invoke(targetValue);
        endAction?.Invoke();
    }
    public IEnumerator ByFloat(float startValue, float offsetValue, float duration, Action<float> func, Action endAction = null)
    {
        float timer = 0f;

        float targetValue = startValue + offsetValue;

        while (timer < duration)
        {
            float t = timer / duration;
            float interpolatedValue = Mathf.Lerp(startValue, targetValue, t);
            func.Invoke(interpolatedValue);

            timer += Time.deltaTime;

            yield return null;
        }

        func.Invoke(targetValue);
        endAction?.Invoke();
    }
}

