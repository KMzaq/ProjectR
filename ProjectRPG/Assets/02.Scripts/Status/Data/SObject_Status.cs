using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New StatusData", menuName = "ScriptableObject/StatusData")]
public class SObject_Status : ScriptableObject
{
    public int strength;
    public int intelligence;
    public int agility;
    public int dexterity;
    public int constitution;
}
