Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795063209;
	b=SJLGMCQWq6AkD1zRRABiZ6TKybqMbROcM/LcTPY/rlJGMgsNi+SbVkB0LL41R/h+L8hs
	 KQx/SebwIh78cgKs+B3cqTg2rNsbB4ZV4Oo5a6OeOV0TpbzhiX+nPChHHGq8mr7I5pfhI
	 1UTHPb+NW/FSLfkCxnIu+t90b+2qrlrZNahah2UUky5EUoh3dWIRO89JT+Qc+V2/2KNMe
	 v+xwRAM8g0vPlGOxInCUFQnY5y6zhIFreId4cMwBSNasC13r9yXpTWR64bZ4iPPkW1iKv
	 iVkunpYLwGazs2e40DvEAWTDBfzTeSUrSFlBLvcB+9UszS9dQe6+lT5r/jKtDK2MT1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795063209;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JgaK9RykTE3Nx1Cad/MiTnEkZj3GuQkh9r/+HIVZ4Uc=;
	b=gq0SM2x6JlPnXe5X4PGMd/Zgpmrj78IWfnM89Lt6PcTsrIeiMmgMW5mAuehzs6zapmIG
	 2JX/OCxdRWHvXM92GKSjRKAVSUoKOuXBOWCoPAb6geimq5t0sSB90cd5Zi2KvKM6XKgjk
	 z4E5UH3Kd83jDLAO9xhwOArbh/2D9JlMCEDKYyJ6s2V2sKyUYG8uT3/THURwr6nFEB8G+
	 9/xQ5gxSEcK1RBXd4QC9mxHmqZa7YeSDuCqd1rpOBs/maZu1PJ2D4ZxxaLdRgcXk1eJ0J
	 qq5+9/pse/SWfIeEgyEG+OZZTJ7VVR/DgWWjdUlpxXEnyA4r6XLg17Q+se58ZSIXxDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dN7NNFBr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E9606A325;
	Thu, 19 Nov 2026 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dN7NNFBr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795063208;
	b=hRqmicOnbGuRd9YQ8On8+zfm7dxolR8kQk+yHx9ZbzKjRKrrJsHrtsik4dFL0317Aqmc
	 +CieLZBIpIETDn6wIzkFpXqkZFk7fmV2Vx0HQlhI1ZRW9sUBRSVnnYL7nIvir/f2u1kZe
	 KvJD2TxTZLLKV24TK3a03GWzC9zzie92CMud0LqTnUzMvyVpR14mxJlBhOhEkLH4Zk1n3
	 k9G9r4SALc1Lb21bqJBmx6VKhH16hsUGcV/PDQS/loeBfWrugVT6E2tnCVbheN4Dwxtc8
	 QR6I1p2b1qMUbO6DvfM9m/Ug8tOUZ4tr51QScxkgbimrqbgTuRZSZEMl49OcGLFPVmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795063208;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JgaK9RykTE3Nx1Cad/MiTnEkZj3GuQkh9r/+HIVZ4Uc=;
	b=yubZd6oZzItpDqpRghebNFYsxxZ/PO1MKsKg1PxFah8Oy2sxhXoUOT6dYDhmT/3mHLbK
	 h2Bkx3GOMxfjzn3XVPTRzyixh9vZxmPiC+mbUHq0iVCHDVPi5VWEa0YBmM3cmE5EzS4nd
	 JI6nFkYtkjqqYCOUq55ubG902hPKKkp+t7gb7i2ZPyfsnY+/LElOBsVJnTRF5zE72gfjI
	 2lC5GtuU0kqHVSfG/wVybglNkLs4O1zOKs0XL37JbFkVzyRZ9q2yKm6EHMX/CyX6quto2
	 kYBa/a6fs8kS2ZfKof/GxYE/Biuc2C/sXJX96M9MjOaI0M0lCRrOWwD/AZCx7hsbIXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BB3481F000C5;
	Thu, 19 Nov 2026 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795063208;
	bh=JgaK9RykTE3Nx1Cad/MiTnEkZj3GuQkh9r/+HIVZ4Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dN7NNFBrek3WitUiQYjQ6WXO1fxeWCQ6GljNhQYfvJtOHKUByq4WGshqOEitdLUD6
	 OCZx98NpwEYAODug1QQNLIMTxNdWBk19eQsEp2/DrzpdVoVuyL4g1jtDw1VtfQkcpx
	 XeWkoiXthONGur+Cuepze0n0Vn/qVNeIIFhUW+B8IkuN0YlGA+phAba81Oa91G5q59
	 AMfRMY0zU1BUtdHdBr3QDKpQIL32q68WokFKNlIE3sOOokTVqYwR7tfMOVyR4NvCuX
	 Ed8utA2LltNGgMVhlK8654+N8mvudRGWQIEIZOdfK0YcNuVI4GezjNwc9InzdKdouG
	 l+hNDALES0M/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4887A4B0E4;
	Thu, 19 Nov 2026 04:40:07 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 04:40:07 +0000
Subject: [PATCH v2 1/2] media: verisilicon: av1: Find the reference buffers
 by timestamp
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
Message-Id: <20261119-b4-vpu981-av1-refs-v2-1-7c270158b20e@gmail.com>
References: <20261119-b4-vpu981-av1-refs-v2-0-7c270158b20e@gmail.com>
In-Reply-To: <20261119-b4-vpu981-av1-refs-v2-0-7c270158b20e@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795063206; l=9612;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=KTseDFHZfflH4HHcBG3Etn8Wr6M60T+VZLsglOe5pjc=;
 b=Ty2fRmhUUe/rrSujhtcELhtn+RCfxwaO13USn31sWjRTI94EDMKrWsDGGgnf0Ow7izHnIrLrS
 pNbzG2W0nKiCB9aesac6iTYUx844ma1SHzNDheOWPy0Si3yK3NDMbUL
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

frame_refs[] keeps a CAPTURE buffer pointer per reference across jobs.
VIDIOC_REMOVE_BUFS can free that buffer, and a missing reference falls
back to slot 0, which can hold a stale pointer.

Look the buffer up by timestamp at each job, as the other Hantro codecs
do. If it is gone or holds a frame of another size, use the current
CAPTURE buffer and frame size, and set that buffer up first.

Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro.h        |  2 +
 drivers/media/platform/verisilicon/hantro_hw.h     |  3 -
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 73 ++++++++++++++--------
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 0353de154a1e..4959872aced7 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -342,6 +342,8 @@ struct hantro_av1_decoded_buffer_info {
 	/* Info needed when the decoded frame serves as a reference frame. */
 	size_t chroma_offset;
 	size_t mv_offset;
+	int width;
+	int height;
 };
 
 struct hantro_decoded_buffer {
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 13e573f1f19d..51e947848b61 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -287,7 +287,6 @@ struct hantro_av1_frame_ref {
 	bool used;
 	u32 order_hint;
 	u32 order_hints[V4L2_AV1_TOTAL_REFS_PER_FRAME];
-	struct vb2_v4l2_buffer *vb2_ref;
 };
 
 /**
@@ -314,7 +313,6 @@ struct hantro_av1_frame_ref {
  * @default_cdfs_ndvc:	default mv probabilties structure
  * @cdfs_last:		stored probabilities structures
  * @cdfs_last_ndvc:	stored mv probabilities structures
- * @current_frame_index: index of the current in frame_refs array
  */
 struct hantro_av1_dec_hw_ctx {
 	struct hantro_aux_buf db_data_col;
@@ -339,7 +337,6 @@ struct hantro_av1_dec_hw_ctx {
 	struct mvcdfs  default_cdfs_ndvc;
 	struct av1cdfs cdfs_last[NUM_REF_FRAMES];
 	struct mvcdfs  cdfs_last_ndvc[NUM_REF_FRAMES];
-	int current_frame_index;
 };
 /**
  * struct hantro_postproc_ctx
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index 2a145433e6d1..b331ff234878 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -169,12 +169,10 @@ static int rockchip_vpu981_av1_dec_frame_ref(struct hantro_ctx *ctx,
 		av1_dec->frame_refs[i].timestamp = timestamp;
 		av1_dec->frame_refs[i].frame_type = frame->frame_type;
 		av1_dec->frame_refs[i].order_hint = frame->order_hint;
-		av1_dec->frame_refs[i].vb2_ref = hantro_get_dst_buf(ctx);
 
 		for (j = 0; j < V4L2_AV1_TOTAL_REFS_PER_FRAME; j++)
 			av1_dec->frame_refs[i].order_hints[j] = frame->order_hints[j];
 		av1_dec->frame_refs[i].used = true;
-		av1_dec->current_frame_index = i;
 
 		return i;
 	}
@@ -182,6 +180,30 @@ static int rockchip_vpu981_av1_dec_frame_ref(struct hantro_ctx *ctx,
 	return AV1_INVALID_IDX;
 }
 
+/* NULL if the CAPTURE buffer of frame_refs[idx] is gone or holds another frame */
+static struct hantro_decoded_buffer *
+rockchip_vpu981_av1_dec_ref_buf(struct hantro_ctx *ctx, int idx)
+{
+	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
+	struct vb2_queue *q = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
+	struct hantro_decoded_buffer *buf;
+	struct vb2_buffer *vb;
+
+	if (idx < 0)
+		return NULL;
+
+	vb = vb2_find_buffer(q, av1_dec->frame_refs[idx].timestamp);
+	if (!vb)
+		return NULL;
+
+	buf = vb2_to_hantro_decoded_buf(vb);
+	if (buf->av1.width != av1_dec->frame_refs[idx].width ||
+	    buf->av1.height != av1_dec->frame_refs[idx].height)
+		return NULL;
+
+	return buf;
+}
+
 static void rockchip_vpu981_av1_dec_frame_unref(struct hantro_ctx *ctx, int idx)
 {
 	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
@@ -766,14 +788,14 @@ static void rockchip_vpu981_av1_dec_set_frame_sign_bias(struct hantro_ctx *ctx)
 }
 
 static bool
-rockchip_vpu981_av1_dec_set_ref(struct hantro_ctx *ctx, int ref, int idx,
+rockchip_vpu981_av1_dec_set_ref(struct hantro_ctx *ctx, int ref,
+				struct hantro_decoded_buffer *dst,
 				int width, int height)
 {
 	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
 	struct hantro_av1_dec_ctrls *ctrls = &av1_dec->ctrls;
 	const struct v4l2_ctrl_av1_frame *frame = ctrls->frame;
 	struct hantro_dev *vpu = ctx->dev;
-	struct hantro_decoded_buffer *dst;
 	dma_addr_t luma_addr, chroma_addr, mv_addr = 0;
 	int cur_width = frame->frame_width_minus_1 + 1;
 	int cur_height = frame->frame_height_minus_1 + 1;
@@ -829,7 +851,6 @@ rockchip_vpu981_av1_dec_set_ref(struct hantro_ctx *ctx, int ref, int idx,
 		pr_warn("AV1 invalid reference frame index\n");
 	}
 
-	dst = vb2_to_hantro_decoded_buf(&av1_dec->frame_refs[idx].vb2_ref->vb2_buf);
 	luma_addr = hantro_get_dec_buf_addr(ctx, &dst->base.vb.vb2_buf);
 	chroma_addr = luma_addr + dst->av1.chroma_offset;
 	mv_addr = luma_addr + dst->av1.mv_offset;
@@ -888,14 +909,13 @@ static void rockchip_vpu981_av1_dec_set_segmentation(struct hantro_ctx *ctx)
 	if (!!(seg->flags & V4L2_AV1_SEGMENTATION_FLAG_ENABLED) &&
 	    frame->primary_ref_frame < V4L2_AV1_REFS_PER_FRAME) {
 		int idx = rockchip_vpu981_get_frame_index(ctx, frame->primary_ref_frame);
+		struct hantro_decoded_buffer *ref = rockchip_vpu981_av1_dec_ref_buf(ctx, idx);
 
-		if (idx >= 0) {
+		if (ref) {
 			dma_addr_t luma_addr, mv_addr = 0;
-			struct hantro_decoded_buffer *seg;
 			size_t mv_offset = rockchip_vpu981_av1_dec_chroma_size(ctx);
 
-			seg = vb2_to_hantro_decoded_buf(&av1_dec->frame_refs[idx].vb2_ref->vb2_buf);
-			luma_addr = hantro_get_dec_buf_addr(ctx, &seg->base.vb.vb2_buf);
+			luma_addr = hantro_get_dec_buf_addr(ctx, &ref->base.vb.vb2_buf);
 			mv_addr = luma_addr + mv_offset;
 
 			hantro_write_addr(vpu, AV1_SEGMENTATION, mv_addr);
@@ -1983,22 +2003,24 @@ static void rockchip_vpu981_av1_dec_set_reference_frames(struct hantro_ctx *ctx)
 
 	for (i = V4L2_AV1_REF_LAST_FRAME; i < V4L2_AV1_TOTAL_REFS_PER_FRAME; i++) {
 		u32 ref = i - 1;
-		int idx = 0;
-		int width, height;
+		struct hantro_decoded_buffer *buf = NULL;
+		int width = frame->frame_width_minus_1 + 1;
+		int height = frame->frame_height_minus_1 + 1;
 
-		if (allow_intrabc) {
-			idx = av1_dec->current_frame_index;
-			width = frame->frame_width_minus_1 + 1;
-			height = frame->frame_height_minus_1 + 1;
+		if (!allow_intrabc) {
+			int idx = rockchip_vpu981_get_frame_index(ctx, ref);
+
+			buf = rockchip_vpu981_av1_dec_ref_buf(ctx, idx);
+		}
+		if (buf) {
+			width = buf->av1.width;
+			height = buf->av1.height;
 		} else {
-			if (rockchip_vpu981_get_frame_index(ctx, ref) > 0)
-				idx = rockchip_vpu981_get_frame_index(ctx, ref);
-			width = av1_dec->frame_refs[idx].width;
-			height = av1_dec->frame_refs[idx].height;
+			buf = vb2_to_hantro_decoded_buf(&hantro_get_dst_buf(ctx)->vb2_buf);
 		}
 
 		scale_enable |=
-		    rockchip_vpu981_av1_dec_set_ref(ctx, ref, idx, width,
+		    rockchip_vpu981_av1_dec_set_ref(ctx, ref, buf, width,
 						    height);
 
 		rockchip_vpu981_av1_dec_set_sign_bias(ctx, ref,
@@ -2185,22 +2207,22 @@ rockchip_vpu981_av1_dec_set_input_buffer(struct hantro_ctx *ctx,
 static void
 rockchip_vpu981_av1_dec_set_output_buffer(struct hantro_ctx *ctx)
 {
-	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
+	const struct v4l2_ctrl_av1_frame *frame = ctx->av1_dec.ctrls.frame;
 	struct hantro_dev *vpu = ctx->dev;
 	struct hantro_decoded_buffer *dst;
-	struct vb2_v4l2_buffer *vb2_dst;
 	dma_addr_t luma_addr, chroma_addr, mv_addr = 0;
 	size_t cr_offset = rockchip_vpu981_av1_dec_luma_size(ctx);
 	size_t mv_offset = rockchip_vpu981_av1_dec_chroma_size(ctx);
 
-	vb2_dst = av1_dec->frame_refs[av1_dec->current_frame_index].vb2_ref;
-	dst = vb2_to_hantro_decoded_buf(&vb2_dst->vb2_buf);
+	dst = vb2_to_hantro_decoded_buf(&hantro_get_dst_buf(ctx)->vb2_buf);
 	luma_addr = hantro_get_dec_buf_addr(ctx, &dst->base.vb.vb2_buf);
 	chroma_addr = luma_addr + cr_offset;
 	mv_addr = luma_addr + mv_offset;
 
 	dst->av1.chroma_offset = cr_offset;
 	dst->av1.mv_offset = mv_offset;
+	dst->av1.width = frame->frame_width_minus_1 + 1;
+	dst->av1.height = frame->frame_height_minus_1 + 1;
 
 	hantro_write_addr(vpu, AV1_TILE_OUT_LU, luma_addr);
 	hantro_write_addr(vpu, AV1_TILE_OUT_CH, chroma_addr);
@@ -2228,6 +2250,8 @@ int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx)
 	rockchip_vpu981_av1_dec_clean_refs(ctx);
 	rockchip_vpu981_av1_dec_frame_ref(ctx, vb2_src->vb2_buf.timestamp);
 
+	/* Fallback references use this buffer: set it up first. */
+	rockchip_vpu981_av1_dec_set_output_buffer(ctx);
 	rockchip_vpu981_av1_dec_set_parameters(ctx);
 	rockchip_vpu981_av1_dec_set_global_model(ctx);
 	rockchip_vpu981_av1_dec_set_tile_info(ctx);
@@ -2263,7 +2287,6 @@ int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx)
 	hantro_reg_write(vpu, &av1_timeout_cycles, 0xfffffff);
 	hantro_reg_write(vpu, &av1_timeout_override_e, 1);
 
-	rockchip_vpu981_av1_dec_set_output_buffer(ctx);
 	rockchip_vpu981_av1_dec_set_input_buffer(ctx, vb2_src);
 
 	hantro_end_prepare_run(ctx);

-- 
2.55.0


