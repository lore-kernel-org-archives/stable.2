Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794295110;
	b=Zmg7g9a5LJZkr8SdaMRT9A1vq4G0svDe7LwmAJaRf0VgPzDM9Kg8O8zr7iQrnUjAPa7y
	 vJTL+GjYH6LknnKQ9zFlN2nA6pONF30FiBOMPnBYFlgQmwH82Pn11rUFiRGkY/agYFyfs
	 JvsarpQy/GRNzeGa4v/VFiM5YOw2i5+/fH13rKoorVBWybe9I+03EekXCCpt0bHrJHoJi
	 gqZB5rfoGScIkwfEGGi2Q/KOUc4UBBLonsBZRHSIDk/XWdzQdAJani3Qq+0DXvglA2n63
	 2EO6PzTSqK51iYkF//LI1cLq98hu8PFv2blxpuXQDtQ8rlEfz3athyHJVTfqxV327cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295110;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GAmODtzajJ/vJ0gUPo7wNiXWbv7xMaGq87L/wvHWZBA=;
	b=5Ip8uvxZ30KRK/rQDE/lSPr/rTUKOMGfPRng6Mrq1nq6x9xvy/y7rGsVddwsrcNuCplr
	 R7gc2mQOLHo5+/NqtnETPcmtRBW7ekxHEh8Q3v98fzQfMDrtd04a3iE71j0sc53DyqCli
	 6Kt67crSy01YbxOA0G5IzaRdPw7fC/1RL9pyxfKw2KVhN3Q/uER339cFH0nWu093iLIXr
	 GXr9+RF2ZCypjBz0jXE5rRG4tgT72S37LxXZVw9RNF8Kru1VgoXpZE70qDseggsIYdwVA
	 QyTOqtMIXHEeUxttVXQ4bQRwRCYozLJ5oh0zM1+g5hVdy70ktw87Ko0Gr5oK2tQpXGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wj7+Ewsf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B9606D623;
	Tue, 10 Nov 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wj7+Ewsf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794295109;
	b=1QiDD64C76b0rt6upO08i/6xIeEvjqT6pYhv9bgD7AY/AEOBOEFGZsK2lVJ0lqn2Om24
	 nMTRMAwMztJKbLCfHfYlpZx/dtAj04S6WXwRlw4debIL8m8h8NnZ0abj8wTvUrQ5PlnPc
	 6fVCf7e/AN77nyZRZFuOiRnji5iJA0JiR89UZTagniay6Nz2tWOPM3x9qSeFieQFQX8Mm
	 fJ+XvK7GrCgGQH9pZHdKvybRydqopwovC5E4/hMLxVfFWGSLHb6GDiQguSY72Jn1QTAmW
	 YzlRKlx6LTtcH7B+clPwAKpnXaCQMxHCVaYq8jCv480VALkEn5FyXyId3gevowSUtXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794295109;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GAmODtzajJ/vJ0gUPo7wNiXWbv7xMaGq87L/wvHWZBA=;
	b=o4qrNgouRVzNgulNglh6WEDdGOlFU3Q1FlHBAfisJi8UF4OyEldVLgQYPu1OJZDtEEn0
	 6Z9l0Fa1DhRod9bhd+feaW45vZOA720jcOb4XnjK7sSygVOMVn8ecgDIQzAigXvkOFkH5
	 iL5izbc3wsESxcHqofa5yRXLvK8EVCCYIYlksWYRkMiRy3Tz5Y1B5vPcbSkC1gdyQXXI9
	 kftKnNM2Kyp/sULNsZGYs3GM++jYO1/LJZ9jY3vRryOYxkqhZl7DX9knYMy2i1k/W6iTx
	 /JrrMYiA8NGA6Imhg8hRjiKszh1Gth6qP+7lL89MLTkddp74DMYSt3zDzrf7DZpoAJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3C72B1F008A2;
	Tue, 10 Nov 2026 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295109;
	bh=GAmODtzajJ/vJ0gUPo7wNiXWbv7xMaGq87L/wvHWZBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Wj7+EwsfY8NfJNxb0/TeN7t5Eg5Gr0HXxTiKRzaS/xm3vuqSpVnPgsHwpS9CJMReQ
	 8TWTvgW8gArdTj9G7jBc2QqJjvpeTcg982fgYhZ3gaveaIC8v3BsKPctK48fz4M1zB
	 0HQASHQtDfkRnIayQddqEaBhHg3/7+F2ph/zphXxqwmf1ZXbMyIsrrhVHO4AyJV4sf
	 k3BO3g+EuunmKry/0Gc1hxMvcS1nfJSQj37IhEyiU23F+tCvGxW1+1fPPYSxSh807u
	 JCMImdcazwnqrdC3dKY+UeQ4n1raf5JND7t9JeLPEivU0ngFX97KR7YSLsoQnZ+EVo
	 3NUhFBkzSRdJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C54C148994;
	Tue, 10 Nov 2026 07:18:27 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:18:28 +0000
Subject: [PATCH 2/4] media: verisilicon: Find the second MPEG-2 field
 without top_field_first
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
Message-Id: <20261110-hantro-codec-fixes-v1-2-0fd5372ce831@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295107; l=7659;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=I7zmqlMx+hMV7YYngac8E4NYGa6wp3wrWqDQDzG0598=;
 b=mezKjJ9P0sRKIFj0jeOHB95gv01nI5wJw/TisOgWgCvsfV9A1uv8MAlICQ8oDq5hdIp54H3J/
 PhV00iXFqeICyhh+3jOTxOpHEMWgh0mfrGkqKOZtEyo7s/USFdKzynf
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The second field of a field-coded P frame can predict from the first
field of the same frame, which is already in the destination buffer. The
G1 and VPU2 back-ends then point the reference of that parity at the
current buffer, and both back-ends tell the first field from the second
one with V4L2_MPEG2_PIC_FLAG_TOP_FIELD_FIRST: a top field is the first
field if the flag is set, a bottom field if it is not.

But top_field_first is always 0 in a field picture (ISO/IEC 13818-2,
6.3.10: "In a field picture top_field_first shall have the value '0'").
So the top field of every top-field-first frame is taken as a second
field, and predicts from the not-yet-decoded bottom field of the buffer,
while the bottom field is taken as a first field and loses its
reference to the top field. The error grows over the GOP: the field
picture conformance streams of ISO/IEC 13818-4 decoded at 6-25 dB
against FFmpeg (tcela-8, tcela-9, tcela-10, and sony-ct1/2/4 once they
switch to field pictures).

The uAPI has no flag for this, but the second field is the one of
opposite parity that follows the first with the same OUTPUT timestamp,
the two fields being decoded into one CAPTURE buffer held with
V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF. Track that in the context and use
it in both back-ends. This also replaces the VPU2 back-end's test of
V4L2_MPEG2_PIC_TOP_FIELD, a picture_structure value, against the flags.

Fixes: ceaac6dc5b7a ("media: rockchip/vpu: Add support for MPEG-2 decoding on RK3288")
Fixes: 879dee56a40c ("media: rockchip/vpu: Add MPEG2 decoding support to RK3399")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../platform/verisilicon/hantro_g1_mpeg2_dec.c     |  8 +++---
 drivers/media/platform/verisilicon/hantro_hw.h     |  8 ++++++
 drivers/media/platform/verisilicon/hantro_mpeg2.c  | 31 ++++++++++++++++++++++
 .../verisilicon/rockchip_vpu2_hw_mpeg2_dec.c       |  8 +++---
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c b/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
index 6a942f4b8a2d..5f1ce21fa6e3 100644
--- a/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
+++ b/drivers/media/platform/verisilicon/hantro_g1_mpeg2_dec.c
@@ -97,6 +97,9 @@ hantro_g1_mpeg2_dec_set_buffers(struct hantro_dev *vpu, struct hantro_ctx *ctx,
 {
 	dma_addr_t forward_addr = 0, backward_addr = 0;
 	dma_addr_t current_addr, addr;
+	bool second_field;
+
+	second_field = hantro_mpeg2_dec_second_field(ctx, pic, src_buf->timestamp);
 
 	switch (pic->picture_coding_type) {
 	case V4L2_MPEG2_PIC_CODING_TYPE_B:
@@ -126,10 +129,7 @@ hantro_g1_mpeg2_dec_set_buffers(struct hantro_dev *vpu, struct hantro_ctx *ctx,
 	/* Set forward ref frame (top/bottom field) */
 	if (pic->picture_structure == V4L2_MPEG2_PIC_FRAME ||
 	    pic->picture_coding_type == V4L2_MPEG2_PIC_CODING_TYPE_B ||
-	    (pic->picture_structure == V4L2_MPEG2_PIC_TOP_FIELD &&
-	     pic->flags & V4L2_MPEG2_PIC_FLAG_TOP_FIELD_FIRST) ||
-	    (pic->picture_structure == V4L2_MPEG2_PIC_BOTTOM_FIELD &&
-	     !(pic->flags & V4L2_MPEG2_PIC_FLAG_TOP_FIELD_FIRST))) {
+	    !second_field) {
 		vdpu_write_relaxed(vpu, forward_addr, G1_REG_REFER0_BASE);
 		vdpu_write_relaxed(vpu, forward_addr, G1_REG_REFER1_BASE);
 	} else if (pic->picture_structure == V4L2_MPEG2_PIC_TOP_FIELD) {
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 13e573f1f19d..303e42b08c40 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -171,9 +171,14 @@ struct hantro_hevc_dec_hw_ctx {
  * struct hantro_mpeg2_dec_hw_ctx
  *
  * @qtable:		Quantization table
+ * @field_ts:		OUTPUT timestamp of the last field picture decoded, if it
+ *			was the first field of a frame
+ * @field_structure:	picture_structure of that field, 0 if there is none
  */
 struct hantro_mpeg2_dec_hw_ctx {
 	struct hantro_aux_buf qtable;
+	u64 field_ts;
+	u8 field_structure;
 };
 
 /**
@@ -567,6 +572,9 @@ int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
 int rockchip_vpu2_mpeg2_dec_run(struct hantro_ctx *ctx);
 void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
 				  const struct v4l2_ctrl_mpeg2_quantisation *ctrl);
+bool hantro_mpeg2_dec_second_field(struct hantro_ctx *ctx,
+				   const struct v4l2_ctrl_mpeg2_picture *pic,
+				   u64 timestamp);
 int hantro_mpeg2_dec_init(struct hantro_ctx *ctx);
 void hantro_mpeg2_dec_exit(struct hantro_ctx *ctx);
 
diff --git a/drivers/media/platform/verisilicon/hantro_mpeg2.c b/drivers/media/platform/verisilicon/hantro_mpeg2.c
index 04e545eb0a83..e5d70c64d7a7 100644
--- a/drivers/media/platform/verisilicon/hantro_mpeg2.c
+++ b/drivers/media/platform/verisilicon/hantro_mpeg2.c
@@ -35,10 +35,41 @@ void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
 	}
 }
 
+/*
+ * Tell whether a field picture is the second field of its frame, which
+ * decides where its references are: the second field can predict from the
+ * first one, already decoded into the same buffer. top_field_first can't
+ * tell, it is always 0 in field pictures (ISO/IEC 13818-2, 6.3.10). The
+ * second field is the field of opposite parity decoded right after the
+ * first one, with the same OUTPUT timestamp.
+ */
+bool hantro_mpeg2_dec_second_field(struct hantro_ctx *ctx,
+				   const struct v4l2_ctrl_mpeg2_picture *pic,
+				   u64 timestamp)
+{
+	struct hantro_mpeg2_dec_hw_ctx *mpeg2 = &ctx->mpeg2_dec;
+	bool second;
+
+	if (pic->picture_structure == V4L2_MPEG2_PIC_FRAME) {
+		mpeg2->field_structure = 0;
+		return false;
+	}
+
+	second = mpeg2->field_structure &&
+		 mpeg2->field_structure != pic->picture_structure &&
+		 mpeg2->field_ts == timestamp;
+
+	mpeg2->field_structure = second ? 0 : pic->picture_structure;
+	mpeg2->field_ts = timestamp;
+
+	return second;
+}
+
 int hantro_mpeg2_dec_init(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
 
+	ctx->mpeg2_dec.field_structure = 0;
 	ctx->mpeg2_dec.qtable.size = ARRAY_SIZE(zigzag) * 4;
 	ctx->mpeg2_dec.qtable.cpu =
 		dma_alloc_coherent(vpu->dev,
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_mpeg2_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_mpeg2_dec.c
index 50a3a3eeaa00..57907dd5ea9c 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_mpeg2_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_mpeg2_dec.c
@@ -100,6 +100,9 @@ rockchip_vpu2_mpeg2_dec_set_buffers(struct hantro_dev *vpu,
 {
 	dma_addr_t forward_addr = 0, backward_addr = 0;
 	dma_addr_t current_addr, addr;
+	bool second_field;
+
+	second_field = hantro_mpeg2_dec_second_field(ctx, pic, src_buf->timestamp);
 
 	switch (pic->picture_coding_type) {
 	case V4L2_MPEG2_PIC_CODING_TYPE_B:
@@ -129,10 +132,7 @@ rockchip_vpu2_mpeg2_dec_set_buffers(struct hantro_dev *vpu,
 	/* Set forward ref frame (top/bottom field) */
 	if (pic->picture_structure == V4L2_MPEG2_PIC_FRAME ||
 	    pic->picture_coding_type == V4L2_MPEG2_PIC_CODING_TYPE_B ||
-	    (pic->picture_structure == V4L2_MPEG2_PIC_TOP_FIELD &&
-	     pic->flags & V4L2_MPEG2_PIC_TOP_FIELD) ||
-	    (pic->picture_structure == V4L2_MPEG2_PIC_BOTTOM_FIELD &&
-	     !(pic->flags & V4L2_MPEG2_PIC_TOP_FIELD))) {
+	    !second_field) {
 		vdpu_write_relaxed(vpu, forward_addr, VDPU_REG_REFER0_BASE);
 		vdpu_write_relaxed(vpu, forward_addr, VDPU_REG_REFER1_BASE);
 	} else if (pic->picture_structure == V4L2_MPEG2_PIC_TOP_FIELD) {

-- 
2.55.0


