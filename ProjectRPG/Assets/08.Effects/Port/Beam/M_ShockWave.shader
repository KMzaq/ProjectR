// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_ShockWave"
{
	Properties
	{
		_T_Line_01A("T_Line_01A", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
		_T_Gra_04("T_Gra_04", 2D) = "white" {}
		_T_Aura_01("T_Aura_01", 2D) = "white" {}
		_Dissolve_Step("Dissolve_Step", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _T_Line_01A;
		uniform float4 _T_Line_01A_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform float _Dissolve_Step;
		uniform sampler2D _T_Aura_01;
		uniform float4 _T_Aura_01_ST;
		uniform sampler2D _T_Gra_04;
		uniform float4 _T_Gra_04_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_T_Line_01A = i.uv_texcoord * _T_Line_01A_ST.xy + _T_Line_01A_ST.zw;
			float2 appendResult14 = (float2(uv0_T_Line_01A.x , ( uv0_T_Line_01A.y + i.uv_tex4coord.z )));
			float temp_output_4_0 = ( pow( tex2D( _T_Line_01A, appendResult14 ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_4_0 ) ).rgb;
			float2 uv0_T_Aura_01 = i.uv_texcoord * _T_Aura_01_ST.xy + _T_Aura_01_ST.zw;
			float2 uv_T_Gra_04 = i.uv_texcoord * _T_Gra_04_ST.xy + _T_Gra_04_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( ( temp_output_4_0 * saturate( step( _Dissolve_Step , ( tex2D( _T_Aura_01, uv0_T_Aura_01 ).r + i.uv_tex4coord.w ) ) ) ) * tex2D( _T_Gra_04, uv_T_Gra_04 ).r ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
38;126;1738;1013;2374.097;-235.1945;1.3;True;True
Node;AmplifyShaderEditor.TexCoordVertexDataNode;16;-1409.492,416.4373;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1308.093,191.5372;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-1923.812,685.3676;Float;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1192.392,339.7373;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1049.391,244.8373;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;18;-1673.278,672.1141;Float;True;Property;_T_Aura_01;T_Aura_01;5;0;Create;True;0;0;False;0;8e84dbcdc4fb83e4583958f01ce815d7;3228804868252b24dae3850f88b4f1d1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;19;-1727.715,932.7507;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-1292.622,917.5377;Float;False;Property;_Dissolve_Step;Dissolve_Step;6;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-1332.797,740.8945;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-876.4925,183.7372;Float;True;Property;_T_Line_01A;T_Line_01A;0;0;Create;True;0;0;False;0;f7ad2e60bdff5424797e2c092d76c9ba;08dfa0de6c92f5e448ddd50b80f41d0d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-749.0924,443.7372;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-542.3924,461.9372;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;3;-585.2924,201.9372;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;-1158.748,750.1945;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-431.8924,208.4372;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;-957.9355,745.6304;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-459.1924,36.83723;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;2,2,2,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-342.2843,692.7227;Float;True;Property;_T_Gra_04;T_Gra_04;4;0;Create;True;0;0;False;0;1109c9e56d0361645bf97b74fd820382;a60748d5292fab94bbeb5406047d2a37;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-576.9245,615.5582;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;8;-230.3924,-17.76276;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-322.6917,452.8372;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-291.4924,213.6372;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-135.4924,212.3372;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-183.5924,382.6373;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;33.79999,-11.7;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;M_ShockWave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;2;2
WireConnection;15;1;16;3
WireConnection;14;0;2;1
WireConnection;14;1;15;0
WireConnection;18;1;17;0
WireConnection;25;0;18;1
WireConnection;25;1;19;4
WireConnection;1;1;14;0
WireConnection;3;0;1;1
WireConnection;3;1;10;0
WireConnection;22;0;21;0
WireConnection;22;1;25;0
WireConnection;4;0;3;0
WireConnection;4;1;11;0
WireConnection;23;0;22;0
WireConnection;24;0;4;0
WireConnection;24;1;23;0
WireConnection;13;0;24;0
WireConnection;13;1;12;1
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;6;0;8;0
WireConnection;6;1;5;0
WireConnection;9;0;8;4
WireConnection;9;1;13;0
WireConnection;0;2;6;0
WireConnection;0;9;9;0
ASEEND*/
//CHKSM=39E52B4C4D33807117BB8E7414E9C4B8B5FA9BF6