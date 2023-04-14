// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_02/Exp/Smoke/Smoke_01"
{
	Properties
	{
		_T_Cloud_01("T_Cloud_01", 2D) = "white" {}
		_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 0.2
		_T_circleloop_01("T_circleloop_01", 2D) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
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
		uniform sampler2D _T_Cloud_01;
		uniform float4 _T_Cloud_01_ST;
		uniform float _Main_Pow;
		uniform sampler2D _T_circleloop_01;
		uniform float4 _T_circleloop_01_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_T_Cloud_01 = i.uv_texcoord * _T_Cloud_01_ST.xy + _T_Cloud_01_ST.zw;
			float temp_output_6_0 = pow( tex2D( _T_Cloud_01, uv_T_Cloud_01 ).r , _Main_Pow );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_6_0 ) ).rgb;
			float2 uv0_T_circleloop_01 = i.uv_texcoord * _T_circleloop_01_ST.xy + _T_circleloop_01_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( temp_output_6_0 * saturate( step( ( tex2D( _T_circleloop_01, uv0_T_circleloop_01 ).r + i.uv_tex4coord.z ) , 0.1 ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
111;34;1586;774;1171;-161;1;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-1117,626;Float;False;0;12;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-893,626;Float;True;Property;_T_circleloop_01;T_circleloop_01;3;0;Create;True;0;0;False;0;3228804868252b24dae3850f88b4f1d1;3228804868252b24dae3850f88b4f1d1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;16;-749,850;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-477,754;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-573,626;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;17;-429,594;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-872,198;Float;True;Property;_T_Cloud_01;T_Cloud_01;0;0;Create;True;0;0;False;0;c28cfb6e0060ca14786b14507152c8f6;c28cfb6e0060ca14786b14507152c8f6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-772,419;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;19;-327,540;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-361,-1;Float;False;Property;_Main_Color;Main_Color;1;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;6;-563,201;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-262,222;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-191,415;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;10;-89,-10;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-30,235;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-2,420;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;212,-10;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_02/Exp/Smoke/Smoke_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;1;13;0
WireConnection;14;0;12;1
WireConnection;14;1;16;3
WireConnection;17;0;14;0
WireConnection;17;1;18;0
WireConnection;19;0;17;0
WireConnection;6;0;1;1
WireConnection;6;1;7;0
WireConnection;9;0;8;0
WireConnection;9;1;6;0
WireConnection;20;0;6;0
WireConnection;20;1;19;0
WireConnection;11;0;10;0
WireConnection;11;1;9;0
WireConnection;21;0;10;4
WireConnection;21;1;20;0
WireConnection;0;2;11;0
WireConnection;0;9;21;0
ASEEND*/
//CHKSM=8632CAF41C2F48E726357409EC7DA9A234A06FD3