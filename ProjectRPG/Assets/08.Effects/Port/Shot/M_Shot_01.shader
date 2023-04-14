// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Shot_Head_01"
{
	Properties
	{
		_t_flare_001("t_flare_001", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
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
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _t_flare_001;
		uniform float4 _t_flare_001_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_t_flare_001 = i.uv_texcoord * _t_flare_001_ST.xy + _t_flare_001_ST.zw;
			float temp_output_6_0 = ( pow( tex2D( _t_flare_001, uv_t_flare_001 ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( ( _Main_Color * temp_output_6_0 ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * temp_output_6_0 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
490;75;1553;646;1052.509;172.6515;1.079311;True;True
Node;AmplifyShaderEditor.SamplerNode;3;-823.6949,101.4937;Float;True;Property;_t_flare_001;t_flare_001;0;0;Create;True;0;0;False;0;6bbaafad15ccafe41ba8ccd36aa4d61a;6bbaafad15ccafe41ba8ccd36aa4d61a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-598.1192,331.3868;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;5;-538.7568,115.5247;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-380.0983,328.1489;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-393.05,114.4454;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-471.8398,-129.479;Float;False;Property;_Main_Color;Main_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;7;-220.3602,-132.7169;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-260.2947,115.5247;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-125.3808,128.4764;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-156.6811,262.3109;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Shot_Head_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;3;1
WireConnection;5;1;10;0
WireConnection;6;0;5;0
WireConnection;6;1;11;0
WireConnection;8;0;4;0
WireConnection;8;1;6;0
WireConnection;9;0;8;0
WireConnection;9;1;7;0
WireConnection;12;0;7;4
WireConnection;12;1;6;0
WireConnection;2;2;9;0
WireConnection;2;9;12;0
ASEEND*/
//CHKSM=A584C7EFF6ED6BE81F40D02608850DC9CCFC0533