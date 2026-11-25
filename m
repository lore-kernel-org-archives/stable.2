Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637780;
	b=Dw7r2kgy+ctIKuVgBdFvTYsXzY/27TztUbWXCBUz6TBVbvXrrsJ7KvXsUuRnjI7c7Dik
	 8g3XO67ooQrvYY7+3jOoOYzvcGnNhZ9KTSrwL53FHfvGcaMGC9LqAsLZW7LJEKX4d5OEe
	 4pOqdyPnpy5k48oi7hrpZ5KV5pvRDLz95JCeX5bW/0G/r69TXNGWGPrljibAAwpjaIiiL
	 k8nsL0iCzjaNZaaPckAH2zyUVzM3KP4FV1LuvAU31GPz1UBBSEJNrNxwGBDbBSji+UQUf
	 fgdzXzLvmlAwe8kVC3n7xyK1vgBq+uOFBr1x82F0uqvCOMo0NKKAzeNSsdZhG24q/1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=GyPhjArj1GTlQH9QXFfb0KZ+rjDTIHoFzQ0QuyYeR+o=;
	b=bmTUOFs1W4WxOBQ3BMK7KtWP5gIgVIKNx9YqX8WNiLiJ0VlcYcPyq+S0sOcUy/6/bzZz
	 rBhhDNIpXfYUFRwuVO8xDh5LTJTAaFBh4L53B/lMqkvpK9GL7Oi9U2+WqXzUn1I/Jm9Xh
	 Bc+CVecjbfxgtTD9SCwKPNOaNYuViDIMRMXQMwUCzYKUN8jzf/wifYpwqCWYbaRd7FsaF
	 4Ke8zrG+nZD+1fqEVMuTNpz2Owt2jCRzf8klWLS+qs5sk4vbgeYz80M2zt9ulK1MIsT3d
	 ed/Ofvynd/MQvuJ8yAnlpVxdL7JbOPnj8N5zVlWwOO9KNZoLwOltY5EmpFtdsWT0ndQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmad3ysY;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEA606A681
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FEA606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmad3ysY
Received: by mail-oo2-f10.google.com with SMTP id 006d021491bc7-716d85c01f6so2191079eaf.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795637779; x=1796242579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GyPhjArj1GTlQH9QXFfb0KZ+rjDTIHoFzQ0QuyYeR+o=;
        b=rmad3ysYlD5E8k3XGr7qiiv+0FP1Uvn1yYVvd1LZEtVkfpe32/Xvo7hBN24ypO6fVo
         ikWlxRWNnICMSP4cbBlGHav6O0R9t7dwoxJ/6b6CMwgOajHPlvqG1Hv5VQj4+KdG2DMa
         q22Wa24FJPc19bDY2jDydM6h+lyq/v8rbmUd5aoKSsBkaItEckqKAKD7PWNK2XrPL3GU
         V3MNmHQ2icfxk+BSw9RQ/oX0Z92Cpu/x7bJajTWndHFP4FG+PonuoMu7jCyS6Cb12N8C
         CxSJ0l88ot/NpUZJyzXCkPw7iqSViifj8YxShvobQEsujsmYc9c+jE4FyrSxXaDN4eMA
         ImXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637779; x=1796242579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GyPhjArj1GTlQH9QXFfb0KZ+rjDTIHoFzQ0QuyYeR+o=;
        b=DvKDf+Lai30OgseHtBXI8vbHnUFy/2/xyn76G3OBQk+DpM7GgOFu8Q6kf7gnqQ2eyc
         KZlIKO0AkWj9YU8603yykCPkl4W5EFNioUvLyKmQQjpwZji+qbcH1Nk0GylGd2i68VgT
         rlpscvqzYtR4FO+MdM2Rjh7aZ0qHP8n+vP50rR45H9izn6Ar4Kz1172R+PNCTq9CTK0D
         NtMy3dTL6rfjHwixafJEytGN8bTmPgGCd8+YNrY9o5F1wSfYoHV1sF351UfhC8Lw4DvJ
         n3A7qZQlRZOjros6TDEqGv+G4s7lMB3KP+BoKwmEZm5sv1hxewVzqKQLB/i51pHFbt9E
         jMtA==
X-Forwarded-Encrypted: i=1; AL+hErFmFE+15K23+9Fbpb5eln+BrNxQxIgXp2Qr1Y4jiTmj0sjyk0frlZQZkLok2PC8rxpw2lcCcrc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ndOmpKj9iuSV7+wvInfgfWp0s0Yi5S0o9Gd01mM1yoRrD4hw8
	LAAJhIh/vBbUkSCbtMaW62vGvyjRDON2i9HF3CfqWAcUGdDyL5heogz1
X-Gm-Gg: AZFdTZcwd+75B92HaiLJzOGnKW3ZxXN0YSV6A8CBqZ6TllVN4yGN3sV85Ac0n+QCqi6
	u/KfU97cxlIjR/RsyH9RUpSv4fyd/5+I4d666OrjykrjDj/ryGRnlQSLYTpB75XPNXbPMCaRIEU
	YeHX3xKtg00XjNiJ4SR+nBdx4OD/MtS81d+WWRDg0HC8uSD+Vawg23lxw5edLaT2VhbTBmI3t26
	QXcIYycOlToJzDTcMiqmbeUS3NFVrAdd9K0iTWbuKD3dSX/sb8pWIlsTTJ0719jFNgg7yqj1DGm
	4tF8xNH1WcWvCrOyICSeG3+/FonZx5CUg2ksunMKkloITcH6aRQUndfSCrG53AnhET6v6Hg4Fhd
	5tHRRiJ7m+eo3MBR3Fqntwe2CPRRAhFkbRFPy+E/HmBQ3zKwP8W7C+r2Cmi4ktEBw440g8kcX2s
	pGwOUgsU21wlUbqVoUidPBzIdsZKNA3BypTOTb9fadVMCy79z9YX/S306jQhIpl5/coEdCLmtl/
	xygd/slANpffOH3iLEbi2deJMEkW97v22ALIcycOOy2dkSStp/U4HhKt37W1Gv03ZrmjZdP/PMl
	I0qR6OETyjan4Z9NAxHuBXMbwdRl5jAhGCE=
X-Received: by 2002:a05:6820:f028:b0:71b:85a5:c19e with SMTP id 006d021491bc7-71b85a5cb82mr1092887eaf.38.1795637778946;
        Wed, 25 Nov 2026 12:16:18 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm11341859eaf.10.2026.11.25.12.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:16:17 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 14:16:08 -0600
Subject: [PATCH v2 5/9] media: mtk-mdp: Do not refuse a crop for the other
 side's size
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-5-fdc047cf75a5@gmail.com>
References: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-0-fdc047cf75a5@gmail.com>
In-Reply-To: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-0-fdc047cf75a5@gmail.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>, 
 Houlong Wei <houlong.wei@mediatek.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Eizan Miyamoto <eizan@chromium.org>, 
 Francois Buergisser <fbuergisser@chromium.org>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Youngjoon Lee <getfeus@gmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795637766; l=6625;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=XOuHOSCr36tTQQTtaJ/3AJtVCp6ht5DQgA+DZFALOF4=;
 b=oaY2l5fays5eGSgaftJoWFoJ4IlX4oBaWoCZfHIUCCGgMM7EJzAGJOd6x8CAiH2/wyYOR+0aW
 LXre/yGAFy6BcP+ZV8WACa1tQ3KIGheFu71qB+Cz89/035gbPYmetph
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Setting the source crop checks the scaling ratio against the destination
as it stands: the 32x32 default that open() sets, or whatever a client
set while probing. GStreamer sets the source format and crop first, and
a 1280x720 crop was refused with -EINVAL against that 32x32 destination.
The same holds for the compose rectangle and the source, and for the
rotation control.

Check the ratio once both queues are streaming, when both sizes are
settled: at VIDIOC_STREAMON, and for a crop, compose or rotation change
made while streaming. VIDIOC_STREAMON is the first point where both
sizes are known: before it a client may still set either side in any
order, and checking there leaves the queues untouched on refusal. Log a
refusal at debug level, since any client can trigger it.

Fixes: 0d1e342a17f5 ("media: mtk-mdp: Remove states for format checks")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c | 121 +++++++++++++---------
 1 file changed, 73 insertions(+), 48 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
index 34d02de4453d..a40bcf61b7ca 100644
--- a/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_m2m.c
@@ -727,10 +727,40 @@ static int mtk_mdp_m2m_reqbufs(struct file *file, void *fh,
 	return v4l2_m2m_reqbufs(file, ctx->m2m_ctx, reqbufs);
 }
 
+static int mtk_mdp_check_scaler_ratio(struct mtk_mdp_variant *var, int src_w,
+				      int src_h, int dst_w, int dst_h, int rot)
+{
+	int tmp_w, tmp_h;
+
+	if (rot == 90 || rot == 270) {
+		tmp_w = dst_h;
+		tmp_h = dst_w;
+	} else {
+		tmp_w = dst_w;
+		tmp_h = dst_h;
+	}
+
+	if ((src_w / tmp_w) > var->h_scale_down_max ||
+	    (src_h / tmp_h) > var->v_scale_down_max ||
+	    (tmp_w / src_w) > var->h_scale_up_max ||
+	    (tmp_h / src_h) > var->v_scale_up_max)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Both sizes are settled once both queues are streaming */
+static bool mtk_mdp_ctx_streaming(struct mtk_mdp_ctx *ctx)
+{
+	return vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->m2m_ctx)) &&
+	       vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->m2m_ctx));
+}
+
 static int mtk_mdp_m2m_streamon(struct file *file, void *fh,
 				enum v4l2_buf_type type)
 {
 	struct mtk_mdp_ctx *ctx = file_to_ctx(file);
+	struct vb2_queue *other;
 	int ret;
 
 	if (!mtk_mdp_ctx_state_is_set(ctx, MTK_MDP_VPU_INIT)) {
@@ -744,6 +774,21 @@ static int mtk_mdp_m2m_streamon(struct file *file, void *fh,
 		mtk_mdp_ctx_state_lock_set(ctx, MTK_MDP_VPU_INIT);
 	}
 
+	/* the queue that starts second checks the ratio */
+	other = v4l2_m2m_get_vq(ctx->m2m_ctx, V4L2_TYPE_IS_OUTPUT(type) ?
+				V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
+				V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
+	if (vb2_is_streaming(other) &&
+	    mtk_mdp_check_scaler_ratio(ctx->mdp_dev->variant,
+				       ctx->s_frame.crop.width,
+				       ctx->s_frame.crop.height,
+				       ctx->d_frame.crop.width,
+				       ctx->d_frame.crop.height,
+				       ctx->ctrls.rotate->val)) {
+		dev_dbg(&ctx->mdp_dev->pdev->dev, "Out of scaler range\n");
+		return -EINVAL;
+	}
+
 	return v4l2_m2m_streamon(file, ctx->m2m_ctx, type);
 }
 
@@ -810,35 +855,12 @@ static int mtk_mdp_m2m_g_selection(struct file *file, void *fh,
 	return -EINVAL;
 }
 
-static int mtk_mdp_check_scaler_ratio(struct mtk_mdp_variant *var, int src_w,
-				      int src_h, int dst_w, int dst_h, int rot)
-{
-	int tmp_w, tmp_h;
-
-	if (rot == 90 || rot == 270) {
-		tmp_w = dst_h;
-		tmp_h = dst_w;
-	} else {
-		tmp_w = dst_w;
-		tmp_h = dst_h;
-	}
-
-	if ((src_w / tmp_w) > var->h_scale_down_max ||
-	    (src_h / tmp_h) > var->v_scale_down_max ||
-	    (tmp_w / src_w) > var->h_scale_up_max ||
-	    (tmp_h / src_h) > var->v_scale_up_max)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int mtk_mdp_m2m_s_selection(struct file *file, void *fh,
 				   struct v4l2_selection *s)
 {
 	struct mtk_mdp_ctx *ctx = file_to_ctx(file);
 	struct mtk_mdp_frame *frame;
 	struct v4l2_rect new_r;
-	struct mtk_mdp_variant *variant = ctx->mdp_dev->variant;
 	int ret;
 	bool valid = false;
 
@@ -865,22 +887,27 @@ static int mtk_mdp_m2m_s_selection(struct file *file, void *fh,
 	else
 		frame = &ctx->d_frame;
 
-	/* Check to see if scaling ratio is within supported range */
-	if (V4L2_TYPE_IS_OUTPUT(s->type))
-		ret = mtk_mdp_check_scaler_ratio(variant, new_r.width,
-			new_r.height, ctx->d_frame.crop.width,
-			ctx->d_frame.crop.height,
-			ctx->ctrls.rotate->val);
-	else
-		ret = mtk_mdp_check_scaler_ratio(variant,
-			ctx->s_frame.crop.width,
-			ctx->s_frame.crop.height, new_r.width,
-			new_r.height, ctx->ctrls.rotate->val);
-
-	if (ret) {
-		dev_info(&ctx->mdp_dev->pdev->dev,
-			"Out of scaler range");
-		return -EINVAL;
+	/*
+	 * Until both queues are streaming the other side's size may still
+	 * change, and VIDIOC_STREAMON checks the scaling ratio.
+	 */
+	if (mtk_mdp_ctx_streaming(ctx)) {
+		struct v4l2_rect *src = &ctx->s_frame.crop;
+		struct v4l2_rect *dst = &ctx->d_frame.crop;
+
+		if (V4L2_TYPE_IS_OUTPUT(s->type))
+			src = &new_r;
+		else
+			dst = &new_r;
+
+		if (mtk_mdp_check_scaler_ratio(ctx->mdp_dev->variant,
+					       src->width, src->height,
+					       dst->width, dst->height,
+					       ctx->ctrls.rotate->val)) {
+			dev_dbg(&ctx->mdp_dev->pdev->dev,
+				"Out of scaler range\n");
+			return -EINVAL;
+		}
 	}
 
 	s->r = new_r;
@@ -953,7 +980,6 @@ static int mtk_mdp_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct mtk_mdp_ctx *ctx = ctrl_to_ctx(ctrl);
 	struct mtk_mdp_dev *mdp = ctx->mdp_dev;
 	struct mtk_mdp_variant *variant = mdp->variant;
-	int ret = 0;
 
 	if (ctrl->flags & V4L2_CTRL_FLAG_INACTIVE)
 		return 0;
@@ -966,14 +992,13 @@ static int mtk_mdp_s_ctrl(struct v4l2_ctrl *ctrl)
 		ctx->vflip = ctrl->val;
 		break;
 	case V4L2_CID_ROTATE:
-		ret = mtk_mdp_check_scaler_ratio(variant,
-				ctx->s_frame.crop.width,
-				ctx->s_frame.crop.height,
-				ctx->d_frame.crop.width,
-				ctx->d_frame.crop.height,
-				ctx->ctrls.rotate->val);
-
-		if (ret)
+		if (mtk_mdp_ctx_streaming(ctx) &&
+		    mtk_mdp_check_scaler_ratio(variant,
+					       ctx->s_frame.crop.width,
+					       ctx->s_frame.crop.height,
+					       ctx->d_frame.crop.width,
+					       ctx->d_frame.crop.height,
+					       ctx->ctrls.rotate->val))
 			return -EINVAL;
 
 		ctx->rotation = ctrl->val;

-- 
2.56.1

