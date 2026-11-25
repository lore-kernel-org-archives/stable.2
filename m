Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637775;
	b=D2Oq/LA7sLvj9rjikFoZaYC315o+QRl1Y4GRdhwOYRiyrSTC2ijMZOgTpaYHuoWIU7j6
	 EHk2KfLxAU/+her/7wBqqE4r72Z598bTcAD+VGAN7rlnp59+HXSGsSo2vDHpYfLlLD6md
	 Q1+XYFfqOe1TWvA/oAxnvKsFLc40PeclYneGqAc5E5MddIABH3KY88XLWQe8kc0y6sxgj
	 53In/10SCy5k4s00oVpX7VXyyiTHUyY8jF9GvBcsC8HlRhtVb35VpkxT47GG3GfAi+eVW
	 S5/GwW9W4zMaNeAAAM+rInNjE+WYgPn983B6p2CZ4zA8vlwH6yEF0eioLXNsCMn1IFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=q1b9Vl4Ai63r6PX/+1MzE13ZwXBrHRrLzRTvx0UyhBM=;
	b=USpae/2w+3U2z9pl94iW0gdVZgWIFeIbulcJmYbRBGgJujXJSTBgoQsEsGhJshcwby2h
	 zO/ZjWzOjB7ftaJIW8hBPfe8gKxbBBCkP7s4015bk6YrISun6Bb/DRTnDP7cnOUQqmKsD
	 O2fGw3GTb9ZPt33+29Bfr1By5fl2++K3NQfKpZwlpBoGTfptncs0FhIlOmYl6sjWYYnSJ
	 eMFtQ7/6BAq+L9LlnnhEIwlQ9ylaoirPbRmlOj3OhohW+Kg2aF+QEcbbL0ynIXfGel9lB
	 6y/ozqntEhHuNw+cTjVX6TSa7Y1JnPDrOo3ERdvPha13YhP2rrTglZPrHASQcSzvhzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BO7oXA2c;
	arc=none smtp.remote-ip=74.125.231.139
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B506606A689
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B506606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BO7oXA2c
Received: by mail-oo2-f11.google.com with SMTP id 006d021491bc7-71b7aac1211so400368eaf.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795637774; x=1796242574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q1b9Vl4Ai63r6PX/+1MzE13ZwXBrHRrLzRTvx0UyhBM=;
        b=BO7oXA2c/63b647s0C240cIaLxEv7I96HP8VDvXtKm6Of/qTRJ5zJJ6h33kdOw3i4H
         NJ7//DNqoYWuKvzwZkDEAdX/gJQzN9sBhyXCPRwkrgcsoxJz8B/oXq9r62v6cvJ0y9UG
         8ov67BYXbN25z9Fq+BIXpgTAIBTfvGu7QQOCRsOR6CV2ZcTZypk2pwYfz90HRqKs+Xt3
         C9ud4t5fDtA1oEf0pXHS60C8MoubN0H0bw3i2vQgULs2O49EnkhDnpogCuYrkzrHDvA1
         0poObTMmb/8C5mGYF0ciQpHoxIfcIhogww3l4diNewrKmBoel0fhPtEXxrz7reTjm386
         +9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637774; x=1796242574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1b9Vl4Ai63r6PX/+1MzE13ZwXBrHRrLzRTvx0UyhBM=;
        b=b01VNnN35dxCHaPRwP7p7unxwrzWlqxwkzFFRBmrHqCdP804WioouEcSBks0z3A0UX
         X3JeUBzS1aB4PMBgVoL4Wp03pqxt+PC/c3G3ANuiS94/xRiPJF4qXdTbjO41nYXV/oFd
         GcNPxkejACjw0xFJf2d5ktpgnDrqPKpXkPW5lFd+5yCcz5gfOvzUcACJVqN3Pac6peo2
         zHOejEehW3YA8T0pdQLmJnaQrpmcCB6vZR9nSqD/GJjBgCZQskkexWyzrGntgKjnY3b/
         QM6/mmhMFzF8ui0rUrXEY0kDa5OGr+dgidEsoKFOdw4V/sCncV27GB/kdhRZi5mXN9ms
         2d/Q==
X-Forwarded-Encrypted: i=1; AL+hErEsKSgCUAYSCncV6GJHgnxsx2wWE9Xq7VBBTX2rRb0D1ix5/YJXwkgn6Qy10pqL3dN2lqBgras=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ACG2VCxqQ8WGl3uo9llW4piIofjJHWpIfyfZNRdzgajLj1sA6
	oSUPfwrv3xTYxtg2KUXm1TG2mi7CuL2HNym1hw+yK0juc2y2sBkToiw9
X-Gm-Gg: AZFdTZc/lYsalhC8mKCd1PefxhPJiTjLpo88OUfJygTnIfkjnwr5neT5feb4baPntLU
	vhJIq2Y4WUMUpWgmBjKbMLClGBE6ph1iaXXW7hfRciC94j5l5z65S+mq+YvkE5fRsz47ZqHFT5c
	Z6MP9N8Yaj2dNK/8YIjWBSG4amgUQ+mEnzjm21X6gCceR/7DKA2GTAFklz6wvfxon7rtg2YZ7mU
	wrnxJtXZQxz9dxx2Ek0MsR/VqbyJYflp7VFGRy/Po1G6n/FTpwvT5FTMLzO4a8JQkYTRziP2iYq
	VVEWdhr0FCrOfFPIhYkA99Fs+rRCOmJcBGpkzwV6FIytYRUVJ6N+RyXDbvLK1345iZrq+f1AoKP
	M7RFWlw5sEbnzQiGK3QDE4JniAPEG3XDViUVpT+yQTRaTVYFL5pqaJvNeuGINtJFSbsX4pBfGXD
	g58L4JvqUgz8b00fQ7wAgUuezzW99sA1CAoQ8p2wu6CmyhBDEmKi5uMvSSOg8AemNou/+FNM4jt
	De+y7EJivRDMTRGq1QpdRKZpmVs6j04be8oed7lNoidIMHAnnsqlZzbw5/U9zi6bOoa/+TnLNuv
	n+p6kiOWfPzxWnBAhUogT8vKBXA+VGzSMuo=
X-Received: by 2002:a05:6820:2010:b0:71a:f4ed:7027 with SMTP id 006d021491bc7-71b391fd995mr17169426eaf.2.1795637774010;
        Wed, 25 Nov 2026 12:16:14 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm11341859eaf.10.2026.11.25.12.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:16:13 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 14:16:06 -0600
Subject: [PATCH v2 3/9] media: mediatek: vcodec: Report the visible
 rectangle as default compose
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
Message-Id: <20261125-rbrue-suez-upstreaming-mtk-vcodec-mdp-fixes-v2-3-fdc047cf75a5@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795637766; l=3460;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=i81oOhR6sJETIKkjiWKY/HxG7mnnnV0yADrWNY8UjSw=;
 b=VV7JHfQrg50/QoNd+JDg86Ov4ZSO8f0L8h1ZiuwJMvL6wo+DTGTbJl4uiRHRxnfV/fZVveKgr
 eLU/5EMwgXJBAiss1JpFxTToGiGh7sXQ/wA0MfYL9lE4C8h4Jh5GB1Y
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The default compose rectangle of a decoder's CAPTURE queue is the
visible rectangle (dev-decoder.rst: equal to V4L2_SEL_TGT_CROP), but the
driver reported the picture size the firmware gives, which for H.264 is
a whole number of macroblocks: 1088 lines for a 1080-line stream, which
GStreamer then shows with eight lines of garbage. Report the crop
rectangle, as V4L2_SEL_TGT_COMPOSE already does for most codecs, and
return the same rectangle for V4L2_SEL_TGT_COMPOSE and from
VIDIOC_S_SELECTION, which only allows the default.

Fall back to the picture size when the codec leaves the crop rectangle
unset (the stateless VP8 and VP9 ones, for which V4L2_SEL_TGT_COMPOSE
returned the caller's rectangle) or reports it empty. Only MT8173 was
tested.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c       | 38 +++++++++++++---------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index 9339f53431aa..1223738ece4e 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -390,6 +390,26 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 	return vidioc_try_fmt(ctx, f, fmt);
 }
 
+/*
+ * The visible rectangle (dev-decoder.rst), which for H.264 is the stream's
+ * cropping rectangle and not the picture size the firmware reports, which
+ * is a whole number of macroblocks. Not every codec fills it in.
+ */
+static void mtk_vdec_visible_rect(struct mtk_vcodec_dec_ctx *ctx,
+				  struct v4l2_rect *r)
+{
+	struct v4l2_rect crop = {};
+
+	r->left = 0;
+	r->top = 0;
+	r->width = ctx->picinfo.pic_w;
+	r->height = ctx->picinfo.pic_h;
+
+	if (!vdec_if_get_param(ctx, GET_PARAM_CROP_INFO, &crop) &&
+	    crop.width && crop.height)
+		*r = crop;
+}
+
 static int vidioc_vdec_g_selection(struct file *file, void *priv,
 			struct v4l2_selection *s)
 {
@@ -403,10 +423,7 @@ static int vidioc_vdec_g_selection(struct file *file, void *priv,
 
 	switch (s->target) {
 	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
-		s->r.left = 0;
-		s->r.top = 0;
-		s->r.width = ctx->picinfo.pic_w;
-		s->r.height = ctx->picinfo.pic_h;
+		mtk_vdec_visible_rect(ctx, &s->r);
 		break;
 	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
 		s->r.left = 0;
@@ -415,13 +432,7 @@ static int vidioc_vdec_g_selection(struct file *file, void *priv,
 		s->r.height = ctx->picinfo.buf_h;
 		break;
 	case V4L2_SEL_TGT_COMPOSE:
-		if (vdec_if_get_param(ctx, GET_PARAM_CROP_INFO, &(s->r))) {
-			/* set to default value if header info not ready yet*/
-			s->r.left = 0;
-			s->r.top = 0;
-			s->r.width = q_data->visible_width;
-			s->r.height = q_data->visible_height;
-		}
+		mtk_vdec_visible_rect(ctx, &s->r);
 		break;
 	default:
 		return -EINVAL;
@@ -449,10 +460,7 @@ static int vidioc_vdec_s_selection(struct file *file, void *priv,
 
 	switch (s->target) {
 	case V4L2_SEL_TGT_COMPOSE:
-		s->r.left = 0;
-		s->r.top = 0;
-		s->r.width = ctx->picinfo.pic_w;
-		s->r.height = ctx->picinfo.pic_h;
+		mtk_vdec_visible_rect(ctx, &s->r);
 		break;
 	default:
 		return -EINVAL;

-- 
2.56.1

