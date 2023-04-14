// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		_Main_Tex("Main_Tex", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,1)
		_Depth_Dis("Depth_Dis", Float) = 0
		_Tile_US("Tile_US", Float) = 0
		_Main_US("Main_US", Float) = 0
		_Dissolve_US("Dissolve_US", Float) = 0
		_Main_VS("Main_VS", Float) = 0
		_Tile_VS("Tile_VS", Float) = 0
		_Dissolve_VS("Dissolve_VS", Float) = -0.5
		_Flow_US("Flow_US", Float) = 0
		_Flow_Vs("Flow_Vs", Float) = 0
		_Flow_Tex("Flow_Tex", 2D) = "white" {}
		_Flow_Str("Flow_Str", Float) = 0
		_Dissolve_Tex("Dissolve_Tex", 2D) = "white" {}
		_Disslove_STr("Disslove_STr", Float) = -1
		_Tile_Tex("Tile_Tex", 2D) = "white" {}
		_Dissolve_Mask("Dissolve_Mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 screenPosition11;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Tile_Tex;
		uniform float _Tile_US;
		uniform float _Tile_VS;
		uniform float4 _Tile_Tex_ST;
		uniform sampler2D _Main_Tex;
		uniform float _Main_US;
		uniform float _Main_VS;
		uniform float4 _Main_Tex_ST;
		uniform sampler2D _Dissolve_Tex;
		uniform float _Dissolve_US;
		uniform float _Dissolve_VS;
		uniform sampler2D _Flow_Tex;
		uniform float _Flow_US;
		uniform float _Flow_Vs;
		uniform float4 _Flow_Tex_ST;
		uniform float _Flow_Str;
		uniform float4 _Dissolve_Tex_ST;
		uniform sampler2D _Dissolve_Mask;
		uniform float4 _Dissolve_Mask_ST;
		uniform float _Disslove_STr;
		uniform sampler2D _Mask_Tex;
		uniform float4 _Mask_Tex_ST;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth_Dis;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 vertexPos11 = ase_vertex3Pos;
			float4 ase_screenPos11 = ComputeScreenPos( UnityObjectToClipPos( vertexPos11 ) );
			o.screenPosition11 = ase_screenPos11;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult67 = (float2(_Tile_US , _Tile_VS));
			float2 uv0_Tile_Tex = i.uv_texcoord * _Tile_Tex_ST.xy + _Tile_Tex_ST.zw;
			float2 panner68 = ( 1.0 * _Time.y * appendResult67 + uv0_Tile_Tex);
			float4 tex2DNode60 = tex2D( _Tile_Tex, panner68 );
			float2 appendResult17 = (float2(_Main_US , _Main_VS));
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float2 panner18 = ( 1.0 * _Time.y * appendResult17 + uv0_Main_Tex);
			float4 tex2DNode3 = tex2D( _Main_Tex, panner18 );
			float2 appendResult36 = (float2(_Dissolve_US , _Dissolve_VS));
			float2 appendResult24 = (float2(_Flow_US , _Flow_Vs));
			float2 uv0_Flow_Tex = i.uv_texcoord * _Flow_Tex_ST.xy + _Flow_Tex_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult24 + uv0_Flow_Tex);
			float2 uv0_Dissolve_Tex = i.uv_texcoord * _Dissolve_Tex_ST.xy + _Dissolve_Tex_ST.zw;
			float2 panner37 = ( 1.0 * _Time.y * appendResult36 + ( ( (tex2D( _Flow_Tex, panner23 )).rg * _Flow_Str ) + uv0_Dissolve_Tex ));
			float2 uv_Dissolve_Mask = i.uv_texcoord * _Dissolve_Mask_ST.xy + _Dissolve_Mask_ST.zw;
			float4 temp_output_45_0 = ( ( ( tex2DNode60.r + tex2DNode3 ) * tex2DNode3.r ) * saturate( step( ( ( tex2D( _Dissolve_Tex, panner37 ).r * tex2D( _Dissolve_Mask, uv_Dissolve_Mask ).r ) + _Disslove_STr ) , 0.1 ) ) );
			o.Emission = ( i.vertexColor * ( _Main_Color * temp_output_45_0 ) ).rgb;
			float2 uv_Mask_Tex = i.uv_texcoord * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			float4 ase_screenPos11 = i.screenPosition11;
			float4 ase_screenPosNorm11 = ase_screenPos11 / ase_screenPos11.w;
			ase_screenPosNorm11.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm11.z : ase_screenPosNorm11.z * 0.5 + 0.5;
			float screenDepth11 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos11 ))));
			float distanceDepth11 = abs( ( screenDepth11 - LinearEyeDepth( ase_screenPosNorm11.z ) ) / ( _Depth_Dis ) );
			o.Alpha = ( i.vertexColor.a * ( ( temp_output_45_0 * tex2D( _Mask_Tex, uv_Mask_Tex ).r ) * saturate( distanceDepth11 ) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
47;291;1586;734;1868.851;538.4811;1.3;True;True
Node;AmplifyShaderEditor.RangedFloatNode;26;-2992.585,462.5141;Float;False;Property;_Flow_Vs;Flow_Vs;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2961.282,342.5369;Float;False;Property;_Flow_US;Flow_US;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;24;-2765.282,377.5369;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2919.282,204.5372;Float;False;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;23;-2678.282,238.5371;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;-2456.282,212.7372;Float;True;Property;_Flow_Tex;Flow_Tex;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-2028.282,404.7369;Float;False;Property;_Flow_Str;Flow_Str;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;27;-2162.282,206.7372;Float;True;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1900.433,689.4479;Float;False;Property;_Dissolve_US;Dissolve_US;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1916.432,785.4479;Float;False;Property;_Dissolve_VS;Dissolve_VS;9;0;Create;True;0;0;False;0;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-1932.433,561.4479;Float;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1865.282,247.7371;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1742.987,393.0378;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-1708.433,737.4479;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;37;-1628.433,593.4479;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1764.361,3.785219;Float;False;Property;_Tile_VS;Tile_VS;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1549.389,347.9199;Float;False;Property;_Main_VS;Main_VS;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1583.389,264.9201;Float;False;Property;_Main_US;Main_US;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1798.361,-79.21455;Float;False;Property;_Tile_US;Tile_US;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;31;-1420.433,561.4479;Float;True;Property;_Dissolve_Tex;Dissolve_Tex;14;0;Create;True;0;0;False;0;2adca0fe80e66634281feeb6794fc325;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;69;-1581.551,918.8188;Float;True;Property;_Dissolve_Mask;Dissolve_Mask;17;0;Create;True;0;0;False;0;f51b85801d489644b9e610a6db6950b7;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;66;-1831.805,-212.0472;Float;False;0;60;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;17;-1387.389,299.92;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1616.833,132.0875;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;67;-1602.361,-44.21466;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;68;-1515.361,-183.2146;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;18;-1300.389,160.9201;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1073.25,829.1188;Float;False;Property;_Disslove_STr;Disslove_STr;15;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1318.951,771.9188;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-1051.264,594.5239;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-1320.25,-162.781;Float;True;Property;_Tile_Tex;Tile_Tex;16;0;Create;True;0;0;False;0;8e84dbcdc4fb83e4583958f01ce815d7;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1130.389,126.9201;Float;True;Property;_Main_Tex;Main_Tex;1;0;Create;True;0;0;False;0;e2baf21746f456f479fd66659ae5e870;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;58;-928.9505,722.5189;Float;False;Constant;_Float0;Float 0;14;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;57;-912.0505,556.1189;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-984.8491,-154.9812;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-753.449,-102.9812;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosVertexDataNode;12;-608,616;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-403,781;Float;False;Property;_Depth_Dis;Depth_Dis;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;59;-826.2502,470.3189;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-598.134,436.5403;Float;True;Property;_Mask_Tex;Mask_Tex;0;0;Create;True;0;0;False;0;accadee74e38a2441800412ab3d8897a;accadee74e38a2441800412ab3d8897a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-712.8063,172.7194;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DepthFade;11;-447,629;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;14;-201,582;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-215,275;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;5;-511,-76;Float;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-137,412;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-398,130;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;6;-198,-29;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-850.9509,-405.8811;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-14,277;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-180,182;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;170,-20;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;New Amplify Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;25;0
WireConnection;24;1;26;0
WireConnection;23;0;22;0
WireConnection;23;2;24;0
WireConnection;21;1;23;0
WireConnection;27;0;21;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;30;0;28;0
WireConnection;30;1;35;0
WireConnection;36;0;34;0
WireConnection;36;1;33;0
WireConnection;37;0;30;0
WireConnection;37;2;36;0
WireConnection;31;1;37;0
WireConnection;17;0;19;0
WireConnection;17;1;20;0
WireConnection;67;0;65;0
WireConnection;67;1;64;0
WireConnection;68;0;66;0
WireConnection;68;2;67;0
WireConnection;18;0;16;0
WireConnection;18;2;17;0
WireConnection;70;0;31;1
WireConnection;70;1;69;1
WireConnection;52;0;70;0
WireConnection;52;1;56;0
WireConnection;60;1;68;0
WireConnection;3;1;18;0
WireConnection;57;0;52;0
WireConnection;57;1;58;0
WireConnection;62;0;60;1
WireConnection;62;1;3;0
WireConnection;63;0;62;0
WireConnection;63;1;3;1
WireConnection;59;0;57;0
WireConnection;45;0;63;0
WireConnection;45;1;59;0
WireConnection;11;1;12;0
WireConnection;11;0;13;0
WireConnection;14;0;11;0
WireConnection;9;0;45;0
WireConnection;9;1;1;1
WireConnection;15;0;9;0
WireConnection;15;1;14;0
WireConnection;7;0;5;0
WireConnection;7;1;45;0
WireConnection;71;0;60;1
WireConnection;71;1;3;1
WireConnection;10;0;6;4
WireConnection;10;1;15;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;0;2;8;0
WireConnection;0;9;10;0
ASEEND*/
//CHKSM=F9AD355206321CD3C494CF79AD41768B7DDA0907