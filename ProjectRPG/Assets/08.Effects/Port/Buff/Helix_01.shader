// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port/Buff/Helix_01"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 2
		_Main_Str("Main_Str", Float) = 1
		_Main_VO("Main_VO", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Tex;
		uniform float4 _Main_Tex_ST;
		uniform float _Main_VO;
		uniform float _Main_Pow;
		uniform float _Main_Str;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float2 appendResult12 = (float2(i.uv_tex4coord.z , _Main_VO));
			float temp_output_4_0 = ( pow( tex2D( _Main_Tex, ( uv0_Main_Tex + appendResult12 ) ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_4_0 ) ).rgb;
			o.Alpha = ( i.vertexColor.a * ( temp_output_4_0 * saturate( pow( ( ( ( 1.0 - i.uv_texcoord.x ) * i.uv_texcoord.x ) * 4.0 ) , 2.0 ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
206;165;1738;1013;2046.702;-4.187622;1;True;True
Node;AmplifyShaderEditor.TexCoordVertexDataNode;25;-1640.702,251.1876;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1664,551;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-1362,360.5;Float;False;Property;_Main_VO;Main_VO;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1333,85.5;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;20;-1440,507;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1220,298.5;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-1066,195.5;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1451,630;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-855,104.5;Float;True;Property;_Main_Tex;Main_Tex;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-578,335.5;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1257,633;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-392,335.5;Float;False;Property;_Main_Str;Main_Str;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;23;-1060,640;Float;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;3;-557,110.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-415,113.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-328,-106.5;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;24;-731.4484,662.4845;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-202,455.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;8;-49,-106.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-193,113.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1358,273.5;Float;False;Property;_Main_UO;Main_UO;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-32,116.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-133,304.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-523,470.5;Float;True;Property;_Mask_Tex;Mask_Tex;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-766,463.5;Float;False;0;16;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;162,-45;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port/Buff/Helix_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;8;5;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;19;1
WireConnection;12;0;25;3
WireConnection;12;1;15;0
WireConnection;13;0;2;0
WireConnection;13;1;12;0
WireConnection;21;0;20;0
WireConnection;21;1;19;1
WireConnection;1;1;13;0
WireConnection;22;0;21;0
WireConnection;23;0;22;0
WireConnection;3;0;1;1
WireConnection;3;1;10;0
WireConnection;4;0;3;0
WireConnection;4;1;11;0
WireConnection;24;0;23;0
WireConnection;17;0;4;0
WireConnection;17;1;24;0
WireConnection;6;0;5;0
WireConnection;6;1;4;0
WireConnection;7;0;8;0
WireConnection;7;1;6;0
WireConnection;9;0;8;4
WireConnection;9;1;17;0
WireConnection;16;1;18;0
WireConnection;0;2;7;0
WireConnection;0;9;9;0
ASEEND*/
//CHKSM=5CD1B9838F27CAE9532AA0DACD5EBE4D7C3DAFDC