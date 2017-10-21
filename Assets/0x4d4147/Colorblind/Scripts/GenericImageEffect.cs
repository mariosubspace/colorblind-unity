using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class GenericImageEffect : MonoBehaviour
{
	public Material material;

	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
        if (material != null)
            Graphics.Blit(src, dest, material);
        else
            Graphics.Blit(src, dest);
	}
}
