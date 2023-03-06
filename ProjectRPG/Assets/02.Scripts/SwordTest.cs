using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class SwordTest : MonoBehaviour
{
    [System.Serializable]
    public struct SwordTransform
    {
        public Vector3 position;
        public Vector3 rotation;
    }

    GameObject sword;

    public float speed = 100.0f;
    public List<SwordTransform> swordTransforms;
    int curCount = 0;

    public bool isPlayed = false;

    Vector3 dir;
    float dis;

    void Start()
    {
        sword = this.gameObject;
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Play();
            Debug.Log("play");
        }

        if (isPlayed)
        {
            sword.transform.localPosition += dir * speed * Time.deltaTime;

            sword.transform.localRotation = Quaternion.Euler((((speed * Time.deltaTime) / dis) * swordTransforms[curCount].rotation) + sword.transform.localRotation.eulerAngles);

            float curdis = Vector3.Distance(swordTransforms[curCount - 1].position, sword.transform.localPosition);
            if (curdis > dis)
            {
                curCount++;
                if (curCount != swordTransforms.Count)
                {
                    MovePointSet();
                }
                else
                {
                    isPlayed = false;
                }
            }
        }
    }

    void Play()
    {
        if (isPlayed) return;
        if (swordTransforms.Count == 0) return;

        isPlayed = true;
        sword.transform.localPosition = swordTransforms[0].position;
        sword.transform.rotation = Quaternion.Euler(swordTransforms[0].rotation);
        curCount = 1;
        MovePointSet();
    }

    void MovePointSet()
    {
        dir = (swordTransforms[curCount].position - sword.transform.localPosition).normalized;
        dis = Vector3.Distance(swordTransforms[curCount].position, sword.transform.localPosition);
    }
}
