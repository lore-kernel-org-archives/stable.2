Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473698;
	b=Sj91PLLDz82BccvzfmCQOdBtS2e/fSB0qBMU43jrq1kWi1tv80uNUavsdR9shufEMeAK
	 Tws7JeILdwplZT0zFfhuFCKw4uKsjgg1TZpQw8s6gVwWQllIHL186rRjGGuPCb+Cw3Fdv
	 e8I3QzLskBsvfQYJBIUhSYuJoHvkzRUeWo6hzpXH4SPu2xSOEAz5eCRXNiMHLkxS8AGid
	 /4OOm9i16oGxQHP+hYG/TuZy7mhukGilTv0w+uhPXVcyoxLI7l2f6JPpxK7gXP+Fz8hfI
	 8ja5yXZkDHw72SS8GNk0+BGRNCcasfASdzigUJoFkWOcAZeIC9hdHWn6oSMYIiQW7lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473698;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4i3GS29HPtypyjBy6AOepteHi17VRcJiMUzTuDJd0IQ=;
	b=4P/jy+WsEW1yM+0Ire7VmRijVR/eW3358rUpYndt9IPji9sSBVyGFvpGux7OOacfpJJc
	 lxWLW30eZwD7A2d40cHFJFULKrZ8lI2H8Vj3lOYTSdkR4znIzdVorhL/CoGXOtlvkKW9w
	 j/D6HQMh2mBS9JtJfWT8eD3LZQ1BDnJh2Z5rvzjI+bGkj0Rt+OFpsBdy4aK2IglTNPkod
	 ueI29i5aQ7zUqvkdQ4xMldHWrCrcYSA7C9MylGxKQQqQXgRYtBFCmN5/sTxTlLp3xZJbH
	 MVj5OukrF9FnBv+1V9VmtyfdQYPbzcXaz6ouCPd4kcSN8hx5NZ6P6vAgY4eY+oDLgyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CysUp71n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68735606A88E;
	Thu, 12 Nov 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CysUp71n
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794473698;
	b=V7eCl9BpGOaVSsEELOA3D23mt1ALcuYSVOAXlwaBu4kBtYg+Zd20xwbpoEEDH5ARMkZX
	 HRoiWc9Vg5ZGZmDPWugqLu8AYznv9xldNj4qEjLcInf9e/0w+JH+2l9nB2GxzpRHgYA0F
	 NeM7rrrJlzgiuXM8aMk5rULnxJgDpU1fxeiI2V45vyFuqfgB4Io73KXhPjGby7+oQXzYq
	 p3b5SjowvXyUDWsVlNkx8pBQsOe3fDHsUVXTDDNm7WI0aAEPXLzcay1TXsBtmbBd7MkwM
	 9Gzx1DIpkdZjCCprh7SEGJF4n8B1vyUqJQaChzmPoNctsZhS9lo2FgMT/2ApMOevnfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794473698;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4i3GS29HPtypyjBy6AOepteHi17VRcJiMUzTuDJd0IQ=;
	b=ceM+G+QRsBGpV0cLSoXRpNS/Kx2/WY3tf6+Exf7Ek7s3ZC526Qf7wWgOObuwi6Wwjk6i
	 XBnrrLtvxllH0dQf5+8uzef+dp4oGXcH8vKZhcHo25VwpHoNixktUfNZQb3HW1NsN/hK9
	 okLHy5wlgFEvSbc4k2y29nFD1V2FNZyBZmLFhzuRmb5kKJBR1xhxVxIPDlGyVjCPZWIF4
	 oqFxJpjmVq52BIEhxRYgQVsyoLndK0kPlM5vWbGaExF+P9ntb6AM3iw8I46vObMgIGt29
	 o2pfQHsg3zDB2Z8eOlu/mpbfQM2hDgLz+mfFXdzkF4PQGA4hQtokFaX3A2CKHpeULvg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 96A931F00A0C;
	Thu, 12 Nov 2026 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473698;
	bh=4i3GS29HPtypyjBy6AOepteHi17VRcJiMUzTuDJd0IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CysUp71nZSVVPeXoDqR0iybVvwQ4zgRYGFnjFd+s0ufVHEhCdBZ/CMznMBiQ7eebm
	 MWJbrIcp4IDF/qY46N8qBvgNhv2Cey0G+3XLNhhWhOgrnqZu7pcUVlhFi2EAuV//ws
	 8M4Lt60hIBF7aigN50U7BogwwKj10z3K7GmMyXMI+02/9Gzf0SY34xkY7C9eU8mZu0
	 68BimmL3YRWn8SRUSu2kLEbUYHeI5Hy+1BI81EBDA6zdO9bklNRrT8q2SpTJ+4KlQW
	 cI04DUfl/poXfj9HAEKOaBiYh0ktY6c2XDmnUcLQoxQIsf/eiyLk3amV70iZb22Xg5
	 DDOTFOaUbNSZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 26EB049413;
	Thu, 12 Nov 2026 08:54:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:54:58 +0000
Subject: [PATCH v2 4/6] media: verisilicon: Check every VPU981 AV1 tile
 column buffer before reusing them
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
Message-Id: <20261112-hantro-codec-fixes-v2-4-f44424df585b@gmail.com>
References: <20261112-hantro-codec-fixes-v2-0-f44424df585b@gmail.com>
In-Reply-To: <20261112-hantro-codec-fixes-v2-0-f44424df585b@gmail.com>
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
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473695; l=6292;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=BT2F0TOczjHLd2TsiRpWYPl5wVI3/1gtJ6eyqTMB414=;
 b=5qAFPZ2X7x/mB4guhj/l6YFbtBJPsa29419lVc0kEuJGe/lecc39ZEHCozNBUXAl4Jl+HfG1K
 bXUwkGJjYUxChMrY+tO3fYSj9CFPo1M/SlTsyFUszqNQ/4Gbz/ZVWBb
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


