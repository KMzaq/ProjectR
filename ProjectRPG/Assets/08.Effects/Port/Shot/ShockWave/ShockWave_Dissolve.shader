// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port_Shot_ShockWave_Disslove"
{
	Properties
	{
		_T_Hit_01("T_Hit_01", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_T_Aura_01("T_Aura_01", 2D) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv_tex4coord;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _T_Hit_01;
		uniform float4 _T_Hit_01_ST;
		uniform sampler2D _T_Aura_01;
		uniform float4 _T_Aura_01_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_T_Hit_01 = i.uv_texcoord * _T_Hit_01_ST.xy + _T_Hit_01_ST.zw;
			float4 tex2DNode1 = tex2D( _T_Hit_01, uv_T_Hit_01 );
			float2 uv0_T_Aura_01 = i.uv_texcoord * _T_Aura_01_ST.xy + _T_Aura_01_ST.zw;
			o.Emission = ( i.vertexColor * ( _Main_Color * ( tex2DNode1.r * saturate( step( ( i.uv_tex4coord.z + tex2D( _T_Aura_01, uv0_T_Aura_01 ).r ) , 0.1 ) ) ) ) ).rgb;
			o.Alpha = ( i.vertexColor.a * tex2DNode1.r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
103;549;1553;801;1718.349;125.3654;1.3;True;True
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1671.549,731.3347;Float;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;5;-1411.55,495.6347;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-1416.75,697.1346;Float;True;Property;_T_Aura_01;T_Aura_01;3;0;Create;True;0;0;False;0;8e84dbcdc4fb83e4583958f01ce815d7;8e84dbcdc4fb83e4583958f01ce815d7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-981.25,489.1347;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-927.9501,668.5346;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;9;-860.3502,545.0345;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-882.5,122;Float;True;Property;_T_Hit_01;T_Hit_01;1;0;Create;True;0;0;False;0;84899f579dc20f14a9989612843b3b7d;84899f579dc20f14a9989612843b3b7d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;12;-762.85,500.8348;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-635.4496,385.1347;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-535.3495,-90.06527;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-527.5496,162.1347;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;6;-287.0496,-91.36527;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-268.8497,156.9347;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-237.6497,346.5347;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Port_Shot_ShockWave_Disslove;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;1;15;0
WireConnection;7;0;5;3
WireConnection;7;1;8;1
WireConnection;9;0;7;0
WireConnection;9;1;11;0
WireConnection;12;0;9;0
WireConnection;13;0;1;1
WireConnection;13;1;12;0
WireConnection;3;0;2;0
WireConnection;3;1;13;0
WireConnection;4;0;6;0
WireConnection;4;1;3;0
WireConnection;14;0;6;4
WireConnection;14;1;1;1
WireConnection;0;2;4;0
WireConnection;0;9;14;0
ASEEND*/
//CHKSM=D766FDF9239059BDC054BD8C7CC11F0285252A36