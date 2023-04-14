// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_Area_UP_01"
{
	Properties
	{
		_T_Fluid_01("T_Fluid_01", 2D) = "white" {}
		_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Str("Main_Str", Float) = 1
		_T_Gra_04("T_Gra_04", 2D) = "white" {}
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
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _T_Fluid_01;
		uniform float4 _T_Fluid_01_ST;
		uniform float _Main_Pow;
		uniform float _Main_Str;
		uniform sampler2D _T_Gra_04;
		uniform float4 _T_Gra_04_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_T_Fluid_01 = i.uv_texcoord * _T_Fluid_01_ST.xy + _T_Fluid_01_ST.zw;
			float temp_output_3_0 = ( pow( tex2D( _T_Fluid_01, uv_T_Fluid_01 ).r , _Main_Pow ) * _Main_Str );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_3_0 ) ).rgb;
			float2 uv_T_Gra_04 = i.uv_texcoord * _T_Gra_04_ST.xy + _T_Gra_04_ST.zw;
			o.Alpha = ( ( i.vertexColor.a * temp_output_3_0 ) * tex2D( _T_Gra_04, uv_T_Gra_04 ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
126;1028;1738;1073;1193;310.5;1;True;True
Node;AmplifyShaderEditor.SamplerNode;1;-906,91.5;Float;True;Property;_T_Fluid_01;T_Fluid_01;0;0;Create;True;0;0;False;0;038c5142dab4f804ba8038af6a118461;038c5142dab4f804ba8038af6a118461;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-631,294.5;Float;False;Property;_Main_Pow;Main_Pow;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-625,92.5;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-486,292.5;Float;False;Property;_Main_Str;Main_Str;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-519,-167.5;Float;False;Property;_Main_Color;Main_Color;1;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-485,94.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;7;-240,-150.5;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-335,102.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-194,245.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-569,459.5;Float;True;Property;_T_Gra_04;T_Gra_04;4;0;Create;True;0;0;False;0;1109c9e56d0361645bf97b74fd820382;1109c9e56d0361645bf97b74fd820382;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-197,110.5;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-190,391.5;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_Area_UP_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;1
WireConnection;2;1;9;0
WireConnection;3;0;2;0
WireConnection;3;1;10;0
WireConnection;4;0;6;0
WireConnection;4;1;3;0
WireConnection;8;0;7;4
WireConnection;8;1;3;0
WireConnection;5;0;7;0
WireConnection;5;1;4;0
WireConnection;12;0;8;0
WireConnection;12;1;11;1
WireConnection;0;2;5;0
WireConnection;0;9;12;0
ASEEND*/
//CHKSM=892C767651B809A43DF9D5FDFE868C02CDD593E7