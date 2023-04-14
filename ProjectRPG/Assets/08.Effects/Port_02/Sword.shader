// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Port02/M_Sword"
{
	Properties
	{
		_Fresnel_Str("Fresnel_Str", Float) = 0
		[HDR]_Test_Color("Test_Color", Color) = (0.3773585,0.3773585,0.3773585,1)
		_Fresnel_Pow("Fresnel_Pow", Float) = 0
		_Fresnel_Bias("Fresnel_Bias", Float) = 0
		[HDR]_Test_Color_02("Test_Color_02", Color) = (1,1,1,1)
		_Main_Lerp("Main_Lerp", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float3 viewDir;
			float3 worldNormal;
		};

		uniform float4 _Test_Color_02;
		uniform float4 _Test_Color;
		uniform float _Main_Lerp;
		uniform float _Fresnel_Bias;
		uniform float _Fresnel_Str;
		uniform float _Fresnel_Pow;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 lerpResult11 = lerp( _Test_Color_02 , _Test_Color , _Main_Lerp);
			o.Albedo = lerpResult11.rgb;
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV2 = dot( ase_worldNormal, i.viewDir );
			float fresnelNode2 = ( _Fresnel_Bias + _Fresnel_Str * pow( 1.0 - fresnelNdotV2, _Fresnel_Pow ) );
			float3 temp_cast_1 = (saturate( fresnelNode2 )).xxx;
			o.Emission = temp_cast_1;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
162;342;1586;1030;1244;263;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;6;-806,700;Float;False;Property;_Fresnel_Pow;Fresnel_Pow;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-795,608;Float;False;Property;_Fresnel_Str;Fresnel_Str;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;8;-874,224;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;9;-848,424;Float;False;Property;_Fresnel_Bias;Fresnel_Bias;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;2;-538,253;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-541,160;Float;False;Property;_Main_Lerp;Main_Lerp;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-719,-83;Float;False;Property;_Test_Color;Test_Color;1;1;[HDR];Create;True;0;0;False;0;0.3773585,0.3773585,0.3773585,1;0.3773585,0.3773585,0.3773585,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;-728,-294;Float;False;Property;_Test_Color_02;Test_Color_02;6;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;4;-303,261;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-1318,240;Float;True;Property;_FX_Noise_044A_N;FX_Noise_044A_N;5;0;Create;True;0;0;False;0;be16ed68839bead46a05797c841163f4;be16ed68839bead46a05797c841163f4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-1168,-3;Float;False;Property;_Fresnel_Color;Fresnel_Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;11;-387,-192;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Port02/M_Sword;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;4;8;0
WireConnection;2;1;9;0
WireConnection;2;2;5;0
WireConnection;2;3;6;0
WireConnection;4;0;2;0
WireConnection;11;0;12;0
WireConnection;11;1;1;0
WireConnection;11;2;13;0
WireConnection;0;0;11;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=70ECDC4D6AA2A975F4A315DF30AD3B638A7C14F7