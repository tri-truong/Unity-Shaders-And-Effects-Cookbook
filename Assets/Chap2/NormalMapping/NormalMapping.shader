Shader "Custom/NormalMapping" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_NormalTex ("Normal Map)", 2D) = "bump" {}
		_NormalIntensity ("Normal Intensity",range(0,10))=2
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _NormalTex;
		fixed4 _Color;
		float _NormalIntensity;
		struct Input {
			float2 uv_NormalTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			float3 normalMap =  UnpackNormal(tex2D(_NormalTex,IN.uv_NormalTex));
			normalMap = float3 (normalMap.x * _NormalIntensity,normalMap.y*_NormalIntensity,normalMap.z);
			o.Normal = normalMap.rgb;
			o.Albedo = _Color;
			
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
