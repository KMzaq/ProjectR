// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_Area_Area_01"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
		_Dissiolve_Tex("Dissiolve_Tex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		uniform sampler2D _Main_Tex;
		uniform float4 _Main_Tex_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _Dissiolve_Tex;
		uniform float4 _Dissiolve_Tex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float temp_output_12_0 = ( pow( tex2D( _Main_Tex, uv0_Main_Tex ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_12_0 ) ).rgb;
			float2 uv_Dissiolve_Tex = i.uv_texcoord * _Dissiolve_Tex_ST.xy + _Dissiolve_Tex_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( temp_output_12_0 * saturate( step( ( tex2D( _Dissiolve_Tex, uv_Dissiolve_Tex ).r + i.uv_tex4coord.z ) , 0.1 ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
100;145;1738;1019;1784.773;-35.23649;1.3;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1370.724,206.1866;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-1182.875,711.2366;Float;True;Property;_Dissiolve_Tex;Dissiolve_Tex;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;22;-1099.673,919.2365;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-743.4737,872.4365;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-749.975,732.0364;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1130.224,206.1866;Float;True;Property;_Main_Tex;Main_Tex;0;0;Create;True;0;0;False;0;d8572cf77a14e6b4cb14d706a3bce4de;886212156b8726240b82ff048ce8e8e6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-949.5245,416.7864;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;18;-596.5737,755.4365;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-569.9247,395.9865;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;11;-807.8246,219.1864;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-554.3241,-52.5135;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;4,4,4,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-549.125,236.0865;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;-454.8731,668.3365;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-387.9241,186.6865;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;6;-330.724,-17.4135;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-304.0732,455.1364;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-181.2241,323.1865;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-212.4241,185.3865;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;29.9,-14.3;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_Area_Area_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;17;1
WireConnection;15;1;22;3
WireConnection;1;1;10;0
WireConnection;18;0;15;0
WireConnection;18;1;19;0
WireConnection;11;0;1;1
WireConnection;11;1;13;0
WireConnection;12;0;11;0
WireConnection;12;1;14;0
WireConnection;20;0;18;0
WireConnection;7;0;4;0
WireConnection;7;1;12;0
WireConnection;21;0;12;0
WireConnection;21;1;20;0
WireConnection;9;0;6;4
WireConnection;9;1;21;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;0;2;8;0
WireConnection;0;9;9;0
ASEEND*/
//CHKSM=30DDAE3C321B5428A0C74E575AD9AD85FA5AD1C5