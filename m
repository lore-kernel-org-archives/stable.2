Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794231840;
	b=DJv3jsO5KlN+d5zEwYkHfepNLqDF33XP+fp4iB8gqy+/sWxVXuq8ygAthhNXn9t4UbvZ
	 wRysqW1hqDfRvKZVNVQiCY51DvWJcV5RlvJsB10ajwEGCN2YihwvqRGJH3e9hVqQ3BTdM
	 jCqt/6RgW1/88arV/T1B7GWY8vP0Kec3laKtoVyd61B4lAexnEYYn0cpa9ZVNX/WhuC3w
	 fhI8tggi+DcM+b5UKtggJe/SJa4NWTUg3YSGHjHRkAXW9CYbGCVX+Fr2oAWeMbY0mhOQ7
	 o4PhPE7GuBdg2dl4zhfNMvxVi5nLpBpr5aGNj7BqKAOmStKDTy3GIjqZUK8Gsrr+s2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231840;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dxFF6g1VuQrfYyviqJd3wYlhSIvrVebHZJ6V7nYzInY=;
	b=T2sB5l2gK4KIZOuHepTf+XHn6xF8Y6RFxIDS5euHbHUX+49f5YCPuQ3VVITWu12YB66X
	 3GwpWKIsdm69Q3SH8Bh4EEOK7tfZVIC+fda2qI7HwkrGD7EBOPSSKiztRnBvNufcywz78
	 ctGDrRWDQnpUpfXHM5FitIj0X5jiZ/lNkQn0nL8/C73s3LF/gI8kiMdVHQXxr1aKQ8KVb
	 MY3Oxg2/mYqKFa/e1Ue99rLtXQdZXFgqyVhEMdwXfQ9jA3BruIXB/HBHKVcbFZ+C7SvJl
	 i9x/+oj0M1qnnn6IJ6CCAn6RgLivUGKViq45ysYA2H18cDnuqnhMcnC649zkKaZgubA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZcAwv8v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26D606A323;
	Mon,  9 Nov 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZcAwv8v
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794231839;
	b=n2dFmlMp/5mtqOXs/kAVLVDxwpVKAKVBkcqf8zgjLMvjl+QY86vnQ0kX5uW4Vfg5TM4P
	 z9CL0+R4LYxGTQb3DPmqv6yVGkXHx+CPI4gfhDt4969yyS//Js/STNjlrflgbOJpySifW
	 ncWiIM2zl/nDaOc96fKnFMSOgJa0PTUSHYkncA5yRybfrvE4i4msuHtDz5llPrUZ75tMg
	 wEiW7rrRnd7M5Z5OLxspMBCi+Kb8Vsg3KPayInM6nv04ROjKY/quJ5e/Ersm8dr4/3mAG
	 9qcvVfdoyO1vjdpYBkWODm5l4yZS96azTnBp6yNS54vh/gHd4+xXQBrhi6M+UN+rjxQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794231839;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dxFF6g1VuQrfYyviqJd3wYlhSIvrVebHZJ6V7nYzInY=;
	b=k5aVwR7bUuGCQMuJaBFc1WKF0kNv1LPkI22bcgf/KIUI3GsISDWIghBMojZAsS+OZYZn
	 qmPvIIzOW7i0fA3P7+qzLs47Q96lvlPVjsv6/FmNA0uoLAT0HgBBR2yRS2E+ubXYt13Zr
	 FCCuIW8juebLjWu5NAwRBb4c5Zq8QSRFr9pb1yrXh760WRTLBqsi0I07zsdxbrqaZfwyC
	 U+9KQnaatlM2VAElBiVZuKk8ck8PR3ZWKKW02sUA5fylB8X4wjTj2kGRzUV/eobJP4ZdQ
	 4Ezf75fKbOMaF0v+PATUZlzLqY26ZA3w7B2Ix7PRP8pIEomtRZV3NC2fzwCSKYxWmvQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 47B731F008A2;
	Mon,  9 Nov 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231839;
	bh=dxFF6g1VuQrfYyviqJd3wYlhSIvrVebHZJ6V7nYzInY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PZcAwv8vbHUdW4pntIICC02hyijXh+qUkKGAXhnIepwUyZTSnqAg+2KVPnkBrR8TI
	 dItUCmcc4ucWjL3mVkuBFmOUQHvWCD2EBO78nYVHHh98doQJOzp9klQtWUUXz7pQ40
	 r8dfH84Hoojbj0ztTha5K/1RM1IfuY4XqAa7PAtXoRrvwPmvTvczqaLkqntnssSCuD
	 7sscitueOObnj75GXqMq0TpZbx3KhiOyDBS4LkVcgZMWbhnj1980sJzPUoWeqWKYwR
	 JRfEYmVbtxc+GkLlWYZDNwQNoPqc7PQV6QEMPCbAWVkqom+LJXP1QoT7YUTTdj2tDW
	 c4L6mZBvgTlOg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CDCA9484C1;
	Mon,  9 Nov 2026 13:43:57 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 16:43:52 +0300
Subject: [PATCH 2/3] media: verisilicon: program the H1 JPEG stream limit
 in 64-bit words
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
Message-Id: <20261109-hantro-buflimit-v1-2-f0b86ce61e66@gmail.com>
References: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
In-Reply-To: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794231837; l=4212;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=YK3E1q/MxAtcBQVsrMtlnwZsWtudnoCZ/mj9nUB82Sw=;
 b=pywUwWFlxV95giMYgYS1GRar2cxlY1SxSiD+V7TeIDBpGxEnUU+CAnv+9OzMdgPqCpD3oypY8
 X7ZJWsernX6DmkEY66rt3mM8jyhQ5mpKkcMrVDDn9oCwjdqPrDNz8mm
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

The H1 JPEG encoder takes the stream buffer limit in 64-bit words. The
same register reads back the stream size in bits when the frame is
done, which hantro_h1_jpeg_enc_done() already divides by 8. The driver
writes the room left in the CAPTURE plane in bytes, so the hardware may
write up to eight times the buffer size, and a stream that does not fit
runs past the end of the plane into whatever memory follows it.

Userspace can get there. hantro_try_fmt() keeps any non-zero CAPTURE
sizeimage, and even the default of header_size + width * height * 2 is
not a bound: at quality 100 a high-entropy frame takes up to about 2.75
bytes per pixel. On a 640x480 frame the encoder wrote 230 KB past the
end of a default-sized buffer, on a 1920x1088 frame 1.6 MB. Without an
IOMMU in front of the encoder that is memory owned by someone else.

Write the limit in 64-bit words, rounded down to whole 64-byte bursts:
on the RK3026 the encoder writes the stream in 64-byte bursts and
finishes a burst it has started, so a limit that is not a multiple of 8
words lets it write up to 56 bytes past it. Rockchip's MPP library
programs this register the same way for H.264, in 64-bit words rounded
down to a multiple of 8 (mpp/hal/vpu/h264e/hal_h264e_vepu1_v2.c). The
stream starts header_size (624) bytes into the plane, so its address
stays 8-byte aligned. A stream that does not fit now stops at the limit
with a buffer-full interrupt, and the frame comes back with the ERROR
flag. A plane with less than one burst after the header is left to the
next patch.

The STM32MP25 VENC uses the same code, so it gets this change too. I
cannot test it there, and its interrupt handler does not get the stop
of the previous patch. rockchip_vpu2_jpeg_enc_set_buffers() writes
VEPU_REG_STR_BUF_LIMIT in bytes the same way, and
rockchip_vpu2_jpeg_enc_done() divides the read-back by 8 as well; I
cannot test the VEPU2 either, so this patch leaves it alone.

Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board (VEPU1); the assistant also drafted the code and
this message. Tested on that board, with CAPTURE buffers imported
through DMABUF from a larger buffer filled with a pattern: without this
change the encoder wrote the rest of the stream past the end of the
plane in each of 16 overflowing frames (640x480 to 1920x1088, quality
100, 12 of them in default-sized planes). With this and the previous
patch, 14 overflowing frames (640x480 and 1920x1088, four of them queued
back to back) stopped exactly at the limit with BUFFER_FULL in the
status, nothing past the plane changed, and frames that fit are byte for
byte the same as before. With the limit in words but not rounded down to
a burst, the encoder wrote up to 56 bytes past it. Not tested on other
SoCs.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c b/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
index 86cc1a07026f..1e548e91612b 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
+++ b/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
@@ -55,7 +55,15 @@ static void hantro_h1_jpeg_enc_set_buffers(struct hantro_dev *vpu,
 	vepu_write_relaxed(vpu, vb2_dma_contig_plane_dma_addr(dst_buf, 0) +
 				ctx->vpu_dst_fmt->header_size,
 			   H1_REG_ADDR_OUTPUT_STREAM);
-	vepu_write_relaxed(vpu, size_left, H1_REG_STR_BUF_LIMIT);
+	/*
+	 * The stream buffer limit is counted in 64-bit words, not in bytes
+	 * (the register reads back the stream size in bits once the frame is
+	 * done). On the RK3026 the encoder writes the stream in 64-byte
+	 * bursts and finishes a burst it has started, so give it whole
+	 * bursts only.
+	 */
+	vepu_write_relaxed(vpu, round_down(size_left, 64) / 8,
+			   H1_REG_STR_BUF_LIMIT);
 
 	if (pix_fmt->num_planes == 1) {
 		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);

-- 
2.53.0


