Shader "Fx/MirrorEffect_Test3"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MirrorDirection ("Mirror Direction", Range(0, 1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            // float4 _MainTex_ST;  // 削除
            float _MirrorDirection;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;  // TRANSFORM_TEXを使わない
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                
                float isVertical = step(0.5, _MirrorDirection);
                uv.x = lerp(1.0 - uv.x, uv.x, isVertical);
                uv.y = lerp(uv.y, 1.0 - uv.y, isVertical);
                
                fixed4 col = tex2D(_MainTex, uv);
                return col;
            }
            ENDCG
        }
    }
}