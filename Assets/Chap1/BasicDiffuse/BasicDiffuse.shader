Shader "CookbookShaders/BasicDiffuse"
       {
         //We define Properties in the properties block
         Properties
         {
           _EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
           _AmbientColor  ("Ambient Color", Color) = (1,1,1,1)
           _MySliderValue ("This is a Slider", Range(0,10)) = 2.5
         }
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf BasicDiffuse
//		#pragma surface surf Lambert
		float4 _EmissiveColor;
       	float4 _AmbientColor;
       	float _MySliderValue;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o)
         {
           float4 c;
           c =  pow((_EmissiveColor + _AmbientColor),  _MySliderValue);
           o.Albedo = c.rgb;
           o.Alpha = c.a;
         }
         // Ref docs http://docs.unity3d.com/Manual/SL-SurfaceShaderLighting.html
     	inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten)
       	{
   			//By giving the dot product function, for two vectors you will get a float value in the range of -1 to 1; 
   			//where -1 is parallel and has the vector facing away from you, 
   			// 1 is parallel and has the vector facing toward you,
   			// and 0 is completely perpendicular to you.
	         float difLight = max(0, dot (s.Normal, lightDir)); 
	         float4 col;
	         col.rgb = s.Albedo * _LightColor0.rgb * (difLight * atten * 2);
	         col.a = s.Alpha;
	         return col;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
