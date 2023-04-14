using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Actor
{
    Animator mAnimator;
    PlayerInputController mInputController;

    [SerializeField] GameObject playerCamera;

    [SerializeField] float speed = 1;

    Vector3 lookDir = Vector3.zero;

    void Start()
    {
        mAnimator = GetComponentInChildren<Animator>();
        mInputController = GetComponent<PlayerInputController>();

        mInputController.actionMove += Move;
        mInputController.actionAttack += Attack;
    }

    private void Update()
    {
        //if(this.transform.forward.x != lookDir.x || this.transform.forward.z != lookDir.z)
        //{
        //    transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(lookDir), Time.deltaTime * 10);
        //    Debug.Log(this.transform.forward + " / " + lookDir);
        //}
    }


    void Move(Vector3 _dir, bool _isRun)
    {
        Vector3 moveDir = playerCamera.transform.forward * _dir.z + playerCamera.transform.right * _dir.x; 
        moveDir.y = 0;

        lookDir = moveDir;

        transform.position += moveDir * (Input.GetKey(KeyCode.LeftShift) ? speed * 3 : speed) * Time.deltaTime;
        transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(moveDir), Time.deltaTime * 10);

        mAnimator.SetBool("IsMove", true);
        mAnimator.SetBool("IsRun", _isRun);
        //mAnimator.SetFloat("DirX", _dir.x);
        //mAnimator.SetFloat("DirZ", _dir.z);
    }


    void Attack(int _keyState)
    {

        Debug.Log(_keyState);
        mAnimator.SetBool("IsAttack", true);
    }

    
}
