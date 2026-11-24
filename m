Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795527633;
	b=NWNq4lNSuJnwplVNIwLlW+ke9EgjRxbplEy4V/iOBhNrnSTRYE1hli0zalfQG3W+oHbc
	 7uJ15G5lcnZxNNt7kWveIpoko8ad3ONmKFlwSsT5RmeCfxSSe1uT0bx5PXeqGgJZ9PEyh
	 6on5jLabfBVGJsMUya/oDMxl1tnFyJ1ivLVLHBhNSNDqauie9lduGe79I4xDHVl0rfH4X
	 YFj1HMWqztPUsQnyNBCLCZeL5Xpz+EUaV3XGLyetcm/+7NaszfdifDxzqG2tQVqFpDGv4
	 PkH1rbHNX4rneJIq2NevITeGD6pn9gauJPcgwm0PUYVFTSi2fKs8txb2qI8VwQ3CVPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527633;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nzFWxb9EM1aBm69mxNmKrGLCe/kN+fOhobHOhwqxJug=;
	b=gGvB+Zj/E36KNPdm9kImJOKDWhRS5tacY1tPOZerGMVl1PWrhmYw11nfAXixn4P09PtA
	 2qRVmaWK16GBXA6gAe+2gX+uzUJgTOv8bayh3xgUswWEzkQi8dVrqraEf8/lC3MJbicj0
	 l+69WpclQ6JWw71mH9vD9YsRFaAyp5eAHlACyE7/g7aGEi9zJ5plZ1MScyPaTSOuO5qKJ
	 ZUfMHzDVnyHDIWBuicTrjBp/DVbbxGlMytaEQbIDECQFKJjeo03LkmvX1QVpBHJnZPn+x
	 YWtXAaSRhD3y8jRrP/3xv+Q7DiQ7TkKqHWYRDyl+lXVkx1a7kMcTlYmTiwHz46VJrMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQzbiJRR;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD0606A330;
	Tue, 24 Nov 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQzbiJRR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795527633;
	b=zgEo+fL0Q3aqdVW68IzFQB73cC2DNjQxkFKIMQ69SYuyaqn5K+/jjdPElZJb0csjahqO
	 HqQJyGHtGwnh/XHj7ukGgvJHozbH6zB1XjfGTIzJ8JFlwrRHPy9ZqOpQFJzjYo7SgT+Fm
	 Ju/2OL7vQ3BcRTEK+j1Wi/Lsst2c5EeyCP6GY08IIMSIT/cng5Fgilrzn70mhqWPn2eWS
	 DeSwzFs7Vs/MkCLP/rEU9MzHmBZJGeFjCRX4DbIK4kf9DviuQpd51ObmFkB2El1K7hJGr
	 BSd/B5Wktz+URN3qewDy7qB32p6U99cqufGCT49gVk1vvZPWdi3OAXupYMepRB+2Jaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795527633;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nzFWxb9EM1aBm69mxNmKrGLCe/kN+fOhobHOhwqxJug=;
	b=Zjw5sovYicyrdntzPYqbFUmYF0OFGxFDnJ3/PTwHGRezk/PAttwjEvSHe4S/QE0yihKM
	 cxEw0wAQK98taYEOduaz0Rk2BWitOoBmXp2Z65le3F9VSN9jJPxtvhY3MDK7fxRK8GFOW
	 mUdKlhDFphqX44xTn/g8TJPaV/EDMHvlndxVjWR/VAkhWXlskK1lVoK2zGRinv6DCEQjs
	 bGo+aDnZa7UQqxt4Vz7WA3LrouIulIq7tD6cUfNs53pSir0DBbE8hmuS7ibQVAa9OgZEV
	 nB02xIllkm0D+arHi7i/hjeQxQoQcbPMgKebYcglv3eiznd69OY9NnSpiVwC1rbmygQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E5AEC1F000D0;
	Tue, 24 Nov 2026 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527633;
	bh=nzFWxb9EM1aBm69mxNmKrGLCe/kN+fOhobHOhwqxJug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IQzbiJRRK7qyKdQ3oGuG0+e4Alpy1TEE4X6RCtRz7vDH4DiwQKuVT1Iim4Ta248hf
	 YTvhmXgLV5xKmmMVOg226oUt1My5sOCJJHNuzWlsI4NzOdfnvaox8ayugnT9/sE0Zz
	 rFo7+CZA4UEP6VKM7e+U3XOhjpflhR9xblwQVphfIXhT9j1EcAGFLpT9ribIr0V3/1
	 L5HConGX7zMwQmiw8k25BgceuuR9K1GN/Azi4lWAEkMO87ZUJjNB2tBZxmRDPo6E2C
	 vgRQubzNCner6CFpxK0rOcgIyM4G5xEzlTHA/LrzT5q/5CHLIjPMOOe8ODIxdMnD0f
	 6U/GJlg5xNWdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 77BB84CA5F;
	Tue, 24 Nov 2026 13:40:21 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 16:40:18 +0300
Subject: [PATCH v3 2/3] media: verisilicon: program the JPEG encoder stream
 limit in 64-bit words
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
Message-Id: <20261124-hantro-buflimit-v3-2-780903970ca0@gmail.com>
References: <20261124-hantro-buflimit-v3-0-780903970ca0@gmail.com>
In-Reply-To: <20261124-hantro-buflimit-v3-0-780903970ca0@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795527620; l=3597;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=biQGrB6UYPvhg65jUpDgSfn1YhBxiYA0k15PHlCqCLk=;
 b=P5pNeXlKk5cfoFc6oXQ0j5mBRlqXJJwCmuZ2j/huGy6S5VX16cLw9qmvdyeaWZf4mr/NJV6lN
 V8/NCe6s+/ICjb9cvrhYg3ULwwHNjWcpWWCHX+0sSk4Vq+DaDS7Cm4L
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

H1_REG_STR_BUF_LIMIT counts 64-bit words, but the driver writes the room
left in the CAPTURE plane in bytes. A stream that does not fit, such as
a quality 100 frame of noise in a default-sized buffer, is then written
past the end of the plane, up to eight times its size.

Write the limit in 64-bit words, rounded down to whole 64-byte bursts:
the encoder finishes a burst it has started, so an unrounded limit lets
it write up to 56 bytes past it. rockchip_vpu2_jpeg_enc_set_buffers()
has the same bug with VEPU_REG_STR_BUF_LIMIT, which
rockchip_vpu2_jpeg_enc_done() reads back as a bit count; give the VEPU2
the same limit.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board; the assistant also drafted this change. Tested
on that board (its H1 is Rockchip's VEPU1): overflowing frames now
stop at the programmed limit without writing past the plane (a canary
after the plane stays intact), and frames that fit are byte for byte
the same as before. Not tested on other SoCs, including the STM32MP25,
which shares the H1 code. The VEPU2 change is not tested: there is no
VEPU2 on the RK3026.

Rockchip's MPP programs VEPU_REG_STR_BUF_LIMIT the same way ("limit >>=
3; limit &= ~7" in hal_h264e_vepu2_v2.c). Patch 1 stops the encoder
only in the VEPU1 interrupt handler; the VEPU2 and STM32MP25 handlers do
not: if those encoders pause on a full buffer as the RK3026 H1 does, the
next job may time out.
---
 drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c        | 4 +++-
 drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c b/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
index 86cc1a07026f..cbf0e3d034f6 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
+++ b/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
@@ -55,7 +55,9 @@ static void hantro_h1_jpeg_enc_set_buffers(struct hantro_dev *vpu,
 	vepu_write_relaxed(vpu, vb2_dma_contig_plane_dma_addr(dst_buf, 0) +
 				ctx->vpu_dst_fmt->header_size,
 			   H1_REG_ADDR_OUTPUT_STREAM);
-	vepu_write_relaxed(vpu, size_left, H1_REG_STR_BUF_LIMIT);
+	/* In 64-bit words; the encoder finishes a started 64-byte burst. */
+	vepu_write_relaxed(vpu, round_down(size_left, 64) / 8,
+			   H1_REG_STR_BUF_LIMIT);
 
 	if (pix_fmt->num_planes == 1) {
 		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
index 61621b1be8a2..ab976c762239 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
@@ -82,7 +82,9 @@ static void rockchip_vpu2_jpeg_enc_set_buffers(struct hantro_dev *vpu,
 	vepu_write_relaxed(vpu, vb2_dma_contig_plane_dma_addr(dst_buf, 0) +
 				ctx->vpu_dst_fmt->header_size,
 			   VEPU_REG_ADDR_OUTPUT_STREAM);
-	vepu_write_relaxed(vpu, size_left, VEPU_REG_STR_BUF_LIMIT);
+	/* In 64-bit words, in whole 64-byte bursts as on the H1. */
+	vepu_write_relaxed(vpu, round_down(size_left, 64) / 8,
+			   VEPU_REG_STR_BUF_LIMIT);
 
 	if (pix_fmt->num_planes == 1) {
 		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);

-- 
2.53.0


