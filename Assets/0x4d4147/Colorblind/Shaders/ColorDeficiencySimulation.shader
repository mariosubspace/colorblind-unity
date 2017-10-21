Shader "0x4d4147/ColorDeficiencySimulation"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_ErrorTex ("Texture", 2D) = "white" {}
		_Deficiency ("Deficiency", Range(0, 3)) = 0
		_ErrorStrength ("Error Strength", Range(0, 1)) = 0.5
		_ErrorBlinkSpeed ("Error Speed", Float) = 0
	}

	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "ColorDeficiencyTools.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _ErrorTex;
			float4 _ErrorTex_ST;
			int _Deficiency;
			float _ErrorStrength;
			float _ErrorBlinkSpeed;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 errorTexUv : TEXCOORD1;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.errorTexUv = TRANSFORM_TEX(v.uv, _ErrorTex);
				return o;
			}

			float WaveModdedShowError()
			{
				return (cos(_Time.y * _ErrorBlinkSpeed) * 0.5 + 0.5) * _ErrorStrength;
			}

			float4 frag (v2f i) : SV_Target
			{
				float4 cameraCol = tex2D(_MainTex, i.uv);
				float4 errorCol = tex2D(_ErrorTex, i.errorTexUv);
				float4 deficiencyCol = float4(SimulateDeficiency(cameraCol.rgb, _Deficiency), 1);
				float fullErrorMagnitude = abs(length(cameraCol.xyz - deficiencyCol.xyz));

				float3 composite = saturate(lerp(deficiencyCol, errorCol, WaveModdedShowError() * fullErrorMagnitude));
				return fixed4(composite, 1);
			}
			ENDCG
		}
	}
	CustomEditor "ColorDeficiencyShaderEditor"
}
