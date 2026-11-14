Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615255;
	b=FWPNkPduA9ujqMBT4IILCQ73ldZk91z9PIRi/mRs2M8dWYDfwbR+eTjvFV/bsbeDAAST
	 84XVQ/RKundONk7Dg70rMrviHOp+L84Kwsa7LoIL6rNG1C3evLUaHv565UZQdP2PuEy6R
	 rBT2Ge8s20NNrG6Fmp+wlMFt2Jn5t/T3DX5uTsTIpWhTfKgAjj2hcdcsOjmUckMpzHUdn
	 wTmWErCX9aTs92CP8XqySPnc46z7jLbNzergu2ZqjvukBBF144KSYA0SCyz0EtNpCBVy5
	 N7JJKj7h3W6BNS/WcTglzkAy87Af2Umpzz+ddRD0+8jawWooGeyVpIOxO2P8+b+IOSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615255;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wxKzoWd8znOVxZHovUv0aCQVRbaHaH7T+GMsvURWN8k=;
	b=jvG12iEw8qDvf9qveSmiCWlIwTw/1NIvxj87hmkGHhTLwfYKuPohvPR5EKaX8z+CHvYJ
	 qbaVs39m3mrUi5uPpxn2iN4JBx17lKYRhozKAiKpbZnOCXTveHO8e5FpxJQzmkCHC2EpL
	 aNr2u4hRfyk+nA4SmKjNUHpnvyauiqebACqeYnnYIaNQDO7Uka1wj3TeJuTGwXnWKQbaW
	 Mtducy5mIS5o9PyRx87TeWtBJCrqZr7JEYbvP7FXKP0OjJdjrbfaDYLY9+SO/UX0T4CMD
	 /3DkByYj+QX8k4VlQeHqBAyCbrTAm9phEZInYuIHEFOrzRnM5zoqw+my0qQ5mLwtWyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYLWIbeq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8420606A884;
	Sat, 14 Nov 2026 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYLWIbeq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615255;
	b=tt2I4sedBlDmPOaYboWGVTTmGXhNhtQpPpQdS1RY1ecx6qpQ0VMHgp61x34dMZBT+qZo
	 wbst7DBpkgs9Rf1ZVrUmBs4LI/ZWNQMx16ZxdgeoMITGP/8gBOjZefBobLjoECJ0I+oGx
	 XKqzRLMqFpqwbfAyv/wO5OT6mwaW4kh3BlNEqURY+y6eUIKPfx4c/TD9OcG49aTSip5J/
	 UMGV6HBZTC2aDNJaMQDhX0HvEfr3F3u/yjN6jt3hi7UVd99gNRm+jawEL++ZVPr4tp0yQ
	 Tsv9hIr5EpC/0arw/VsE6CbtIvn+MhRvO49j5TBnKp6xU5o79J34b0Z3aXXJxjL+9gw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615255;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wxKzoWd8znOVxZHovUv0aCQVRbaHaH7T+GMsvURWN8k=;
	b=WBqgRM0VXWXwy6qnXvb/aR3Pe2ZXvl5Bnqx32+jy/mR4w94T66KP9DUjOX3/BNJoPuCH
	 yExPCo+SXP9iJ0r5oD9HD8+ry6IeGBjgfExZwUaFh+00fLkuhZaAtkzDtUSrThiQbEUJN
	 Amfdbxh1kEo1e3jXQKWyaVNQsXtr8AEFwIZ6ZqpD8mLIR6cfau7KjfNopm/c8BzpB3y6Y
	 oB6uk5X2KUeJJePgtNTI39zGBeTRoM5RCgmIT+2mflgidxKO2yWrxQoIr1ifT5BL3DZqW
	 lwuyfcZ2lgy8Cl6vudLWhEBVVxGX34/FDU6N6oa1tohpK+TrbIH0q0QrTaLc2bFEL7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3549F1F000CB;
	Sat, 14 Nov 2026 00:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615255;
	bh=wxKzoWd8znOVxZHovUv0aCQVRbaHaH7T+GMsvURWN8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YYLWIbeqU1nWZGysrGIE3XxHVeN/5OVYIrxaCSdNNc5i6AfLokpfPsGrbLIGagdkx
	 8hQfscLfmkKJvomJVN1LjASYjk2E0MZLBGMfLwADiYSKNHMxjw4CBFbDRXdkcWM/5S
	 kgKeWWMIXSuktXE+W+FRECK2Sf/rHG6rACT8U0B34kVIik3ln6Dt+5M/5as2tqdD4g
	 oFORt1Ku8ypU89E5kCykQ/d8GA1oMkQ3ul0XannN3Yt6nd7o+QNXv0v2VbGPAWu38f
	 SH9YEGnM3fe60Gunrq6bs62UkGIttNxeL91Gh2pZpoVuOUC6Ib7nhB6kR4xrRYEC1w
	 oNRLAj2rnOtvg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B496849BCB;
	Sat, 14 Nov 2026 00:14:12 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 00:14:15 +0000
Subject: [PATCH 4/4] media: verisilicon: Set the bit depth again when its
 control is rewritten
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
Message-Id: <20261114-hantro-fixes-v1-4-abb78264801e@gmail.com>
References: <20261114-hantro-fixes-v1-0-abb78264801e@gmail.com>
In-Reply-To: <20261114-hantro-fixes-v1-0-abb78264801e@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615252; l=3003;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=g1FKZCeiFkbp6h/EOPblVSfvHIN9lybSdPAZ2FY8L+U=;
 b=XtEqFv07p6afEIhLvhgVrMIRR/y2skjNRqfE0Ws4C+M2qg8OS812JKjgaRNebETxXcT5KQDj3
 HfHLsUAESK+DH2MKcgwHY6jkvcthvi9BFAilADw8gmFmIhat9Y4tKkp
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

S_FMT on the OUTPUT queue resets the CAPTURE format to 8 bits, but the
HEVC SPS, VP9 frame and AV1 sequence controls keep their 10-bit value.
Writing the same value again doesn't call s_ctrl, so the CAPTURE format
stays at 8 bits while the decoder writes 10-bit pictures. The same holds
for the AV1 film grain flag.

Mark these controls EXECUTE_ON_WRITE. Every write of them then sends a
V4L2_EVENT_CTRL value change, and VIDIOC_QUERY_EXT_CTRL shows the flag.

Found by Sashiko in its review of hantro-dec-size-check v1.

Fixes: 3c32d94c9c52 ("media: verisilicon: Do not change context bit depth before validating the format")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..dffba6c43a0f 100644
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
@@ -607,6 +611,12 @@ static int hantro_ctrls_setup(struct hantro_dev *vpu,
 			v4l2_ctrl_handler_free(&ctx->ctrl_handler);
 			return ctx->ctrl_handler.error;
 		}
+
+		/*
+		 * Standard controls get their flags from the core. S_FMT on
+		 * OUTPUT resets the bit depth: set it again on every write.
+		 */
+		ctrl->flags |= controls[i].cfg.flags & V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
 	}
 	return v4l2_ctrl_handler_setup(&ctx->ctrl_handler);
 }

-- 
2.55.0


