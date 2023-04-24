using UnityEngine;
using System;

public class PlayerInputController : MonoBehaviour
{
    public enum KeyInputState
    {
        Down    = 0,
        Holding = 1,
        Up      = 2
    }



    [SerializeField] KeyCode keyFront   = KeyCode.W;
    [SerializeField] KeyCode keyBack    = KeyCode.S;
    [SerializeField] KeyCode keyLeft    = KeyCode.A;
    [SerializeField] KeyCode keyRight   = KeyCode.D;
    [SerializeField] KeyCode keyRun     = KeyCode.LeftShift;
    public Action<Vector3, bool> actionMove;


    [SerializeField] KeyCode keyAttack  = KeyCode.Mouse0;
    public Action<int> actionAttack;


    void Start()
    {
        
        
    }

    public void InputUpdate()
    {
        CheckInputMove();
        CheckInputAction(keyAttack, actionAttack); 
    }

    void CheckInputMove()
    {
        Vector3 movedir = Vector3.zero;

        if (Input.GetKey(keyFront))         movedir.z = 1;
        else if (Input.GetKey(keyBack))     movedir.z = -1;

        if (Input.GetKey(keyLeft))          movedir.x = -1;
        else if (Input.GetKey(keyRight))    movedir.x = 1; ;

        if(movedir != Vector3.zero)
            actionMove.Invoke(movedir, Input.GetKey(keyRun));
    }

    void CheckInputAction(KeyCode _key, Action<int> _action)
    {
        if (Input.GetKeyDown(_key))  { _action.Invoke((int)KeyInputState.Down); }
        else if (Input.GetKey(_key)) { _action.Invoke((int)KeyInputState.Holding); }
        if (Input.GetKeyUp(_key))    { _action.Invoke((int)KeyInputState.Up); }
    }
}
