using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class ColorDeficiencyShaderEditor : MaterialEditor
{
    ColorDeficiencyType colorDeficiency;

    Material targetMat;
    Object[] targetMatAsArray = new Object[1];
    MaterialProperty materialPropErrorTexture;
    MaterialProperty materialPropErrorStrength;
    MaterialProperty materialPropErrorBlinkSpeed;

    public override void OnEnable()
    {
        targetMat = (Material)target;
        colorDeficiency = (ColorDeficiencyType)((int)targetMat.GetFloat("_Deficiency"));
        targetMatAsArray = new UnityEngine.Object[] { targetMat };
        materialPropErrorTexture = GetMaterialProperty(targetMatAsArray, "_ErrorTex");
        materialPropErrorStrength = GetMaterialProperty(targetMatAsArray, "_ErrorStrength");
        materialPropErrorBlinkSpeed = GetMaterialProperty(targetMatAsArray, "_ErrorBlinkSpeed");
    }

    public override void OnInspectorGUI()
    {
        if (!isVisible) return;

        colorDeficiency = (ColorDeficiencyType)EditorGUILayout.EnumPopup("Color Deficiency", colorDeficiency);
        targetMat.SetFloat("_Deficiency", (float)((int)colorDeficiency));

        EditorGUILayout.Space();

        base.DefaultShaderProperty(materialPropErrorTexture, "Error Texture");
        base.DefaultShaderProperty(materialPropErrorStrength, "Error Strength");
        base.DefaultShaderProperty(materialPropErrorBlinkSpeed, "Error Blink Speed");
    }
}