Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794295110;
	b=EWFNz1tJvflFqZrO8wPs0b3+wYrvXIDaTxHQOMQRcbf5ftsK/nYWhJ6/K1iUGKb8yyRj
	 Px7w8A2o0tjOlQXMavZe5fkF54Z9Q+1ubKBQs0GCDA6juEN1JWDuhTuBY4SY63IBhAzwL
	 2gXfH1tKhZyjgQ6lIOcE5UTIV/gZSAkVYjlAZelMg5CgBRQ6tzFeuzCunivbdV+bVuFjb
	 42N/HD4bCjFQm75frClNY5i5mdtQ/qUJSYQPU6ENzQ2+Oa0IufO0iyeq8AVIOCVjrWFyp
	 emmWNkQtHqATQ1QpwFPFpd5fTAQWaQ/PpdI5RY/f94IF+eOHbB4bZbRL9wk1PngcDqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295110;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4i3GS29HPtypyjBy6AOepteHi17VRcJiMUzTuDJd0IQ=;
	b=XaJh1hNo8qWzQq5JmZsTtWeHZxmOslaV7Cg3+V9LI7DL5pEFUJmQW3ClAPNB82dWwvsc
	 PufKdkRh7VFI+wcyAhNEf6Gk6EBJDUtK8B/sbaMIxhXLS7zWkJgMPT1JHszpmaP9uNth4
	 rrMR9w36raD3J0yDXqXsBNnb9KtOOFXY7zOJRUjtO9vgEaBtp3oYrjsmWiFN8IToFwx6I
	 pXKu1aaEx/65xJkSO6j6OX9/IXfMHJTh8jKCq8X8WNiRDJt3slgXNNx5u+bIMuj090lV0
	 +BAzC1HYb6IQ9kob+ZYyY9ucv/XUudJl7igNt38cm2fLXcNk3tyQhU77o5rp6Q+jdyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LA8/siGC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B7606A321;
	Tue, 10 Nov 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LA8/siGC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794295109;
	b=qu2bPGSLmxZWsXBV7I9o4N9/0dAMoyNSZ5kzOjyCJCLTchTwsnBnOPIHnLvZezmsCODY
	 uDm1Ccva4UyhA38kEKAPLpu1eChrqVt9qMw2E0DdiRVTy1LmqrEMfydf3ps6cmbo/pu8R
	 /17X/93BrKWEcDgSD1v7oKG5/tl9MfMIWlzZDh3zqqdSDiHVInd9fpdUjdmRIpjxxzQqW
	 wLK8C0l5lWKWKlQr2FI7Uye07agI10X64mmpGxki4qiSP+MueeEDPcjK9Gw1lh7/qMz7m
	 7cnkeZLs4IuZIJCC2NL0qqfbaMyyQgysTMSilf2hgSoCwfJaogZL20s0+qIDQxT6nKA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794295109;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4i3GS29HPtypyjBy6AOepteHi17VRcJiMUzTuDJd0IQ=;
	b=ECHMPmeWkKYp8FSLoCJiy8626fuhsYZ8sN81QUaFh7Uq2sj3C7YbaHtC9r7NWzC5Jsa3
	 xEXwEI3VjJflxuUcN6/kvFnQx2ScHOFPdgUXkIik3GQp35gcWhQwP00p2T0pDjCiXyUkB
	 lCdWBlbgGobPFHVEAtT8WCxkH9ZGBK61ZOdhSWfi0PshOakdx7JM/iHdd8LmIl8RgLg+G
	 M4qjJv0Y6QvI7aqehYH4DbD4w95AuPep7q0Z96LasLJcGzSoMHgtGNteP0WC99X9kxvQB
	 KG0xL+XaZJ5GmsPnV6fFsezGibwYRfIkiCq7r4OGYRjKXbGTRHqL1rnzdiQ95eipjdw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 61B691F008A5;
	Tue, 10 Nov 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295109;
	bh=4i3GS29HPtypyjBy6AOepteHi17VRcJiMUzTuDJd0IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LA8/siGCkk0jouAlHZYNSei6UKYmryOL1U2P2t9ie8tiq09B7opIZ5/gBEVlVxkXZ
	 vJGG8ZLNOQMq/aPnhHSdho9aaVVAbbBkPwm3iiDbrBdgrO5I7sZnfzVKcO2mbbmlco
	 R37mSTJIEaoURP9YRFcDe68kRMuBcBlhutOvVdTUQTPMzhJ9pz+zRZwEWlLt/djyyF
	 w2Oim4WZLwc9BBiDq7aEg35gaBiMTD1unMtir3gJWVyRi2jCu/Kqz1d9q3URspa1ih
	 orFpqXFa02HFnkqfCq8RTgawqIvLvqrXoXBpszQtmyMuLYQYwogRddrcMoK//uQQSv
	 jsoYl1pnFPikA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E7B14489A9;
	Tue, 10 Nov 2026 07:18:27 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:18:30 +0000
Subject: [PATCH 4/4] media: verisilicon: Check every VPU981 AV1 tile column
 buffer before reusing them
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
Message-Id: <20261110-hantro-codec-fixes-v1-4-0fd5372ce831@gmail.com>
References: <20261110-hantro-codec-fixes-v1-0-0fd5372ce831@gmail.com>
In-Reply-To: <20261110-hantro-codec-fixes-v1-0-0fd5372ce831@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Fricke <sebastian.fricke@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Tomasz Figa <tfiga@chromium.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295107; l=6292;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=BT2F0TOczjHLd2TsiRpWYPl5wVI3/1gtJ6eyqTMB414=;
 b=v4IAwZbaCF/kbVOqenuZfLekQ3xkKDPJl21NkrEYoTBY+s050lQ+/1k7ECSi1FPQJflLnwfi5
 lATQjf4DhExBxFOTMfwV/VVDzS7cIbI0g9g7iZUsEhVIyWS0POeu8VR
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

rockchip_vpu981_av1_dec_tiles_reallocate() keeps the five tile column
buffers (deblocking data and control, CDEF, super-res, loop restoration)
when the deblocking data buffer is big enough for the current frame. The
buffers don't scale the same way: the deblocking data one grows with the
frame height and the bit depth, the super-res one only with the number of
64 pixel rows, and the loop restoration one with the number of
restoration stripes, which is one more than the number of superblock
rows. A frame can therefore fit in the old deblocking data buffer and
still need a larger buffer of another kind. For example, after a 10-bit
1088 line frame with 4 tile columns, an 8-bit frame of the same height
with 5 tile columns needs 65280 bytes of deblocking data (65536
allocated) but 367360 bytes of super-res column data (293888 allocated);
an 8-bit 128 line frame with 4 columns followed by a 64 line frame with 8
columns has the same problem with the loop restoration buffer. The
decoder then writes past the end of the smaller buffer.

The sizes are also not reset when the buffers are freed, so after a
failed allocation the stale size of the deblocking data buffer lets the
next frame skip the allocation and run with NULL buffers.

Compare each buffer with the size the current frame needs and clear the
sizes together with the buffers.

Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 34 +++++++++++++++++-----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index 2a145433e6d1..e817c91224d3 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -236,27 +236,32 @@ static void rockchip_vpu981_av1_dec_tiles_free(struct hantro_ctx *ctx)
 				  av1_dec->db_data_col.cpu,
 				  av1_dec->db_data_col.dma);
 	av1_dec->db_data_col.cpu = NULL;
+	av1_dec->db_data_col.size = 0;
 
 	if (av1_dec->db_ctrl_col.cpu)
 		dma_free_coherent(vpu->dev, av1_dec->db_ctrl_col.size,
 				  av1_dec->db_ctrl_col.cpu,
 				  av1_dec->db_ctrl_col.dma);
 	av1_dec->db_ctrl_col.cpu = NULL;
+	av1_dec->db_ctrl_col.size = 0;
 
 	if (av1_dec->cdef_col.cpu)
 		dma_free_coherent(vpu->dev, av1_dec->cdef_col.size,
 				  av1_dec->cdef_col.cpu, av1_dec->cdef_col.dma);
 	av1_dec->cdef_col.cpu = NULL;
+	av1_dec->cdef_col.size = 0;
 
 	if (av1_dec->sr_col.cpu)
 		dma_free_coherent(vpu->dev, av1_dec->sr_col.size,
 				  av1_dec->sr_col.cpu, av1_dec->sr_col.dma);
 	av1_dec->sr_col.cpu = NULL;
+	av1_dec->sr_col.size = 0;
 
 	if (av1_dec->lr_col.cpu)
 		dma_free_coherent(vpu->dev, av1_dec->lr_col.size,
 				  av1_dec->lr_col.cpu, av1_dec->lr_col.dma);
 	av1_dec->lr_col.cpu = NULL;
+	av1_dec->lr_col.size = 0;
 }
 
 static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
@@ -269,15 +274,30 @@ static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
 	unsigned int height = ALIGN(ctrls->frame->frame_height_minus_1 + 1, 64);
 	unsigned int height_in_sb = height / 64;
 	unsigned int stripe_num = ((height + 8) + 63) / 64;
+	size_t db_data_size, db_ctrl_size, cdef_size, sr_size, lr_size;
 	size_t size;
 
-	if (av1_dec->db_data_col.size >=
-	    ALIGN(height * 12 * ctx->bit_depth / 8, 128) * num_tile_cols)
+	db_data_size = ALIGN(height * 12 * ctx->bit_depth / 8, 128) * num_tile_cols;
+	db_ctrl_size = ALIGN(height * 2 * 16 / 4, 128) * num_tile_cols;
+	cdef_size = ALIGN(height_in_sb * 44 * ctx->bit_depth * 16 / 8, 128) * num_tile_cols;
+	sr_size = ALIGN(height_in_sb * (3040 + 1280), 128) * num_tile_cols;
+	lr_size = ALIGN(stripe_num * 1536 * ctx->bit_depth / 8, 128) * num_tile_cols;
+
+	/*
+	 * The five buffers scale differently with the frame height, the
+	 * number of tile columns and the bit depth, so each of them has to be
+	 * big enough for the current frame, not only the deblocking data one.
+	 */
+	if (av1_dec->db_data_col.size >= db_data_size &&
+	    av1_dec->db_ctrl_col.size >= db_ctrl_size &&
+	    av1_dec->cdef_col.size >= cdef_size &&
+	    av1_dec->sr_col.size >= sr_size &&
+	    av1_dec->lr_col.size >= lr_size)
 		return 0;
 
 	rockchip_vpu981_av1_dec_tiles_free(ctx);
 
-	size = ALIGN(height * 12 * ctx->bit_depth / 8, 128) * num_tile_cols;
+	size = db_data_size;
 	av1_dec->db_data_col.cpu = dma_alloc_coherent(vpu->dev, size,
 						      &av1_dec->db_data_col.dma,
 						      GFP_KERNEL);
@@ -285,7 +305,7 @@ static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
 		goto buffer_allocation_error;
 	av1_dec->db_data_col.size = size;
 
-	size = ALIGN(height * 2 * 16 / 4, 128) * num_tile_cols;
+	size = db_ctrl_size;
 	av1_dec->db_ctrl_col.cpu = dma_alloc_coherent(vpu->dev, size,
 						      &av1_dec->db_ctrl_col.dma,
 						      GFP_KERNEL);
@@ -293,7 +313,7 @@ static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
 		goto buffer_allocation_error;
 	av1_dec->db_ctrl_col.size = size;
 
-	size = ALIGN(height_in_sb * 44 * ctx->bit_depth * 16 / 8, 128) * num_tile_cols;
+	size = cdef_size;
 	av1_dec->cdef_col.cpu = dma_alloc_coherent(vpu->dev, size,
 						   &av1_dec->cdef_col.dma,
 						   GFP_KERNEL);
@@ -301,7 +321,7 @@ static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
 		goto buffer_allocation_error;
 	av1_dec->cdef_col.size = size;
 
-	size = ALIGN(height_in_sb * (3040 + 1280), 128) * num_tile_cols;
+	size = sr_size;
 	av1_dec->sr_col.cpu = dma_alloc_coherent(vpu->dev, size,
 						 &av1_dec->sr_col.dma,
 						 GFP_KERNEL);
@@ -309,7 +329,7 @@ static int rockchip_vpu981_av1_dec_tiles_reallocate(struct hantro_ctx *ctx)
 		goto buffer_allocation_error;
 	av1_dec->sr_col.size = size;
 
-	size = ALIGN(stripe_num * 1536 * ctx->bit_depth / 8, 128) * num_tile_cols;
+	size = lr_size;
 	av1_dec->lr_col.cpu = dma_alloc_coherent(vpu->dev, size,
 						 &av1_dec->lr_col.dma,
 						 GFP_KERNEL);

-- 
2.55.0


