using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ColorblindSimulationImageEffect : MonoBehaviour
{
	public Material material;

    public ColorDeficiencyType selectedDeficiency;
    ColorDeficiencyType currentDeficiency = ColorDeficiencyType.None;

	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
        if (material != null)
            Graphics.Blit(src, dest, material);
        else
            Graphics.Blit(src, dest);
	}

    void Update()
    {
        if (selectedDeficiency != currentDeficiency)
        {
            if (material == null)
            {
                Debug.Log("ColorblindSimulationImageEffect:: Cannot change deficiency type, no material set.");
                selectedDeficiency = currentDeficiency;
                return;
            }

            if (!material.HasProperty("_Deficiency"))
            {
                Debug.Log("ColorblindSimulationImageEffect:: The set material is not compatible with this script.");
                selectedDeficiency = currentDeficiency;
                return;
            }

            material.SetInt("_Deficiency", (int)selectedDeficiency);
            currentDeficiency = selectedDeficiency;
        }
    }
}
