Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794731988;
	b=fTwDCinF4AWrnEsgGFCXVtHGFSyUsCgMtZMHo4XiL+G361QKe3tYyJJ2ERXGPGe08Df4
	 4D2dzJ7FjSn3EEEoCRgbCL0baS1E/D6xAehRau547b2m3PR9w6eTm9AUUOknLlPZtuPA0
	 yx05gMq0H1s6U7aidTFqgiZAEkaSUqYNASQTfgd5F0JziioeCL5hMb+cRTliPg/ACHdUc
	 BxgOZLiyMHe0Epgf8KXPgnCs1LQ3SFpSBPKmmQCUViT2itGwF/NoILTvObLVDkuFMIC01
	 fUQwt6bWk8QTUnklgPSDKzZQkuSM4+xKacHWEhQr9iKKv7HKlzIgYH/wdTdzOg2AtPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731988;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R+yYJpcqWOx5SFYU80bFg7171WeZPKN7Cwse8Bu2bFE=;
	b=hNSL4FBukZWpjV2B97ulaOOLPXSEtcwHEZwyFJGNEkJEhymNMJk0MVhICMiS3xcZLCdS
	 gCf+gRXT/SPzPmEyDfY4XGm/szciYEB9FuLDoW8Oia88F7T3fONy3SYKtWejVdDKjxenb
	 C4bZ05udoX6Cz4QlzEhbayVSfDV4OgiV72uFY8Yf+TGisd41/w+etdosm/ikXlzuuO9nJ
	 YJ9rVcSXW5sduY9EDWqd7EdaS9Q8A8u16KMjIpE7PMcqNeVJ8fRreY+hqFssKGd8hDJS0
	 3sbgl3NZwYCym00/WqCZm0zfQtqnFuD/YNpeLRgfgIodIRUGFmY8vOivlBYdMMqoiOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbd4LMsW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28740606A32C;
	Sun, 15 Nov 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbd4LMsW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794731988;
	b=y5OGt5jb790As3aYGdOpEQ3sWcT3uwjd88/DhUhaaCQSt7UQqtUJ6a/8VcIYGxtH+0Jk
	 B8FnJn/12cTJGIenYtHb5V5KiwPG+zoq1WcbTU+7heJvvoeRyRKciSEsOS+E1LzFSebdF
	 lypNezTjL4AyPfJszTJe8WccaSVhX8lxfaQuWNFyHR5wTeqEoigvoGrf+HNxF2P6lzyan
	 YHb98/10y/ksOeUlDmCoRYxcw+B6H0fU6KPUvBhZ57Yv2ikTHhhFCfbTGJnbYI5htL+rb
	 SQOEGzbKrCdzC5OkToqzZjkpd47yOsE5YKkufJWgtf7WF1JCQFSrjBezqmEY0CIyNdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794731988;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R+yYJpcqWOx5SFYU80bFg7171WeZPKN7Cwse8Bu2bFE=;
	b=cgsT84Slve2qA+IeyXpdlft6Z9fhvdZGeGl7lXLvGxCFASpfCaRtYSdG3Uz/zcJDl8Gp
	 ORwDFqCjX3puSKbBoOg5hOZ8YmVtOeMLJzH3wbLcM2b7wQbD25tYdRZSnR1lTgAW74eH6
	 ACXQOgY6aIE3hhbq3DwTSoBzXmoU4U8Zvrjg6v1IkGkiMKzHUPhd6R2w1xmFKbRXmQ3z/
	 1//6W+0LdZvBclrk1UIlDPeJSFmkONJWa9LV4kanO1+a27BJWaN17mkDL3flrTGBZKnlM
	 sQesYi8iQGA8zvWp40Gt2zJTUxf6OextjcBHwfpdgwZ9TLSVICHxl2UY+IIbYrXBkAQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 05D2D1F000C6;
	Sun, 15 Nov 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794731987;
	bh=R+yYJpcqWOx5SFYU80bFg7171WeZPKN7Cwse8Bu2bFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lbd4LMsWlEG1ECGpl816WPbOR1MZqZrkOkQAYtNUz/mfYPIyknzLq05XdvNYDN+Hq
	 1DtkA5IVCs6V1Dpk6ixXVvPvMD+i4NDsNmog5FhOnv+gCgsAerJ4lSBm+Hmza6kSyd
	 GjN+VsNkVWmi6lxs/Ry3NUBw2EMUUYQ96Ojqh76Rml03F6CP6o288zZveDX6oVTbHg
	 lBfQ/QcDoId51f1YpsfvW/WxfNn7bLRTbUSxiYRisfHU/sPRYcflOsvX4XctNs3FJh
	 ljKeJ3/so+umKT59A6JQiL6Vy2dy8MCp9XZDq2FDr5xfgOw8GZRhPTlWsFQlxdkiWM
	 z3AnciVjuqVdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 82E3549FF3;
	Sun, 15 Nov 2026 08:39:46 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 08:39:47 +0000
Subject: [PATCH v2 2/4] media: verisilicon: Set need_postproc before
 resetting the CAPTURE format
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
Message-Id: <20261115-hantro-fixes-v2-2-bfecfb07a3e7@gmail.com>
References: <20261115-hantro-fixes-v2-0-bfecfb07a3e7@gmail.com>
In-Reply-To: <20261115-hantro-fixes-v2-0-bfecfb07a3e7@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794731985; l=1877;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=oe2pvkoro5wOifysKLL9UH6IHhWDay22QDh0/q6sVNU=;
 b=A6gSEoDU9G0ej0keppdaO7K4g8UiXgtSjrXV0v1cdT9YXaQnzNyjRUWDjmEZq7fbAM3G1L67V
 Lq94phSWa68BcT4jDzSKiHHse7FamKlsa2wZWZy9dH22UvAemx3aNT3
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

hantro_reset_raw_fmt() sets bit_depth and need_postproc only after
hantro_set_fmt_cap(), so hantro_try_fmt() sizes the format with the old
values: after AV1 film grain is turned off, the CAPTURE buffers lack the
motion vector area. Set them first and restore them on error.

Fixes: 80c7373a456e ("media: verisilicon: Conditionally ignore native formats")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..5939fffc350d 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -449,6 +449,8 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc)
 {
 	const struct hantro_fmt *raw_vpu_fmt;
 	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
+	bool old_need_postproc = ctx->need_postproc;
+	int old_bit_depth = ctx->bit_depth;
 	int ret;
 
 	raw_vpu_fmt = hantro_get_default_fmt(ctx, false, bit_depth, need_postproc);
@@ -465,14 +467,17 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth, bool need_postproc)
 	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
 	raw_fmt.width = encoded_fmt->width;
 	raw_fmt.height = encoded_fmt->height;
+
+	ctx->bit_depth = bit_depth;
+	ctx->need_postproc = need_postproc;
 	if (ctx->is_encoder)
 		ret = hantro_set_fmt_out(ctx, &raw_fmt, need_postproc);
 	else
 		ret = hantro_set_fmt_cap(ctx, &raw_fmt);
 
-	if (!ret) {
-		ctx->bit_depth = bit_depth;
-		ctx->need_postproc = need_postproc;
+	if (ret) {
+		ctx->bit_depth = old_bit_depth;
+		ctx->need_postproc = old_need_postproc;
 	}
 
 	return ret;

-- 
2.55.0


