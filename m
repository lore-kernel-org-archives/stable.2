Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527633;
	b=lk8rJT4cHdwQ2Fi8bM9EeccjWNniCH46B+ueXcGF6CEh+sV96k3yQs5ObGBsIZJa4Q3w
	 CA57aDq7Odkh6TbfayYgmX7mOsl5LIGaWBCc2Br6OgEfASIiph5BIIP1vC0WOzlJhrbOd
	 ZHRZXun6SVwKy/Xe4uzJQA5bxW9kLztzPerdX36NI18IErXUXRtewimdBHeCWVh29Qa+d
	 buUpff8uPCXXsvOVoh+833R8fezu1kf0iClTG9Q51IM8TPWC+uDjQfbv0TEIo8fGqp7+o
	 Oif9nI6F/V5ImR+CjLS+A046lWrocep5WD6LdDZJTuAQrNBVfoe2WL2XN3bO/L3td9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527633;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zN0w1+qLFqtq0+s8ZKdMVda+A74jQgGZWePF7NvjW/g=;
	b=pr3M3UmD6E7pb0nS+MLrXf95uyeWcXkWQAMo3O1aSphzbvAHPL49oKs7w/L6b2euPS2B
	 mdr2xo1+ue6ZXr8glplCw+beRvSg6LLFdkUf7lIlbElKY1ttvhLZnRB3smXWm9z5RFoSq
	 3NaoAxOBxz1WhcGQ8fvV7lnxg4Q7P8I1aiZZSZCVvFWwhEbhCia+BcMedAYW8i3XXBMB7
	 pGDDSXAFzvOlVlBYJ9l8+iiGGqVWdiB488a46mL3HBY0FANfnJaakpYcm2ZblYWtlg6G/
	 IlXHAmf5XYeBUCRZMdiWm7yGTNo5Js+VRQ40lmpClPllShfbunCKNtsKOdxYi+XDLNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxYtJQJl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C36606A32A;
	Tue, 24 Nov 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxYtJQJl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795527632;
	b=uL4+oO6IAhWwKgifrDsFwlKZWT1PBtgG8w9euQfJ+y7h7lW5Bb0WhPY0jJjhHHwinbl6
	 10jkhT2Tvau2E5OioCszoNzXZa7S3erd2xean5NtYYLQbnQMFxTLfjt7DkQzx7hg3CaX9
	 Z255XA4oVnYO088DiQKTdoBWE9dQiQDnPllTKdt2q9T2D4hyH1tPj8GFECIhzCpsBi3zo
	 jSB+RuoLvWvYVfCXValzfK7jNJvM/fZpDaf2oKRE9BirscPDYUCbZU0ICncp0n6qjaL/n
	 XKrRFurfBM7C60iNTlUsdXaAI7QEPg7Bxwi7kWSm1CKm9wcRuRH3a5jMqm4eWYX5THQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795527632;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zN0w1+qLFqtq0+s8ZKdMVda+A74jQgGZWePF7NvjW/g=;
	b=yFJWLTyLpExWlwsnI8OhR0uk8vlOnwzkZffWhVbD+OwWeFCgqNyfh99voBlrTH74VmuS
	 OhdiZAdDZ74p3Jl3XyvBtuXa7obhxuWow3SduWyZij4NrgBRxZGr1FID5zbqEyLCZL9eZ
	 ClW2QvWqidP9DY7MAtGntqfiX7h0cihPBZgkiJ7A9QmkgLVUX19wNAO4oYyXdZ+oj7Inf
	 8/xCokxWQClcDVXLuU/74tMa+YCbidnpVU9xozPAwVtclkIKM4No+q0yVqe/eGBqjt4oq
	 ZdnRpVJ+EhN+LLmjLudArDttMMfQ5iPcNMCnabTrLUO5zFi+MjscrgsWDlwcSNdVkNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 104A91F000D1;
	Tue, 24 Nov 2026 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527632;
	bh=zN0w1+qLFqtq0+s8ZKdMVda+A74jQgGZWePF7NvjW/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AxYtJQJl5vg21sPFcmjqJqBq0uxkIp3s7XEBw8jKDODPv0m6FdUxsJb8EdmSi0Ibq
	 eV0gKtkqCYXRsZ9il9mnZW/geyZaf+gvB0woUT3ZEVJK8UjcWi+Po21Qvzv6GY+Xwi
	 NVuh93ODFoWsaci65awpKgFMRPoCxqYi6+J5Uw9jaKcmXLW88o00nlypZOdJX4rQpu
	 KGmoun6kgp7BNy6+DF5PsvU3s+QEnfbBv7owkjmqBbZTmGNReGgOJTDAENrhN62Ejp
	 +RlsPkKka8MBAZQ01VvhMftlfMGI9kzb0N0MzSXbocZpvmsd/udQyRHSKnzPd/RaUG
	 eg0c3voxau7RA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 95E514CA63;
	Tue, 24 Nov 2026 13:40:21 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 16:40:19 +0300
Subject: [PATCH v3 3/3] media: verisilicon: leave room for the JPEG header
 and one stream burst
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
Message-Id: <20261124-hantro-buflimit-v3-3-780903970ca0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795527620; l=4102;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=TiSzcOqC25j0e7itf9kkOEO+cKiYOn5aUH2hDB8nhgU=;
 b=jW5fYvcKbkWssPYObNaxhqM72zSZMbb7b9O5FS5MeHiXeZaCt+uToeE5hT7tZlwAb6E5w6MmS
 /2PZNFVgMCDCCXe4zrVtiIAfl6r4rv5Z1iSXTCBy4U2fQf7khO2rOPZ
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

hantro_try_fmt() keeps any non-zero CAPTURE sizeimage of the JPEG
encoder, however small. The CPU writes the 624-byte header into the
plane, and on the RK3026 the H1 then writes at least one 64-byte burst
even with a stream limit of 0, so a smaller plane is written past its
end. A plane smaller than the header also makes the WARN_ON() in
hantro_h1_jpeg_enc_set_buffers() fire on every job.

Add a minimum plane size to struct hantro_fmt, set it to header_size +
64 in the JPEG encoder formats of the Rockchip and STM32MP25 variants,
and raise a smaller coded sizeimage to it in hantro_try_fmt().

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board; the assistant also drafted this change. Tested
on that board: a sizeimage of 1 or 600 now reads back 688, and frames
that do not fit a 688-byte plane stop exactly at its end. Not tested on
other SoCs.
---
 drivers/media/platform/verisilicon/hantro.h           | 2 ++
 drivers/media/platform/verisilicon/hantro_v4l2.c      | 3 +++
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c  | 1 +
 drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c | 1 +
 4 files changed, 7 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 0353de154a1e..f51beae79f1f 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -286,6 +286,7 @@ struct hantro_ctx {
  * @codec_mode:	Codec mode related to this format. See
  *		enum hantro_codec_mode.
  * @header_size: Optional header size. Currently used by JPEG encoder.
+ * @min_size:	Optional minimum sizeimage, for bitstream formats.
  * @max_depth:	Maximum depth, for bitstream formats
  * @enc_fmt:	Format identifier for encoder registers.
  * @frmsize:	Supported range of frame sizes (only for bitstream formats).
@@ -297,6 +298,7 @@ struct hantro_fmt {
 	u32 fourcc;
 	enum hantro_codec_mode codec_mode;
 	int header_size;
+	u32 min_size;
 	int max_depth;
 	enum hantro_enc_fmt enc_fmt;
 	struct v4l2_frmsize_stepwise frmsize;
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..b3dbc0629d25 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -394,6 +394,9 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 		 */
 		pix_mp->plane_fmt[0].sizeimage = fmt->header_size +
 			pix_mp->width * pix_mp->height * fmt->max_depth;
+	} else {
+		pix_mp->plane_fmt[0].sizeimage =
+			max(pix_mp->plane_fmt[0].sizeimage, fmt->min_size);
 	}
 
 	return 0;
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index d201b058e5e8..ab5abe2c78ad 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -50,6 +50,7 @@ static const struct hantro_fmt rockchip_vpu_enc_fmts[] = {
 		.codec_mode = HANTRO_MODE_JPEG_ENC,
 		.max_depth = 2,
 		.header_size = JPEG_HEADER_SIZE,
+		.min_size = JPEG_HEADER_SIZE + 64,	/* header + one burst */
 		.frmsize = {
 			.min_width = 96,
 			.max_width = 8192,
diff --git a/drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c b/drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c
index 833821120b20..3f337554e936 100644
--- a/drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c
@@ -83,6 +83,7 @@ static const struct hantro_fmt stm32mp25_venc_fmts[] = {
 		.codec_mode = HANTRO_MODE_JPEG_ENC,
 		.max_depth = 2,
 		.header_size = JPEG_HEADER_SIZE,
+		.min_size = JPEG_HEADER_SIZE + 64,	/* header + one burst */
 		.frmsize = {
 			.min_width = 96,
 			.max_width = FMT_4K_WIDTH,

-- 
2.53.0


