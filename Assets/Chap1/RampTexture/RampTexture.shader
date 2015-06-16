Shader "Custom/RampTexture" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RamTex ("Light Ramp",2D) = "white"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Ramp

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _RamTex;
		fixed4 _Color;
		struct Input {
			float2 uv_MainTex;
		}; 
	


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		inline float4 LightingRamp (SurfaceOutput s, fixed3 lightDir,half3 viewDir, fixed atten)
       	{
   			//By giving the dot product function, for two vectors you will get a float value in the range of -1 to 1; 
   			//where -1 is parallel and has the vector facing away from you, 
   			// 1 is parallel and has the vector facing toward you,
   			// and 0 is completely perpendicular to you.
	         float difLight =  dot (s.Normal, lightDir); 
	         float hLambert = difLight *0.5 +0.5;
	         float rimLight = dot (s.Normal,viewDir);
	         
	         float3 ramp = tex2D(_RamTex,float2(hLambert,rimLight)).rbg;
	         float4 col;
	         col.rgb = s.Albedo * _LightColor0.rgb * (ramp);
	         col.a = s.Alpha;
	         return col;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
