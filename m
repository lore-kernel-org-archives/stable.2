Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794733145;
	b=IPd/O7B36Rb3czUtQq6Cg4N8PO7n2h+7B4jf5Pwa55tMBldU5lU4iPjRp4ptnu5/3bAP
	 af+oK93ib6gB2gexioxMjdcxQG5PRASIgIwPEBcFghBY+X4M6Mu1ajMWElex7t/g+g04J
	 mRy/73CPU2UEC0EN9Vm06evEHQ48R7zl4a9Knl8mYv+JcuTqWSUNGxTAxVl9fE/Pq8JR2
	 z/DYIMFI5hcMdF5DsuGO+GoQn6TrlI9EkSkDKgfBqa7bIhH08hq2oLSmMjnBWexb/iOPL
	 4zNa1BttsrIeHIMpeUvkmRlQ6XGyteCXJqHhBv6HZbaxnZAMwJ/wDD/z4qkpA6q31Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733145;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q11j2VkaEM5Ovrnuja3qmq8R2hLcPNETrJC/VIRf6pY=;
	b=jDsqCUCkOgsI0MaBVauieN832xgToYiFrr+5o90UFsGHxX3Y6ZM7jKgEOwHQpfKd2x6A
	 8tsUi3Wrva9aYUKEJ8kaVW/0QdszF+ryqdhLncz+qyZ2GkCRz637oPag6kP+bwegAvmLv
	 kvZTNUYMh8vt0qr9CsHCEThYW3go1BqISBkhw9rHcW0+L7sPDdJoZAqculBLZi8fsNX5x
	 WAmNWQ/O7CjifDY0VwX3fSklokciT4EGAe0o8oUB2W6500fzfSbc8IxQ/i/ABTWDaHIG8
	 tYueVImyfXV77dDoodk2MK14VHdlXO1ZIJOb/MD7Ou7Zwv9C0qItyUKfGKqJEvnL4YA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cr2FnshP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF92606A31F;
	Sun, 15 Nov 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cr2FnshP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794733145;
	b=m7oQ71WV63qH1Kkty0AXlhJ3883xArgb9xfNJzHrKAN4AlglnoTCKb9OyO1Kmrtm5H5Q
	 0PQbDcDJTXW3Ms4J5CiytP7I4G31rRDFb2QPjvyuFWOvqgRQrtfIX4mttIDJixfY/h3ot
	 CP/D63VUH8h/9053BpjmbHBU9GvbrHsCDsmGZpYpdN68W+45Kn/2PoeQXaQ1vXflAtrIo
	 UBjY1/PHPNw4AcNK37eK6Q+/lQvuxQqbXziGkTsGtBSXNyzW/R+8Qif5x1Qi87RySuBsB
	 Sfxm2GHFrvu0HU2zyQk8YUh0MsofOPyuyN1PTX65ItPpL8ipFGdRroNCG5hXUAjcvQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794733145;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Q11j2VkaEM5Ovrnuja3qmq8R2hLcPNETrJC/VIRf6pY=;
	b=lA8XRJrTXWFJwBF3W32saXLvRfVQhd9DLajQc06zgIg0a7wfjc7usabivzhcLh5Yj8Jr
	 4p3HSJL6nR8GopyxjBWHWF/X3rjwk/Ln900dQpTjjqL8PoQsu/L7t098pk+YsZH8yADE1
	 orCrPvlc+F+KCxhFnIzDgvfCazGhb55vKaozLrkoXCLJI2t+QfOBmfegfR8CU8nNSFwZN
	 vDobt5nb9dj2SOUzQf4T3inQEXtWbr0Pmqp8JFrYQUyB7jZn8Edcnkh3oHfs/ZLlUGCsu
	 qMTsWfptkaWtO94A9HaQsrbMZXyKMNxmslEms7cpH9De17iiceVJjTF62zuFz83oP8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4DC571F000C6;
	Sun, 15 Nov 2026 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794733145;
	bh=Q11j2VkaEM5Ovrnuja3qmq8R2hLcPNETrJC/VIRf6pY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Cr2FnshP9Fc6k13kIuYEETNWOkG0AIT6IZ0KRlmZYjbK0cb/KVdZHo00yoAApImjo
	 Mo1DkR3fMgxSn2ZfA6ld7MIyKmu6VyfmynpDM7+hEyHs6ZkrAvVONJ4K/yhlzWLeRA
	 H4+VRSfHu5RTt21ipYtL8d0gCTuzQM/FAjitT+s/a9iqOqbSPKIO5kg6F/GRfmDlgS
	 npE6Nzl25uUZM+z4hiUhWzL4Gkj90tntck6CN7nSvo1+7yJuPBZu3TJoOAGZcl4CrT
	 UwGmQRIYzyAYnXbpE8a3CUW1mQBICq1oXzAPBubVxNxo83Sm3Lop3gMRkISg5g0bZV
	 TBZwEvuhzfxqA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C74E94A021;
	Sun, 15 Nov 2026 08:59:03 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sun, 15 Nov 2026 08:59:04 +0000
Subject: [PATCH 1/2] media: verisilicon: av1: Find the reference buffers by
 timestamp
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
Message-Id: <20261115-b4-vpu981-av1-refs-v1-1-c65769715db9@gmail.com>
References: <20261115-b4-vpu981-av1-refs-v1-0-c65769715db9@gmail.com>
In-Reply-To: <20261115-b4-vpu981-av1-refs-v1-0-c65769715db9@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794733143; l=5334;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=nRwuv7ZOUhXWAqCeQr6LwCeSgpkrEt0gULCQ43OMD0g=;
 b=fJ/ecB6NvRMd8bXQ6bmKJeEKmmT9WHfqmSSKsnPyxv07xVXlz8yztL4x+jkqf9S505hxoQOYL
 nhvyokCntfkAJ4B8yugDAXgNWEGwQ9EXIB0ZT9F9I7GjG3Vw+1iKM66
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
do, and use the current CAPTURE buffer and frame size when the reference
is missing.

Fixes: 727a400686a2 ("media: verisilicon: Add Rockchip AV1 decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_hw.h     |  1 -
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 37 ++++++++++++----------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 13e573f1f19d..36df8caa077d 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -287,7 +287,6 @@ struct hantro_av1_frame_ref {
 	bool used;
 	u32 order_hint;
 	u32 order_hints[V4L2_AV1_TOTAL_REFS_PER_FRAME];
-	struct vb2_v4l2_buffer *vb2_ref;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index 2a145433e6d1..59f2adf74850 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -169,7 +169,6 @@ static int rockchip_vpu981_av1_dec_frame_ref(struct hantro_ctx *ctx,
 		av1_dec->frame_refs[i].timestamp = timestamp;
 		av1_dec->frame_refs[i].frame_type = frame->frame_type;
 		av1_dec->frame_refs[i].order_hint = frame->order_hint;
-		av1_dec->frame_refs[i].vb2_ref = hantro_get_dst_buf(ctx);
 
 		for (j = 0; j < V4L2_AV1_TOTAL_REFS_PER_FRAME; j++)
 			av1_dec->frame_refs[i].order_hints[j] = frame->order_hints[j];
@@ -182,6 +181,18 @@ static int rockchip_vpu981_av1_dec_frame_ref(struct hantro_ctx *ctx,
 	return AV1_INVALID_IDX;
 }
 
+static struct vb2_buffer *rockchip_vpu981_av1_dec_ref_buf(struct hantro_ctx *ctx, int idx)
+{
+	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
+	struct vb2_queue *q = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
+	struct vb2_buffer *buf = NULL;
+
+	if (idx >= 0 && av1_dec->frame_refs[idx].used)
+		buf = vb2_find_buffer(q, av1_dec->frame_refs[idx].timestamp);
+
+	return buf ?: &hantro_get_dst_buf(ctx)->vb2_buf;
+}
+
 static void rockchip_vpu981_av1_dec_frame_unref(struct hantro_ctx *ctx, int idx)
 {
 	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
@@ -829,7 +840,7 @@ rockchip_vpu981_av1_dec_set_ref(struct hantro_ctx *ctx, int ref, int idx,
 		pr_warn("AV1 invalid reference frame index\n");
 	}
 
-	dst = vb2_to_hantro_decoded_buf(&av1_dec->frame_refs[idx].vb2_ref->vb2_buf);
+	dst = vb2_to_hantro_decoded_buf(rockchip_vpu981_av1_dec_ref_buf(ctx, idx));
 	luma_addr = hantro_get_dec_buf_addr(ctx, &dst->base.vb.vb2_buf);
 	chroma_addr = luma_addr + dst->av1.chroma_offset;
 	mv_addr = luma_addr + dst->av1.mv_offset;
@@ -894,7 +905,7 @@ static void rockchip_vpu981_av1_dec_set_segmentation(struct hantro_ctx *ctx)
 			struct hantro_decoded_buffer *seg;
 			size_t mv_offset = rockchip_vpu981_av1_dec_chroma_size(ctx);
 
-			seg = vb2_to_hantro_decoded_buf(&av1_dec->frame_refs[idx].vb2_ref->vb2_buf);
+			seg = vb2_to_hantro_decoded_buf(rockchip_vpu981_av1_dec_ref_buf(ctx, idx));
 			luma_addr = hantro_get_dec_buf_addr(ctx, &seg->base.vb.vb2_buf);
 			mv_addr = luma_addr + mv_offset;
 
@@ -1983,16 +1994,13 @@ static void rockchip_vpu981_av1_dec_set_reference_frames(struct hantro_ctx *ctx)
 
 	for (i = V4L2_AV1_REF_LAST_FRAME; i < V4L2_AV1_TOTAL_REFS_PER_FRAME; i++) {
 		u32 ref = i - 1;
-		int idx = 0;
-		int width, height;
+		int idx = AV1_INVALID_IDX;
+		int width = frame->frame_width_minus_1 + 1;
+		int height = frame->frame_height_minus_1 + 1;
 
-		if (allow_intrabc) {
-			idx = av1_dec->current_frame_index;
-			width = frame->frame_width_minus_1 + 1;
-			height = frame->frame_height_minus_1 + 1;
-		} else {
-			if (rockchip_vpu981_get_frame_index(ctx, ref) > 0)
-				idx = rockchip_vpu981_get_frame_index(ctx, ref);
+		if (!allow_intrabc)
+			idx = rockchip_vpu981_get_frame_index(ctx, ref);
+		if (idx >= 0) {
 			width = av1_dec->frame_refs[idx].width;
 			height = av1_dec->frame_refs[idx].height;
 		}
@@ -2185,16 +2193,13 @@ rockchip_vpu981_av1_dec_set_input_buffer(struct hantro_ctx *ctx,
 static void
 rockchip_vpu981_av1_dec_set_output_buffer(struct hantro_ctx *ctx)
 {
-	struct hantro_av1_dec_hw_ctx *av1_dec = &ctx->av1_dec;
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

-- 
2.55.0


