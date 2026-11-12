Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472284;
	b=zggCJDB+T7AyLITEKwoFgl9VJOIJV6l5PALBQ5oNDM0PBC5JY2LawWZUdEIVhQZAs0mS
	 RCpGr4o+FqBBoeoddgkC6E2ReCPY8Yw1Q+ogqpeGxK0F9JoA+iVJp6LogwHgeZf71PMUH
	 Iqb0aU7jFxfO30slrbrzYHAvfntd6kiuvnc4PHXdo/EnbY56nWJXmPTMKFcJNlW6e+QXm
	 9m6n3HaAT04dy45xyqJ5lvwcu3w6Io6YYZZx01Tq6GmrZCQwQkXUiZmDr3eYfWj5kbIoq
	 hE5R3yyXybAqAqjrVyX39pe3TNp2BSt4pcwFWKcWAm5K5eiAqpMicsGhoRcvDbKBFqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472284;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pZakbjmrYAUi2laxy/i8wT4W0cRFx1oiNblobUK/5XY=;
	b=JCN407ZKsVa5dP3g4JEFrz2naed+4pKijiiZuKMAS7pOqZL7HhLFfyxTz2H0ZUSqwSXb
	 eRgaPfsNvvHAttYUCxp8T2kU2dgzWsnGc6OClk+bQ5a0VG30bXao6G+lLybhq77yxLIZZ
	 N4sraaVIdyDx43ypFIo6GMjqj92Lvj4TOX0ML/Qy8OOWw0VSJL+wwyVkgcYg+UQ2oVCI5
	 mI42GRwfDJAfwIhwIg5HAmvW8TupEL3hfWhfblvRuWjNx3CKHkQl1FOPw3Uifca9J0+Ak
	 VgdWtbIMSeIqjdkls9GpOGzDeygTvoDZAcESJ7mPmYpnbPq8tFCri6ea8wsVY2fdRqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7HGMSl4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB641606A330;
	Thu, 12 Nov 2026 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7HGMSl4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472284;
	b=GfXfT3xLYaZ5waiBO5TgYOIMEsJS2mB6xkuofqbKkbc4zbQr9aGZJ0JlFSKWF0UVMpX0
	 gIg3gIjEvtQmNj+4k0UstXRZZ8SsBM8ieeiWgLEarpC1YwBP2foHFajbpbpfvbrV+LNfi
	 ZpJ24oZeJ98xFjlqO5qUxARCGqQWap2FfR5Rk5KPNF8DCV2u55IVGd8OiO+z4PtM3Tcyb
	 +oz5e4hZrh50a7EDXtZUAMaxAG6AiGzzSXXP0rpJ7Y7afrO61bUEDUQR2ToQw0fRkD/Mt
	 +eecd5kgeOYax+fQQK6DWe5BttJMdni+IV74m7PCRHiHNHsldAwI6qdCqL3PPOVsNzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472284;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pZakbjmrYAUi2laxy/i8wT4W0cRFx1oiNblobUK/5XY=;
	b=xUuUioBLoz4RMG6RzBWoOrL8xCf8gM72UYcx0j3YCes3pbda6MnNJlYhAHt/PLqu3FKx
	 8wRGXqJbvgVnKsEPqNgjsOwSlsBHbBeDrzl3LhX5bc+BsVDjdSVF3dq9KkXjXSqcw0NBN
	 UBopE0XqEaVqvRH54tt+s9A9rcD49KpwkhNHCFO2rHHHKAb/RB3Q/r25GfsESL2W6GVzf
	 uESwJXN6wqCW/Rs+7+yFs8ALzZoDwrK0iSVx3T0Ke+MNOExkVC+ttWG3rSgK7CP2ud1nD
	 pWlfEo+i2zRE52jLgxbK7dxDhOO486c9mfjke8zOcEfZKAfdhcIpNJdFeK2g1LYCrxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ED3DB1F00A0B;
	Thu, 12 Nov 2026 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472284;
	bh=pZakbjmrYAUi2laxy/i8wT4W0cRFx1oiNblobUK/5XY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=j7HGMSl4m7aTZKc9NEgGXw+/pyVjGgPx5lJNFaAjpJLaKtCYYVZsm0JrKBd2YSszn
	 UKQhOBEddQzlJvuovn8+W3jpS2Ge5RDzt5e2h2/CQsuwpQL7lfLxZKYVHqwNS4N5wY
	 F8gtCn3GBzQp2wZWT5Laf/EAGNbsAzAvBjl64LYnP13PD+w4gm4PG52+sn5NWf8SyX
	 FuixuS3VhilrOFe0WPpmOYZMF3QlqIacyLhFYZ0VSp+wGC9dHVPYEwWnbbhz4oztlt
	 9kf2dfBT/DFz3sa2qU5witSbz1t9bvy2Alv+8NQEZsF3w5kgDrXQ/+yILFghw/kiBJ
	 eY5xRNOY6N61A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7CF7149389;
	Thu, 12 Nov 2026 08:31:23 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:31:23 +0000
Subject: [PATCH v2 1/7] media: verisilicon: Keep the encoder CAPTURE format
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
Message-Id: <20261112-hantro-jpeg-enc-fixes-v2-1-de03e643c75d@gmail.com>
References: <20261112-hantro-jpeg-enc-fixes-v2-0-de03e643c75d@gmail.com>
In-Reply-To: <20261112-hantro-jpeg-enc-fixes-v2-0-de03e643c75d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472282; l=1571;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=7zDhcZU0lTpApx1EUzAD0IAc3hAGo9Ri1nYbxunoybc=;
 b=VaOagJtxtLbJjMIi0AjpaEOh/LVDBVpBUdjPoVus+uiAlo12MT+Je3MwbMPDvcK8be2lsntXj
 tamKKUagZw+D59aJB9F/PbI3io6c0VCMIF/IBnr2GKKHPmUkYRE7o3i
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Commit bbd267daf4fc ("media: verisilicon: vp9: Allow to change
resolution while streaming") dropped the busy check of the CAPTURE queue
in hantro_set_fmt_cap() to let the decoder change resolutions. On the
encoder, CAPTURE is the coded queue, and its format can now be changed
while buffers are allocated, prepared or queued: the new sizeimage, and
the size of the OUTPUT format reset along with it, no longer match the
buffers.

Return -EBUSY again for the encoder when the CAPTURE queue is busy, as
before that commit.

Fixes: bbd267daf4fc ("media: verisilicon: vp9: Allow to change resolution while streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..d033fe0ecef6 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -596,7 +596,13 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
 	int ret;
 
 	if (ctx->is_encoder) {
-		struct vb2_queue *peer_vq;
+		struct vb2_queue *vq, *peer_vq;
+
+		/* The CAPTURE buffers are sized for the current coded format. */
+		vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+				     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+		if (vb2_is_busy(vq))
+			return -EBUSY;
 
 		/*
 		 * Since format change on the CAPTURE queue will reset

-- 
2.55.0


