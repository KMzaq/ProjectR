using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : Actor
{
    Animator mAnimator;
    PlayerInputController mInputController;

    [SerializeField] GameObject playerCamera;

    [SerializeField] float speed = 1;

    bool isMove, isRun = false;

    void Start()
    {
        mAnimator = GetComponentInChildren<Animator>();
        mInputController = GetComponent<PlayerInputController>();

        mInputController.actionMove += Move;
        mInputController.actionAttack += Attack;
    }

    private void Update()
    {
        isMove = false;
        isRun = false;

        mInputController.InputUpdate();
        AnimUpdate();
    }



    void Move(Vector3 _dir, bool _isRun)
    {
        Vector3 moveDir = playerCamera.transform.forward * _dir.z + playerCamera.transform.right * _dir.x; 
        moveDir.y = 0;

        transform.position += moveDir * (Input.GetKey(KeyCode.LeftShift) ? speed * 3 : speed) * Time.deltaTime;
        transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(moveDir), Time.deltaTime * 10);

        isMove = true;
        isRun = _isRun;
    }


    void Attack(int _keyState)
    {
        if(_keyState == 0)
            mAnimator.SetTrigger("OnAttack");
    }

    void AnimUpdate()
    {
        mAnimator.SetBool("IsMove", isMove);
        mAnimator.SetBool("IsRun", isRun);
    }
}
