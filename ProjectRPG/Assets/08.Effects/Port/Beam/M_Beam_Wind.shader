// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_BeamWind"
{
	Properties
	{
		_TX_BeamWind_01("TX_BeamWind_01", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
		_T_Aura_01("T_Aura_01", 2D) = "white" {}
		_Dissolve_Step("Dissolve_Step", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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

		uniform float4 _Color0;
		uniform sampler2D _TX_BeamWind_01;
		uniform float4 _TX_BeamWind_01_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _T_Aura_01;
		uniform float4 _T_Aura_01_ST;
		uniform float _Dissolve_Step;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TX_BeamWind_01 = i.uv_texcoord * _TX_BeamWind_01_ST.xy + _TX_BeamWind_01_ST.zw;
			float temp_output_3_0 = ( pow( tex2D( _TX_BeamWind_01, uv_TX_BeamWind_01 ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Color0 * temp_output_3_0 ) ).rgb;
			float2 uv0_T_Aura_01 = i.uv_texcoord * _T_Aura_01_ST.xy + _T_Aura_01_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( temp_output_3_0 * saturate( step( ( tex2D( _T_Aura_01, uv0_T_Aura_01 ).r - i.uv_tex4coord.z ) , _Dissolve_Step ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
50;1014;1553;634;1494.195;222.0302;1.521303;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1445.515,592.6274;Float;False;0;11;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-1214.606,576.9206;Float;True;Property;_T_Aura_01;T_Aura_01;4;0;Create;True;0;0;False;0;8e84dbcdc4fb83e4583958f01ce815d7;925d68cc41b84a040a94ef783801c784;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;14;-1269.043,837.5571;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-902.5,174;Float;True;Property;_TX_BeamWind_01;TX_BeamWind_01;0;0;Create;True;0;0;False;0;0610b923cb35b8147817564f712e7f5f;0610b923cb35b8147817564f712e7f5f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-902.4092,632.1813;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-833.9501,822.3441;Float;False;Property;_Dissolve_Step;Dissolve_Step;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-648.5,381;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-491.5,389;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-602.5,200;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;18;-700.0756,655.0009;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;15;-499.2637,650.4369;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-446.5,214;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-413.5,-32;Float;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;1.584314,1.105882,2,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-321.5,223;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;7;-205.5,-20;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-324.3139,618.4895;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-176.5,229;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-263.8862,360.0313;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-3.537846,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;M_BeamWind;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;1;12;0
WireConnection;13;0;11;1
WireConnection;13;1;14;3
WireConnection;2;0;1;1
WireConnection;2;1;8;0
WireConnection;18;0;13;0
WireConnection;18;1;17;0
WireConnection;15;0;18;0
WireConnection;3;0;2;0
WireConnection;3;1;9;0
WireConnection;4;0;6;0
WireConnection;4;1;3;0
WireConnection;16;0;3;0
WireConnection;16;1;15;0
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;10;0;7;4
WireConnection;10;1;16;0
WireConnection;0;2;5;0
WireConnection;0;9;10;0
ASEEND*/
//CHKSM=58B35A603FCE5AB3CF345208D090B51697C41C96