Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795712456;
	b=pxwgjk9sO9UwTb+11TctlxyhqE6VOM1Pz2ZyHbhfaBJ/TT3dJp2ecWgr6xmRfvu2hqFH
	 QpffQML/M2NTcteDXWny/JPvmBd6Ai9tuVIKh2OjXysjkm9UHmfSZIvRMwaqFK7ojephF
	 +453Kxet9K4xuZCinBtmSMERGXcOnbt1bj+z8iVzl6qBV3ih3NZf7JMPsW4k4kIfUdThu
	 PzBesdp2X2MG0Pv71kgjbzdYN6IZiCtDwIR+sq8exUU56+y14fMfxoWgWt9nwy343Mff1
	 aSnCsp9i+9k6KXvrNdKX30xm3kNiAR0SMHXn34F4zTnh32qlVtgQuO5b7Mb3WxpBmLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712456;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0nIKyS2KHlhtIHI+06ViDl8QECNoOxLRbmSglgantdI=;
	b=5mt9qnO5wCPFfcWIQXTJtFtGb6n0MFXxYkA5piDi3pTV207gh38KYi70dT0RvqsrJsrP
	 wzX80k7dtcn6VuJ+WJCD5IV4THD8/6dwz6JLNtHkDz7AurYdXKmbyIsFFVz0mOnn4xRT9
	 FXiJtKRmsQhWTBQiCZ8v/+TQf5ccBAvOAixtkTLUkQbt/+n0WYNMVEMr/zXIHWPqa28SU
	 K6hS4UPc4bcD5AuvbXbKr6XLunMPr4inOQ5sdbuzpuJC0tublJ5tcAsc0pdOEWVUFmR/e
	 36yFUt54JktWTTKzmJ9Atzx1Vf7D3HfgqPw34np35Y/+ouTUuYga1XfQoml0BikcpLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kACJmnIg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED6606A321;
	Thu, 26 Nov 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kACJmnIg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795712455;
	b=RLSdUWNEL3U31AUTDlvR1h4LTgEOdX5+eM4nUFbThzVJQDFDKKdIehnpPr15jjaV8QKE
	 M3qokWZyCC/ykkrJxpEcfXH/P2/eiqK0uJgUzYiqrP+XQnkQ/h/3jCYti2GrnEHR04mQU
	 nEwc76dDo76PUbSd+/ZuasO6ljagW3m3dXzsGwvyJBBGHgJff6kJOrc9U7+lSZ/6Cz14h
	 LJgosnXu1AdlxYUJYLxNpj2lPygDP0HYSqCWCvqzo3PwWXzvG+7WjR/96/XmrdAKP5kBV
	 JDdYmka5JJzzc+2q2I+L2caXWyrwsiqQor1Bh9icD96csMBK9AFtHRmQdJA3v71V1hA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795712455;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0nIKyS2KHlhtIHI+06ViDl8QECNoOxLRbmSglgantdI=;
	b=yKzOApCk8ZynE8Kv9NCvCVkes5HSeRMgAYP/tZUuLmizSXX5TSFK854iuBHoGKfEKL9Y
	 vb6udmX3Mg0yrVATcOgwEm3ncKduHIG75KXI/mMViUJKoKjMz5JR18WMXg5Qn92KCiEfq
	 lTA3CCTdCelbt6MGmm7TJ2p+7HSM7mGR5p9cba/8SsjMTPSlImOodfdyDO6YPyQGR9VQu
	 aPig7LNnfsImMuACPfnDwbdmE61t8Cy4u4b+Mfi4Ecw0zTH8C/JmwUA2Qc2lsQ3qOzQOc
	 vw6AN4qFXt7y2TVdFwyokdU/Wk1uk+A2VOEQdbaKWCPZyx6wO/uchODwztTeNTYK2pQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC7131F000C4;
	Thu, 26 Nov 2026 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712455;
	bh=0nIKyS2KHlhtIHI+06ViDl8QECNoOxLRbmSglgantdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kACJmnIgAG43bIA/5uFJp1viCKDlbLoMLQ/YEHSQTDWaVz6ghDtQBPoVxeXZ9whs9
	 yh+l4zjSFmK3Ml5Xp4TcPRi2QnpvbgJ5tJV5X0qmt+Iqdo8Yhdve0Mc2GXm1fjxIAz
	 EmdgXzf1d1/AqCMLZWBlnU6uCT8v+1Fe70F+4NH4/6PRBb5D4cIPUB1UsJFhK9Az9G
	 klnrp08bdxTRhWr7Zlb9DUB6UvlJp7vOGW/DwOJLckGjjLHoWisCiGE5bGZTKI5dU3
	 nLYyq2a3WC34r1i/UJdny+cgN7C/4f1S+nYqfWyWFALg/cQVlrJKgAWnOyMXJh1kH8
	 eSIMQKy6fjS/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 630044D749;
	Thu, 26 Nov 2026 17:00:53 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 17:00:53 +0000
Subject: [PATCH v3 1/5] media: verisilicon: Keep the encoder CAPTURE format
 while buffers exist
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
Message-Id: <20261126-hantro-jpeg-enc-fixes-v3-1-07357d84a64b@gmail.com>
References: <20261126-hantro-jpeg-enc-fixes-v3-0-07357d84a64b@gmail.com>
In-Reply-To: <20261126-hantro-jpeg-enc-fixes-v3-0-07357d84a64b@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795712452; l=1271;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=rhVB/MQQBTXrMfV0wT+knKAvpmw8YXdorkxIRoc8kco=;
 b=QRkbjQEFZtsRyIsCY+XfpjOgKRWx3yh2lAg5TN2NUtiEbbyJRmPwR05LgXfUCqsWGmMHShTQu
 xjX+GWWfRuoAlWQwMMFqfrKzqfeWjmwsH0jleRRUOHPV+10JUZv8lsf
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Commit bbd267daf4fc ("media: verisilicon: vp9: Allow to change
resolution while streaming") dropped the CAPTURE busy check in
hantro_set_fmt_cap() for decoders. On the encoder, CAPTURE is the coded
queue, so its sizeimage can now change under allocated buffers. Restore
the check for the encoder.

Fixes: bbd267daf4fc ("media: verisilicon: vp9: Allow to change resolution while streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..0d6d4f36d012 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -596,7 +596,12 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
 	int ret;
 
 	if (ctx->is_encoder) {
-		struct vb2_queue *peer_vq;
+		struct vb2_queue *vq, *peer_vq;
+
+		vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+				     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+		if (vb2_is_busy(vq))
+			return -EBUSY;
 
 		/*
 		 * Since format change on the CAPTURE queue will reset

-- 
2.55.0


