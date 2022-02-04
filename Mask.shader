Shader "Custom/Mask"
{
    Properties
    {
		_Texture1 ("ColorAl (RGB)", 2D) = "whitte" {}
		_Texture2 ("Mask (RGB)", 2D) = "whitte" {}
		_Texture3 ("Texture (RGB)", 2D) = "whitte" {}

	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _Texture1;
		sampler2D _Texture2;
		sampler2D _Texture3;


		//Siempre: uv_ + nombre de la textura
        struct Input
        {
            float2 uv_Texture1;
		};

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float3 Character = tex2D(_Texture1, IN.uv_Texture1).rgb;
			float3 mask = tex2D(_Texture2, IN.uv_Texture1).rgb;
			float3 c2 = Character * (1 - mask);
			float3 textura = tex2D(_Texture3, IN.uv_Texture1).rgb;
			float3 c3 = textura * mask;
			o.Albedo = (c2 + c3).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
