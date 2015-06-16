Shader "Custom/UVScroll" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_ScrollXSpeed (" X Speed",range(0,10))=2
		_ScrollYSpeed (" Y Speed",range(0,10))=2
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
		fixed4 _Color;
		float _ScrollXSpeed;
		float _ScrollYSpeed;
		struct Input {
			float2 uv_MainTex;
		};


		void surf (Input IN, inout SurfaceOutput o) {
			float2 scrollUV = IN.uv_MainTex;
			float uvx = _ScrollXSpeed*_Time;
			float uvy = _ScrollYSpeed*_Time;
			scrollUV +=float2(uvx,uvy);
			// Albedo comes from a texture tinted by color
			half4 c = tex2D(_MainTex,scrollUV);
			o.Albedo = c.rgb;
		
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
