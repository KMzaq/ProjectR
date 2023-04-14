// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_T_Glow_01("T_Glow_01", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 2
		_Main_Str("Main_Str", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _T_Glow_01;
		uniform float4 _T_Glow_01_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_T_Glow_01 = i.uv_texcoord * _T_Glow_01_ST.xy + _T_Glow_01_ST.zw;
			float temp_output_4_0 = ( pow( tex2D( _T_Glow_01, uv_T_Glow_01 ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_4_0 ) ).rgb;
			o.Alpha = ( temp_output_4_0 * i.vertexColor.a );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
608;74;1738;1019;1119.396;283.9052;1;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-948.7404,150.0025;Float;True;Property;_T_Glow_01;T_Glow_01;1;0;Create;True;0;0;False;0;ad38897841e4e5840810813ce35141cc;ad38897841e4e5840810813ce35141cc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-713.3962,392.0948;Float;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;3;-640.6556,150.0266;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-539.3962,382.0948;Float;False;Property;_Main_Str;Main_Str;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-508.3962,148.0948;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;-506.3962,-85.90524;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-373.3962,149.0948;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;8;-266.3962,-124.9052;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-237.3962,165.0948;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-267.3962,370.0948;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;1
WireConnection;3;1;10;0
WireConnection;4;0;3;0
WireConnection;4;1;11;0
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;6;0;8;0
WireConnection;6;1;5;0
WireConnection;12;0;4;0
WireConnection;12;1;8;4
WireConnection;0;2;6;0
WireConnection;0;9;12;0
ASEEND*/
//CHKSM=3D8932F25BC80189B7330994050FB49049E8A7CB