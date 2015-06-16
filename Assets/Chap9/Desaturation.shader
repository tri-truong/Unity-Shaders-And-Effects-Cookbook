Shader "Custom/Desaturation" {
	Properties {

		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_DesatValue("Desat value",range(0,1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		float _DesatValue;
		struct Input {
			float2 uv_MainTex;
		};


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			half4 c = tex2D (_MainTex, IN.uv_MainTex) ;
			c.rbg = lerp(c.rbg,Luminance(c.rbg),_DesatValue);
			o.Albedo = c.rgb;

			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
