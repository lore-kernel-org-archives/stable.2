Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473701;
	b=oXMKg8TcD7zB+r+UjzoFhRlVmY1oPN8lYNtjwUfLS0kAUngbwRXPNqduqdjK3f+1opKN
	 +8x/dJJ8Yn94vTG+qC5qy0Fkq9o6F0DT+ZyWs3HWaUTiQJMZ9a1ZE3dwqbxBMNQoO089e
	 KIWZlsTum7V97vygskuuD0lr/SUfjS7H47baSzO6c3J0uUawEnOHgu9k+ohdh/t33wTD7
	 i74CSL+QZFVXgTHsbFZcNrl5beI7q6MSQTDbApuJHebNAjlOukz6GsXxfVosKOftE2orh
	 NHpoTOz8G3mjLNpnoGEVxxWzSsRPTeldifL4L+xyOz1zMuCRXwIESLOZJtc7rUb5C+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473701;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1y1/WcfP5SBksAqFnL1f1IVrkMBg2fcta5eEl97OK2c=;
	b=sr72RudkwJigt3q9RgyVXughr0+k76lEnP/leSefMpZo1hvQgEyfTJUFxG+BOjouxIA7
	 sUDOJDESjI7eDH3QVkQBGRKwAXcOQNu1Nh3vS++TsCko6LrsTujEtsxuWkqweY9S7938r
	 s4zPYTkjG7fteMWpQ0dIl0Fp0ac6t/ko1iqzMRu3rtaXQtgPyhC3kXg9hBHlkncCGNnXz
	 yCSrkQGZXqI9N9Hj4a/rUpzTtwsECBjpbTfVtjEcpmUEcYp6iA3TJfNEm599KU567zStJ
	 C/Rhb/ULagMN/cwHrpvnNQsHk1MHFvi3GHpoexXOlMWH8Ro/RReJxqPtlTf6zFOxczg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1rv9F9K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599C606A33B;
	Thu, 12 Nov 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1rv9F9K
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794473701;
	b=TqyAT0bSVJnET1zYAHkuOJVFNFN34xd8/fEhByJtafQVJGM3s74MJGCOuFSPBaw9W3jv
	 7q3B/l0VORvyMOC1GCUppEKXEeW7EjTsJgkrjHtnOIa6nyZ5h4m6NZNiIukV+ShrtvTtt
	 uD7P4Y5/qYVzgLWI6zpmhLn6pgAM66E26a8yQKkn7Qb20ld31etW1EwH+9cgSugJn4wXT
	 kA+uPsJ8T7vCW3McLFQfn02NY7JpP4NrPdQzcOOKvDkmNjO+Rw3z9kF7R+71QlC1kwnJF
	 eJvLBUCA+YBVdolHxW0+c4eWBi5dJPB1UePmlHju5BtvciavMGyRMqCO1WgA/XAnEGg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794473701;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1y1/WcfP5SBksAqFnL1f1IVrkMBg2fcta5eEl97OK2c=;
	b=g6IBjbj21IflpgxWX63sPjurfhv8Vp3urdjk1ODIpCSzlcL9FTwGa5psTA5DpjTR9QCc
	 Vz9CG9B8C+N2NDT3y0+vGowGpJZqLRgC/zWiXh5Tgux2M1d+WiDBHdpqit+MiESfVYntp
	 mPrD21hXZEA2GuPVrKjEl7BfUm+B4qxWqEOTEabRB9sYglAklq1p3sM9tv88aEpKRZw99
	 kkqVO2rNGy6Pp4Kby1lU8ORQ4fdZ/cU+Orc/gKruSuKuE1SkAPJflRMoR49OG7r7MKXmD
	 ra1i6d0APcd3YIn4CsapWUsBGxpcohsy5a6ODKypui0uGSDoHTnddE3s3TICuJ+Ua0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4E1241F00A06;
	Thu, 12 Nov 2026 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473701;
	bh=1y1/WcfP5SBksAqFnL1f1IVrkMBg2fcta5eEl97OK2c=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=K1rv9F9KZJAwt+2baEnPdiImF9nV87UMfoQIu1JmHPMi1hRnPw+gazWy9rpr4cBhw
	 tdzmQ12NIQOJpfApSc9NUlNgoAngFGDi0qO5SoTUD231lo51G5JjdOPBk0hb72Q/yb
	 EmIwSfOKbiTG/2MroHZXL7vcBrbeEIoqOruOTGA3i87mv3qUfOgAdY7+doINDVAoKx
	 RnJSd7TBUkClPgf17DoBr52+V8zlms8FeUIMpha0tI2WfhhKh9uFjTiW+6qXYEV3EO
	 fFg0gEsrevqgspOh1rXrqNIib5nFikq2QbSoLR8wHSXhzJ7WCnCRGDOnOeJwban/KN
	 IXV2o82N3oqjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6A6B493D5;
	Thu, 12 Nov 2026 08:54:59 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:55:00 +0000
Subject: [PATCH] media: verisilicon: Check the CAPTURE buffer size when a
 decode job starts
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
Message-Id: <20261112-hantro-dec-size-check-v1-1-e5f1180b625f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqCQBCF4VeRuW6gHWoVXyW60PGok6CxYxGJ7
 95Wl9+B82/kSAanutgo4Wluy5wRDgXp2MwD2LpskqPEEIJwHte0cAdltzdYR+jEfdWcWqlKied
 I+XtP6O31616uf/ujvUHXb4z2/QPmcRH5eQAAAA==
X-Change-ID: 20261112-hantro-dec-size-check-f8a4b2872656
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794473699; l=5619;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=92PcgP27BM8JLOKwI+obstcAlHRvFAhAEyuDObXEIr8=;
 b=Ori6G9ZMLO2rfDUSBzAxBcY6QDgGGECnTRbCEIWdaZwdTgLlRxvwwCNM/c8P7/n3Ij3rXCnSF
 I1+5LCf6vERBaWRlQkyEWFebgvqQxnSpRimp6vkm5EIHvAsDUK9ZowW
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The CAPTURE buffers of a decoder are checked against the CAPTURE format
when they are queued, in hantro_buf_prepare(). Since commit bbd267daf4fc
("media: verisilicon: vp9: Allow to change resolution while streaming")
the format can change while buffers are allocated and queued: S_FMT on
the OUTPUT queue resets the CAPTURE format to the new size, and the
HEVC, VP9 and AV1 controls reset it when the bit depth changes (AV1 also
when film grain turns the post-processor on), the latter when the
controls of the request are applied for the job.

A CAPTURE buffer that was queued before such a change can be smaller
than the new format needs, and the decoder, or the post-processor, is
started on it with the new size all the same.

Check the buffer of the job against the CAPTURE format again when the
job starts, and return the buffers of the job with an error if it is too
small. The controls of the request have to be applied before that, so
apply them in device_run() instead of hantro_start_prepare_run(), which
every codec calls before it reads a control.

Fixes: bbd267daf4fc ("media: verisilicon: vp9: Allow to change resolution while streaming")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
This check is for all the Hantro decoders. The AV1 decoder, which is
programmed with the frame size of its controls rather than the size of
the formats, also gets a check of the frame against the CAPTURE format
in patch 6 of the series "media: verisilicon: Fix MPEG-2 field pictures,
4K VP8 and the AV1 tile buffers" v2, sent shortly before this patch. The
two patches do not depend on each other.

Tested on an Orange Pi 5 (RK3588S), on a 7.3-based tree with the patch
ported to its device_run(), which other pending series have changed. A
CAPTURE buffer is queued for a 640x368 OUTPUT format, the OUTPUT format
is then set to 1920x1088 while streaming and a request is queued: for
H.264, VP8 and MPEG-2 on the VPU121 and for AV1 on the VPU981 the
request completes with both buffers flagged V4L2_BUF_FLAG_ERROR, and so
does an AV1 request whose sequence control switches an 8-bit context to
10 bits. The fluster H.264 (JVT-AVC_V1, JVT-FR-EXT) and VP8 runs on the
VPU121 give the same per-test results as an earlier run on the same
board, and so do four fluster AV1 runs on the VPU981 (203/242). In a
fifth AV1 run av1-1-b8-06-mfmv also failed, with one decoder timeout and
no reject; it passed in the other four runs.

This patch was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit message, and I reviewed it and tested
it as described above.
---
 drivers/media/platform/verisilicon/hantro_drv.c    | 37 ++++++++++++++++++----
 .../platform/verisilicon/hantro_g1_mpeg2_dec.c     |  1 -
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..c496df1d5652 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -130,12 +130,6 @@ void hantro_watchdog(struct work_struct *work)
 
 void hantro_start_prepare_run(struct hantro_ctx *ctx)
 {
-	struct vb2_v4l2_buffer *src_buf;
-
-	src_buf = hantro_get_src_buf(ctx);
-	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
-				&ctx->ctrl_handler);
-
 	if (!ctx->is_encoder && !ctx->dev->variant->late_postproc) {
 		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
 			hantro_postproc_enable(ctx);
@@ -164,6 +158,24 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
 			      msecs_to_jiffies(2000));
 }
 
+/*
+ * The CAPTURE buffers of a decoder are checked against the CAPTURE format when
+ * they are queued, but the format can change while they are queued.
+ */
+static bool hantro_dec_dst_buf_fits(struct hantro_ctx *ctx,
+				    struct vb2_v4l2_buffer *dst)
+{
+	unsigned int i;
+
+	for (i = 0; i < ctx->dst_fmt.num_planes; i++) {
+		if (vb2_plane_size(&dst->vb2_buf, i) <
+		    ctx->dst_fmt.plane_fmt[i].sizeimage)
+			return false;
+	}
+
+	return true;
+}
+
 static void device_run(void *priv)
 {
 	struct hantro_ctx *ctx = priv;
@@ -182,6 +194,19 @@ static void device_run(void *priv)
 
 	v4l2_m2m_buf_copy_metadata(src, dst);
 
+	/*
+	 * Apply the controls of the request first: they can change the bit
+	 * depth, and with it the CAPTURE format.
+	 */
+	v4l2_ctrl_request_setup(src->vb2_buf.req_obj.req, &ctx->ctrl_handler);
+
+	if (!ctx->is_encoder && !hantro_dec_dst_buf_fits(ctx, dst)) {
+		v4l2_ctrl_request_complete(src->vb2_buf.req_obj.req,
+					   &ctx->ctrl_handler);
+		hantro_job_finish(ctx, VB2_BUF_STATE_ERROR);
+		return;
+	}
+
 	ret = ctx->codec_ops->run(ctx);
 	if (ret)
 		hantro_job_finish(ctx, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c b/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
index 6a942f4b8a2d..1cc74f52daa9 100644
--- a/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
@@ -156,7 +156,6 @@ int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx)
 	src_buf = hantro_get_src_buf(ctx);
 	dst_buf = hantro_get_dst_buf(ctx);
 
-	/* Apply request controls if any */
 	hantro_start_prepare_run(ctx);
 
 	seq = hantro_get_ctrl(ctx,

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261112-hantro-dec-size-check-f8a4b2872656

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


