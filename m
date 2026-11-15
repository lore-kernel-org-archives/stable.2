Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794731988;
	b=gkJILMKkNZi9CRQyoSAe5mLHDdPT58NmP/mq+anlkw3OhLaRIAYMhTnTL8gWk7056XQc
	 tiwVQ4TX4MmX6c/G3xfhKBG4wZkPGNxQSDuBn3mi2UdRd1tCp6lTn6tgl7kkJrXOHgtLt
	 LD5PdYllKekMkzRXyqmdRFBqi8dN58WtqLumpwWIDeYoTYeWybXj6KXqhQ9RuJ0BCx1My
	 k7Nk4VK4OlkO5GPwTKP2MFybJ1h7yWZD8MuOEy3jMMR7BGw3OuPonWhgHQn+1gLbafJho
	 pz2E6znUB26o8pDWlR8/ssun6OAlzWk8YBjpZhk8SvE7X7yL4IRBasqTemLuGrJ4ayA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731988;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3HUV0Y0/pDNleOpw0PJEaMjTYo1DjmGUdWEj9hdImzk=;
	b=vnRVmjgh81GDqyfKVwxuf1gTobaBqBb00RQbCeOS93vfWHLfg6w0r+K5EOYsH5Lf2h57
	 uoqFQEwm/SLXqrGCKP/xs2l0yiXXb3lIA7RIxZu9wvQT4vt1G2IsTVPCJiSy+1TFP6Z4v
	 KizN1VFw4o9JOGekikI+kpm9cKmKK3o0e6HYlfn5fvXgh5mfgl+tWYcamGVOAbtAzjkUo
	 43lR+JVXHe9fI+a5O+1PnRKsU3sIkZHxmR/7hwsFuOW9EAn+xJoheOx0vP+9Wpv+M6FTf
	 BhrOrm2qppq8gEy4FTupYw5Q09BKVd1tckJO7E20EI3eZeoweaUNwirup7g84w1hwsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vxw4JB3t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B4606A332;
	Sun, 15 Nov 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vxw4JB3t
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794731988;
	b=Cd0lArZ0y7b5JJCFyknF66t/PvOsnOLLBys4ElOhYnVhTypKSHqKblY+rZBcstnDqlDE
	 RTA0mILQLv/QFYgrMRj/Z+lZausZM5GypVrZGDJBHiFL9s87ZClqvIld3rk2FUcP8n487
	 p79gYAGDrPc4DUKJ89rJwrVwbSRHcknenar5+MfpTBNMP+ZzuTZtC08PAogfJ0jkoojuJ
	 98h6tVIQ+JZseY8xA9WdV0vvre1PTa6ztHdqr1CU3ayb1Lz1gnmbBGe9a0v1IPoo1wgKv
	 TT/xdl00378Gl7cNX6py3Ra9P71IYzQQkbkfKheGxA+vRHFyp4TTQSPfgP7QJhqEgqA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794731988;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3HUV0Y0/pDNleOpw0PJEaMjTYo1DjmGUdWEj9hdImzk=;
	b=prbu4jSOghJCv9XGKwKsnvUb1d7GoJjdueLqKnS7oXKJD1g/Gl5nNiXahzxaDTj9mXQ4
	 s9FcIUIA0BvNGH2g8KaxWioYPDtP4B7UAVjtl3A6g0eFumyfwoOnfnwdkubwuJhcXu1jy
	 ysZisBFWA0aG1PAI5bf6W5WfcU/WjPIQdNTG0K8CEYJTk80qvR1tAaI825VZZJcUkhxnV
	 D/rulY/4vh7CIkK8pbyd4qiLGrI6XU29d1ONMGwcOGpJOugn4G63idrh53ViGsrP+tSEw
	 POfE+Kr6BWhGBe7tF5CR77a0lrnevCGte/L3ll0h3/3QztjpyLZdSSw5qqpPHgDOYNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 33D681F000C8;
	Sun, 15 Nov 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794731988;
	bh=3HUV0Y0/pDNleOpw0PJEaMjTYo1DjmGUdWEj9hdImzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Vxw4JB3tAk5rgsAkaIfljbQYPEgCyjR0MtPU7XAxsZvh70mdy6noDDK2qjpEpRwgo
	 BwXekSyYTINWdCl93vpg6fQRBxh/j7InDGycfVPq93ipCF4JnFaLlrVtL5zid32B2U
	 Syx/u/EW7C9EW6cXYUsveH9cdlUM3KNwLrkT7hxnzll+baK0d7duYZHedrXggrmE0m
	 0Mf1e+2xdna2YtawnYpGAVERaHdCMtNNGh0++Y/w4ayNVTDPZqci38QLX8R5GBxQNl
	 W5Lg0j6bymKOm4xpky9+qOl1aJ1+dPxxdtSnMK42ohGPz6qu4GYG5Is0zs3mngoffu
	 h9psDyzZABB0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B086A49FFA;
	Sun, 15 Nov 2026 08:39:46 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 08:39:49 +0000
Subject: [PATCH v2 4/4] media: verisilicon: Set the bit depth again when
 its control is rewritten
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
Message-Id: <20261115-hantro-fixes-v2-4-bfecfb07a3e7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794731985; l=2693;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=HWxB2YEEQC+V3ysP/l33g5scqDBlUMjlgqm8A4O3QvE=;
 b=6IQgd9D/SW76qY9HjFa29Wet/8gTddE+EEmFkx5EZ/ybrFIcq5PbxkpFRoUW8Zk6kq8g819nD
 uC1L5n9cMfQB2Y9RbbhF53rMWsZjScbPNRs7yOHajMko/fVGe+hiz+q
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

S_FMT on OUTPUT resets the CAPTURE format to 8 bits, but rewriting an
unchanged 10-bit HEVC SPS, VP9 frame or AV1 sequence control skips
s_ctrl, so the format stays 8-bit. Mark these controls EXECUTE_ON_WRITE;
every write of them then also sends a V4L2_EVENT_CTRL value change.

Fixes: 3c32d94c9c52 ("media: verisilicon: Do not change context bit depth before validating the format")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..248fb0e23a29 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -534,6 +534,7 @@ static const struct hantro_ctrl controls[] = {
 		.cfg = {
 			.id = V4L2_CID_STATELESS_HEVC_SPS,
 			.ops = &hantro_hevc_ctrl_ops,
+			.flags = V4L2_CTRL_FLAG_EXECUTE_ON_WRITE,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
@@ -555,6 +556,7 @@ static const struct hantro_ctrl controls[] = {
 		.cfg = {
 			.id = V4L2_CID_STATELESS_VP9_FRAME,
 			.ops = &hantro_vp9_ctrl_ops,
+			.flags = V4L2_CTRL_FLAG_EXECUTE_ON_WRITE,
 		},
 	}, {
 		.codec = HANTRO_VP9_DECODER,
@@ -577,6 +579,7 @@ static const struct hantro_ctrl controls[] = {
 		.cfg = {
 			.id = V4L2_CID_STATELESS_AV1_SEQUENCE,
 			.ops = &hantro_av1_ctrl_ops,
+			.flags = V4L2_CTRL_FLAG_EXECUTE_ON_WRITE,
 		},
 	}, {
 		.codec = HANTRO_AV1_DECODER,
@@ -591,6 +594,7 @@ static int hantro_ctrls_setup(struct hantro_dev *vpu,
 			      int allowed_codecs)
 {
 	int i, num_ctrls = ARRAY_SIZE(controls);
+	struct v4l2_ctrl *ctrl;
 
 	v4l2_ctrl_handler_init(&ctx->ctrl_handler, num_ctrls);
 
@@ -598,8 +602,8 @@ static int hantro_ctrls_setup(struct hantro_dev *vpu,
 		if (!(allowed_codecs & controls[i].codec))
 			continue;
 
-		v4l2_ctrl_new_custom(&ctx->ctrl_handler,
-				     &controls[i].cfg, NULL);
+		ctrl = v4l2_ctrl_new_custom(&ctx->ctrl_handler,
+					    &controls[i].cfg, NULL);
 		if (ctx->ctrl_handler.error) {
 			vpu_err("Adding control (%d) failed %d\n",
 				controls[i].cfg.id,
@@ -607,6 +611,10 @@ static int hantro_ctrls_setup(struct hantro_dev *vpu,
 			v4l2_ctrl_handler_free(&ctx->ctrl_handler);
 			return ctx->ctrl_handler.error;
 		}
+
+		/* v4l2_ctrl_new_custom() drops cfg.flags of standard controls. */
+		if (ctrl)
+			ctrl->flags |= controls[i].cfg.flags & V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
 	}
 	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
 }

-- 
2.55.0


