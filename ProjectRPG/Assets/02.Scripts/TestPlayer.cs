using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestPlayer : MonoBehaviour
{
    Animator mAnimator;

    public float speed;

    float hAxis;
    float vAxis;

    Vector3 moveVec;

    void Start()
    {
        mAnimator = GetComponent<Animator>();
    }


    private void FixedUpdate()
    {
        transform.position += moveVec.normalized * (Input.GetKey(KeyCode.LeftShift) ? speed * 3 : speed) * Time.deltaTime;
        transform.Rotate(0, hAxis * 180 * Time.deltaTime, 0);
    }
    void Update()
    {
        hAxis = Input.GetAxisRaw("Horizontal");
        vAxis = Input.GetAxisRaw("Vertical");

        moveVec = this.gameObject.transform.forward * vAxis;

        mAnimator.SetBool("IsMove", vAxis != 0 || hAxis != 0);
        mAnimator.SetBool("IsRun", Input.GetKey(KeyCode.LeftShift));
        mAnimator.SetFloat("DirX", hAxis);
        mAnimator.SetFloat("DirZ", vAxis);

        mAnimator.SetBool("IsAttack", Input.GetMouseButtonDown(0));
    }

    private void LateUpdate()
    {
        
    }
}
